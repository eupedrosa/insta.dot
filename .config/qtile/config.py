# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
alt = "mod1"
ctrl = "control"
terminal = guess_terminal()

keys = [
    # Switch between windows
    Key([alt], "Tab", lazy.group.focus_back(), desc="Move window focus to other window"),

    Key([mod], "h", lazy.layout.left(),  desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(),  desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(),    desc="Move focus up"),

    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),  desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),  desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),    desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),  desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),  desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(),    desc="Grow window up"),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key([mod], "i", lazy.layout.grow()),
    Key([mod], "m", lazy.layout.shrink()),

    Key([mod], "Return", lazy.layout.swap_main(), desc="Rotate window"),

    Key([mod, "shift"], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "backslash", lazy.next_layout(), desc="Toggle between layouts"),

    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(),  desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # Key([], "F2", lazy.group['scratchpad'].dropdown_toggle('term')),

    Key([ctrl], "space", lazy.spawn("rofi_run -d"), desc="Run desktop launcher"),
    Key([mod],   "x",    lazy.spawn("rofi_run -l"), desc="Run logout"),
]

groups = [Group(i) for i in "123456"]

groups.append( ScratchPad("scratchpad", [
              # define a drop down terminal.
              # it is placed in the upper third of screen by default.
              DropDown("term", guess_terminal(),
                       x=0.2, y=0.2, width=0.6, height=0.6, opacity=0.9,
                       on_focus_lost_hide=True),
              ]))


layout_theme = {"border_width": 2,
                "margin": 4,
                "border_focus": "e1acff",
                "border_normal": "1D2330"
                }

layouts = [
    layout.MonadTall(ratio=0.6, **layout_theme),
    layout.MonadWide(ratio=0.6, **layout_theme),
    layout.Bsp(fair=False, **layout_theme),
]

colors = [["#282c34", "#282c34"], # panel background
          ["#3d3f4b", "#434758"], # background for current screen tab
          ["#ffffff", "#ffffff"], # font color for group names
          ["#ff5555", "#ff5555"], # border line color for current tab
          ["#74438f", "#74438f"], # border line color for 'other tabs' and color for 'odd widgets'
          ["#4f76c7", "#4f76c7"], # color for the 'even widgets'
          ["#e1acff", "#e1acff"]] # window name

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(scale=0.7),
                widget.GroupBox(
                   font = "UbuntuMono Nerd Font Mono",
                   hide_unused=True,
                   fontsize = 16,
                   margin_y = 3,
                   margin_x = 0,
                   padding_y = 5,
                   padding_x = 3,
                   borderwidth = 3,
                   active = colors[2],
                   inactive = colors[2],
                   rounded = False,
                   highlight_color = colors[1],
                   highlight_method = "line",
                   this_current_screen_border = colors[6],
                   this_screen_border = colors [4],
                   other_current_screen_border = colors[6],
                   other_screen_border = colors[4]),
                widget.Prompt(
                   font = "UbuntuMono Nerd Font Mono",
                   padding = 10,
                   foreground = colors[3],
                   background = colors[1]
                ),
                widget.Sep(
                    linewidth = 0,
                    padding = 6,
                    ),
                widget.WindowName(
                    # foreground = colors[6],
                    background = colors[0],
                    padding = 0),
                widget.CPUGraph(
                    samples=30,
                    line_width=1,
                    graph_color= colors[2],
                    fill_color = colors[2],
                    margin_x = 0,
                    border_width=0,
                    ),
                widget.CPU(
                    format = '{freq_current} GHz',
                    background = colors[0]),
                widget.TextBox(
                    text = "",
                    foreground = colors[4],
                    padding = 0,
                    fontsize = 24),
                widget.MemoryGraph(
                    width = 40,
                    samples = 30,
                    line_width = 1,
                    border_width=0,
                    graph_color= colors[2],
                    fill_color = colors[2],
                    background = colors[4]),
                widget.Memory(background = colors[4]),
                widget.Sep(
                    linewidth = 0,
                    padding = 6,
                    foreground = colors[0],
                    background = colors[4]),
                   widget.TextBox(
                       text = "",
                       background = colors[4],
                       foreground = colors[5],
                       padding = 0,
                       fontsize = 24),
                widget.TextBox(
                    text = "",
                    fontsize = 16,
                    background = colors[5]),
                widget.Backlight(
                    backlight_name='intel_backlight',
                    background = colors[5]),
                widget.TextBox(
                    text = "",
                    background = colors[5],
                    foreground = colors[1],
                    padding = 0,
                    fontsize = 24),
                widget.Systray(
                    background = colors[1],
                    padding = 5),
                widget.Clock(
                    format='%b %Y, %a %H:%M',
                    padding=10,
                    foreground = colors[2],
                    background = colors[1]),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod],  "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod],  "Button3", lazy.window.set_size_floating(),     start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# If a window requests to be fullscreen, it is automatically fullscreened.
# Set this to false if you only want windows to be fullscreen if you ask them to be.
auto_fullscreen = True

# When clicked, should the window be brought to the front or not.
# If this is set to “floating_only”, only floating windows will get affected
# (This sets the X Stack Mode to Above.)
bring_front_click = False

# If true, the cursor follows the focus as directed by the keyboard,
# warping to the center of the focused window.
# When switching focus between screens, if there are no windows in the screen,
# the cursor will warp to the center of the screen.
cursor_warp = False

# A function which generates group binding hotkeys.
# It takes a single argument, the DGroups object, and can use that to set up dynamic key bindings.
def group_key_binder(mod):
    def func(dgroup):
        # unbind all
        for key in dgroup.keys[:]:
            dgroup.qtile.ungrab_key(key)
            dgroup.keys.remove(key)

        keys = list(map(str, list(range(1,10))))
        for keyname, group in zip(keys, dgroup.qtile.groups):
            name = group.name
            k0 = Key([mod], keyname, lazy.group[name].toscreen())
            k1 = Key([mod, "shift"], keyname, lazy.window.togroup(name, switch_group=True))

            for k in [k0, k1]:
                dgroup.keys.append(k)
                dgroup.qtile.grab_key(k)

    return func

dgroups_key_binder = group_key_binder(mod)

# A list of Rule objects which can send windows to various groups based on matching criteria.
dgroups_app_rules = []

# Default settings for extensions.
extension_defaults = None

# The default floating layout to use. This allows you to set custom floating rules
# among other things if you wish.
floating_layout = layout.Floating(float_rules=[
    *layout.Floating.default_float_rules,
    # Run the utility of `xprop` to see the wm class and name of an X client.
    Match(wm_class='xfce4-display-settings'),
], **layout_theme)

# Behavior of the _NET_ACTIVATE_WINDOW message sent by applications.
focus_on_window_activation = "smart"

# Controls whether or not focus follows the mouse around as it moves across windows in a layout.
follow_mouse_focus = True

# Default settings for bar widgets.
widget_defaults = dict(
    font ='sans',
    fontsize = 12,
    padding  = 3,
    background = colors[0],
    foreground = colors[2],
)

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

# Hooks

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart'])

@hook.subscribe.client_new
def set_floating(window):
    if window.window.get_wm_transient_for():
        window.floating = True
