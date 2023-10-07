# ================================= #
# --------------------------------- #
# -- Dunkmania101's Qtile Config -- #
# --------------------------------- #
# ================================= #


import os, subprocess, imaplib, re #, datetime #, gi
#gi.require_version("Gdk", "3.0")
#from gi.repository import Gdk
from json import loads as jloads #, dumps as jdumps
from time import sleep
from shutil import which
from threading import Thread
from random import choice
from typing import Union
#from requests import get as get_request
from libqtile import qtile, layout, hook, bar, widget, extension
from libqtile.backend.x11.core import get_keys
# from libqtile.backend.wayland.core import keyboard as wl_kbd
from libqtile.config import Key, KeyChord, Drag, Screen, Match, Group, ScratchPad, DropDown #, Click
from libqtile.widget import base as widget_base
from libqtile.lazy import lazy


# --------------------- #
# -- Basic Functions -- #
# --------------------- #


def expand_full_path(path: str = "~") -> str:
    return os.path.expandvars(os.path.expanduser(path))

def shcmd_exists(cmd: str) -> bool:
    return which(cmd) is not None

def _sub_run_cmd(cmd: str, cwd: str | None = None) -> None:
    try:
        subprocess.run(cmd, cwd=cwd, shell=True)
    except Exception as e:
        qtile.logger.warning(e)
        print(str(e))
        pass

def run_cmd(cmd: str, cwd: str | None = None, thread: bool = True) -> None:
   if thread:
        Thread(target=_sub_run_cmd, args=(cmd, cwd,)).start()
   else:
       _sub_run_cmd(cmd, cwd)

def get_cmd_output(cmd: str, cwd: str | None = None) -> str:
    output = ""
    try:
        output = str(subprocess.run(cmd, cwd=cwd, shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8'))
    except Exception as e:
        print(str(e))
        pass
    return output

def exec_func_no_qtile(_, func, args):
    if callable(func):
        return func(*args)


def is_wayland() -> bool:
    return qtile.core.name == "wayland"


def gen_jgmenu_cmd(fmt: str = "uxterm") -> str:
    return f"echo \'{fmt}\' | jgmenu --simple"


global force_auto_group_all
force_auto_group_all: tuple[str | int, bool] | None = None

def set_force_auto_group_all(group: str | int | None, follow: bool = True):
    if group is None:
        force_auto_group_all = group
    else:
        force_auto_group_all = group, follow

def clear_force_auto_group_all(_ = None):
    set_force_auto_group_all(None)

def set_current_force_auto_group_all(qtile, follow: bool = True):
    set_force_auto_group_all(get_current_group_name(qtile), follow)

def set_current_force_auto_group_all_follow(qtile):
    set_current_force_auto_group_all(get_current_group_name(qtile), True)

def set_current_force_auto_group_all_nofollow(qtile):
    set_current_force_auto_group_all(get_current_group_name(qtile), False)


# -------------------- #
# -- Base Variables -- #
# -------------------- #


cfg_dir = expand_full_path("~/.config/qtile")
#run_cmd(cfg_dir + "/autostart.sh")
rofi_dir = cfg_dir + "/rofi"
env_file = expand_full_path("~/.private/data/env.json")
env_data = {}
if os.path.isfile(env_file):
    with open(env_file, "r") as f:
        try:
            env_data = jloads(f.read())
        except:
            pass


# Themes

my_font = "Iosevka"
#my_term_font = "Iosevka Term"
my_term_font = "Iosevka"

char_left_bend = "\ue0b6"
char_right_bend = "\ue0b4"

#segment_bars = True
segment_bars = False

my_color_theme = "gruvbox_dark" # "one_dark" or "gruvbox_dark" or "everforest_dark"

invisible_color = ["#00000000", "#00000000", "#00000000"]
if my_color_theme == "one_dark":
    # One Dark
    bg_color = "#282c34"
    fg_color = "#5c6370"
    dark_bg_color = "#222222"
    bg_line_color = "#4b4263"
    fg_line_color = "#425370"
    bg_line_color_alt = "#504d6d"
    fg_line_color_alt = "#618fef"
    bg_txt_color = "#414f4f"
    fg_txt_color = "#abb2bf"
    green_color = "#504945"
    blue_color = "#61afef"
    cyan_color = "#55b6c2"
    red_color = "#cc241d"
elif my_color_theme == "everforest_dark":
    # Everforest Dark
    bg_color = "#2b3339"
    fg_color = "#a3967a"
    dark_bg_color = "#222222"
    bg_line_color = "#3c3836"
    fg_line_color = "#7a8478"
    bg_line_color_alt = "#4e3e43"
    fg_line_color_alt = "#e69875"
    bg_txt_color = "#413c32"
    fg_txt_color = "#d3c6aa"
    green_color = "#a7c080"
    blue_color = "#7fbbb3"
    cyan_color = "#83c092"
    red_color = "#e67e80"
else:
    # Gruvbox-ish Dark
    bg_color = "#24221B"
    fg_color = "#4f443a"
    dark_bg_color = "#222222"
    bg_line_color = "#3c3836"
    fg_line_color = "#4f443a"
    bg_line_color_alt = "#aa5000"
    fg_line_color_alt = "#ff8000"
    bg_txt_color = "#3c3836"
    fg_txt_color = "#ebdbb2"
    green_color = "#687b01"
    blue_color = "#61afef"
    #blue_color = "#7daea3"
    #blue_color = "#59614c"
    #blue_color = "#61afef"
    cyan_color = "#89b482"
    red_color = "#cc241d"


# Base Groups (copied to each monitor)
my_base_groups = "1 2 3 4 5 6 7 8 9 0".split(" ")

# Screen to put the systray widget on
my_systray_screen = 0

# Speeds
my_fast_update_interval = 0.1
my_slow_update_interval = 0.3

# Gap and border sizes
bar_height = 30
my_thick_border_width = 3
my_thin_border_width = 2
my_thick_margin = 4
my_thin_margin = 2
my_thick_font_size = 14
my_normal_font_size = 11
my_tiny_font_size = 9

# Directories
my_wallpapers: str = expand_full_path("~/Wallpapers") # Can point to a directory or a single image file.
my_screenshots_dir: str = expand_full_path("~/Pictures/Screenshots")

# Details
draw_wallpaper: bool = True
draw_wallpaper_img: bool = True # False for my_solid_wallpaper_cmd
my_solid_wallpaper_cmd: str = f"xsetroot -solid '{bg_color}'"
my_distro: str = "Arch"
#my_check_updates_cmd: Union[str, None] = None
my_check_updates_cmd: Union[str, None] = ""
if shcmd_exists("pip"):
    my_check_updates_cmd += "; pip list --outdated --format=freeze"
if shcmd_exists("paru"):
    my_check_updates_cmd += "; paru --query --upgrades"
if shcmd_exists("guix"):
    my_check_updates_cmd += "; guix refresh"

if is_wayland():
    my_get_monitors_cmd: str = "wlr-randr"
else:
    my_get_monitors_cmd: str = "xrandr --query | grep \" connected\" | cut -d\" \" -f1"
# Accounts
my_gmail_username = env_data.get("gmail.username", "")
my_gmail_pass = env_data.get("gmail.pass", "")
# Locale
my_locale = env_data.get("locale", {})
if isinstance(my_locale, dict):
    my_city = my_locale.get("city", "")
else:
    my_city = None

# Input Simulation
my_kbd_key_cmd = "xdotool key --window -- "
my_kbd_type_cmd = "xdotool type --window -- "

my_mouse_move_cmd = "xdotool mousemove_relative -- "
my_mouse_move_dist = "10"
my_mouse_click_cmd = "xdotool click "

my_lock_device_cmd = "loginctl lock-session & playerctl --all-players pause & amixer set Master mute; sleep 0.5; xset dpms force standby"

# Applications
#my_terminal = "kitty -e tmux"
#my_terminal_tmux = f"kitty -e \'{cfg_dir}/scripts/run/run-tmux-session.sh\'"
my_terminal = "tilix"
#my_terminal = "kitty"
#my_terminal = "contour"
#my_terminal = f"uxterm -si -fs 10 -fa \"{my_term_font}\" -bg \'#212121\' -bd \'#212111\'"
#my_terminal_alt = "kitty"
my_terminal_alt = f"uxterm -si -fs {my_normal_font_size} -fa \'{my_term_font}\' -bg \'#212121\' -bd \'#212111\'"
#my_terminal_alt = "st"
#my_terminal_alt = "cool-retro-term"
#my_terminal_alt = "darktile"
#my_terminal_alt = "extraterm"
#my_terminal_alt1 = "kitty -e tmux"
#my_terminal_alt1 = "kitty"
my_terminal_alt1 = "cool-retro-term"
#my_terminal_alt2 = "extraterm"
my_terminal_alt2 = "wezterm"
my_terminal_alt3 = "urxvt"
my_terminal_alt4 = f"uxterm -si -fa \"{my_font}\""
my_terminal_light = f"uxterm -si -fs {my_tiny_font_size} -fa \'{my_term_font}\' -bg \'#212121\' -bd \'#212111\'"
my_terminal_popup = my_terminal_light

#my_editor = cfg_dir + "/scripts/run/run-emacs.sh"
#my_editor = "emacs"
my_editor = "emacsclient -a '' -c"
my_editor_alt = "geany"
#my_editor_alt = "neovide --multigrid"
#my_editor_alt = "vscodium"
# my_editor_alt = "notepadqq"
my_editor_alt1 = "emacs"
my_editor_alt2 = "kitty zsh -c \'source ~/.zshrc; nvim\'"

my_browser = "nyxt -S"
#my_browser_alt = expand_full_path("~/.nix-profile/bin/vivaldi")
#my_browser_alt = "firefox-developer-edition"
#my_browser_alt = "firefox"
my_browser_alt = "librewolf"
#my_browser_alt = "vivaldi"
#my_browser_alt = "vivaldi-stable"
my_browser_alt1 = "firedragon"
my_browser_alt2 = "qutebrowser"
# my_browser_alt2 = "min"
# my_browser_alt2 = "luakit"
my_browser_alt3 = "brave-beta"

my_private_browser = "nyxt --data-profile nosave"
#my_private_browser_alt = "vivaldi --incognito"
#my_private_browser_alt = "vivaldi-stable --incognito"
my_private_browser_alt = "firefox-developer-edition --private-window"

my_browser_profile_menu = rofi_dir + "/nyxt_profile_menu/nyxt_profile_menu.sh"

my_file_manager = "nemo"
#my_file_manager = "nautilus"
#my_file_manager = "pcmanfm"
my_file_manager_alt = "pcmanfm"
my_file_manager_alt1 = "filezilla"
#my_file_manager_alt1 = "thunar"

my_passwd_manager = "keepassxc"
my_passwd_manager_alt = "passmenu"

#my_mp = "deadbeef"
#my_mp = "kawaii-player"
#my_mp = "lollypop"
my_mp = "celluloid"
#my_mp = rofi_dir + "/mpvselect/mpvselect.sh"
my_mp_alt = rofi_dir + "/ytfzf/ytfzf.sh --savefile"
#my_mp_alt1 = rofi_dir + "/ytfzf/ytfzf.sh"
my_mp_alt1 = rofi_dir + "/mpvselect/mpvselect.sh"
#my_mp_alt1 = rofi_dir + "/notflix/notflix.sh"
my_mp_alt2 = "freetube"
#my_mp_alt = "motionbox"
#my_mp_alt = "freetube"
#my_mp_alt = "vlc"

#my_mp_private = rofi_dir + "/mpvselect/mpvselect.sh"
my_mp_private = rofi_dir + "/mpvselect/mpvselect.sh --nosave"
my_mp_private_alt = rofi_dir + "/ytfzf/ytfzf.sh"

my_package_manager = "pamac-manager"
my_package_manager_alt = "pamac-manager"

my_calculator = "qalculate-gtk"
my_calculator_alt = "galculator"

my_control_panel = my_terminal_popup + " -e btop"
my_control_panel_alt = "system-monitoring-center"
my_control_panel_alt1 = "stacer"

my_audio_mixer = my_terminal + " -e pulsemixer"
my_audio_mixer_alt = "easyeffects"
my_audio_mixer_alt1 = my_terminal + " -e alsamixer"

# Menus (Rofi Scripts, etc...)
my_launcher = rofi_dir + "/launcher/launcher.sh"
my_launcher_alt = "synapse"
#my_launcher_alt = "jgmenu"
my_clipmenu = rofi_dir + "/clipmenu/clipmenu.sh"
my_clipmenu_alt = "copyq toggle"
my_powermenu = rofi_dir + "/powermenu/powermenu.sh"
my_handy = rofi_dir + "/handy/handy.sh"
my_window_pager = rofi_dir + "/window/window.sh"
my_player_ctrl = rofi_dir + "/player/player.sh"
my_workspaces = rofi_dir + "/workspaces/workspaces.sh"
my_emoji = rofi_dir + "/emoji/emoji.sh"

#my_window_killer = f"{my_terminal} -e xkill"
my_window_killer = "xkill"

my_notification_show = "wired --show 1"
my_notification_drop = "wired --drop latest"


# ---------- #
# -- Keys -- #
# ---------- #


left = "Left"
right = "Right"
up = "Up"
down = "Down"
sup = "mod4"
alt = "mod1"
ctrl = "control"
shift = "shift"
space = "space"
ret = "Return"
tab = "Tab"
grave = "grave"
semicolon = "semicolon"
apostrophe = "apostrophe"
period = "period"
comma = "comma"
minus = "minus"
equal = "equal"
# quote = "quoteright"


monitors = get_cmd_output(my_get_monitors_cmd).split("\n")
#gdkdsp = Gdk.Screen.get_default()
#monitors = [gdkdsp.get_monitor_plug_name(i) for i in range(gdkdsp.get_n_monitors())]


def take_screenshot(cmd: str = "scrot", cwd: str = my_screenshots_dir) -> None:
    _cwd = expand_full_path(cwd)
    if not os.path.isdir(_cwd):
        os.makedirs(_cwd)
    run_cmd(cmd, _cwd)


def get_screen_bars(screen: Screen) -> list[bar.Bar]:
    return [g for g in screen.gaps if isinstance(g, bar.Bar)]


def reload_only_bars(qtile) -> None:
    for s in qtile.screens:
        for b in get_screen_bars(s):
            b.show(); b.show()


def run_keysboard(start: bool = True) -> None:
    if start:
        run_cmd(cfg_dir + "/scripts/run/run-keysboard.sh")
    else:
        run_cmd('tmux kill-session -t keysboard-bar; rm -f /tmp/tmux-bar-keysboard-pipe')


def run_kmonad(start: bool = True) -> None:
    if start:
        run_cmd(cfg_dir + "/scripts/run/run-kmonad.sh")
    else:
        run_cmd('tmux kill-session -t kmonad-bar; rm -f /tmp/tmux-bar-kmonad-pipe')


#def run_plank(start: bool = True) -> None:
#    if start:
#        for _ in monitors:
#            run_cmd(f"plank")
#    else:
#        run_cmd("killall -q plank")


# ------------------------------ #
# -- Binds & Functions Galore -- #
# ------------------------------ #


def is_win_in_classes(window, classes, require_all: bool = False, provide_first_index: bool = False) -> tuple[bool, int | None]:
    wcs = window.window.get_wm_class()
    q = lambda : (c in classes for c in wcs)
    if provide_first_index:
        r = is_win_in_classes(window, classes, require_all, provide_first_index=False)
        if r:
            i = min([classes.index(c) for c in wcs if c in classes], default=None)
        else:
            i = None
        return r is True, i
    else:
        return all(q()) if require_all else any(q()), None

def get_full_group_name(screen_name, base_name) -> str:
    return f"{screen_name}:{base_name}"

def get_full_group_names_for_screen(i: int) -> list[str]:
    return [get_full_group_name(i, g) for g in my_base_groups]

def get_current_screen_index(qtile) -> int:
    return qtile.screens.index(qtile.current_screen)

def get_screen_index_by_offset(qtile, offset: int = 1) -> int:
    return (get_current_screen_index(qtile) + offset) % len(qtile.screens)

def get_group_index(qtile, group) -> int:
    return qtile.groups.index(group)

def get_group_name(qtile, group) -> str:
    return list(qtile.groups_map.keys())[get_group_index(qtile, group)]

def get_current_group_index(qtile) -> int:
    return get_group_index(qtile, qtile.current_group)

def get_current_group_name(qtile) -> str:
    return get_group_name(qtile, qtile.current_group)

def get_group_by_name(qtile, group: str) -> Group:
    return qtile.groups_map.get(group)

def get_group_by_index(qtile, i: int) -> Group:
    return qtile.groups.get(i)

def get_current_group_index_on_current_screen(qtile) -> int:
    return get_current_group_index(qtile) - ((len(qtile.screens) * len(my_base_groups)))

def get_group_name_on_current_screen(qtile, group: Group) -> str:
    return get_full_group_name(get_current_screen_index(qtile), group)

def get_group_index_on_current_screen_by_offset(qtile, offset: int = 1) -> int:
    return ((get_current_group_index_on_current_screen(qtile) + offset) % len(my_base_groups)) + (len(my_base_groups) * get_current_screen_index(qtile))

def get_group_on_current_screen_by_offset(qtile, offset: int = 1) -> Group:
    return qtile.groups[get_group_index_on_current_screen_by_offset(qtile, offset)]


def set_screen(qtile, screen: int, move_focus: bool = True, move_window: bool = True) -> None:
    if move_window:
        qtile.current_window.cmd_toscreen(screen)
    if move_focus:
        qtile.cmd_to_screen(screen)

def cycle_screen(qtile, offset: int = 1, move_focus: bool = True, move_window: bool = True) -> None:
    set_screen(qtile, get_screen_index_by_offset(qtile, offset), move_focus, move_window)


def set_current_screen_group(qtile, group: str, toggle:bool = True) -> None:
    if toggle:
        qtile.current_screen.cmd_toggle_group(group)
    else:
        qtile.current_screen.set_group(get_group_by_name(qtile, group))

def set_current_screen_group_on_current_screen(qtile, group: Group, toggle: bool = True) -> None:
    set_current_screen_group(qtile, get_group_name_on_current_screen(qtile, group), toggle)

def set_current_screen_group_on_current_screen_no_toggle(qtile, group: Group) -> None:
    set_current_screen_group_on_current_screen(qtile, group, toggle=False)

def set_current_screen_group_by_offset(qtile, offset: int = 1) -> None:
    set_current_screen_group(qtile, get_group_on_current_screen_by_offset(qtile, offset).name)


def send_win_to_group(qtile, window, group: str, switch_group: bool = True) -> None:
    window.togroup(group, switch_group=switch_group)

def send_current_win_to_group(qtile, group: str, switch_group: bool = True) -> None:
    send_win_to_group(qtile, qtile.current_window, group, switch_group)

def send_current_win_to_group_on_current_screen_switch(qtile, group: Group) -> None:
    send_current_win_to_group(qtile, get_group_name_on_current_screen(qtile, group))

def send_current_win_to_group_on_current_screen_noswitch(qtile, group: Group) -> None:
    send_current_win_to_group(qtile, get_group_name_on_current_screen(qtile, group), False)


def win_cycle_group_next_switch(qtile) -> None:
    send_current_win_to_group(qtile, get_group_on_current_screen_by_offset(qtile).name, switch_group=True)

def win_cycle_group_prev_switch(qtile) -> None:
    send_current_win_to_group(qtile, get_group_on_current_screen_by_offset(qtile, -1).name, switch_group=True)

def win_cycle_group_next_noswitch(qtile) -> None:
    send_current_win_to_group(qtile, get_group_on_current_screen_by_offset(qtile).name, switch_group=False)

def win_cycle_group_prev_noswitch(qtile) -> None:
    send_current_win_to_group(qtile, get_group_on_current_screen_by_offset(qtile, -1).name, switch_group=False)


def cycle_screen_next(qtile) -> None:
    cycle_screen(qtile, 1, True, False)

def cycle_screen_prev(qtile) -> None:
    cycle_screen(qtile, -1, True, False)


def swap_current_screen(qtile, offset: int = 1) -> None:
    i = get_current_screen_index(qtile)
    o = i+offset
    if o >= len(qtile.screens):
        o = len(qtile.screens) % o
    qtile.screens[i], qtile.screens[o] = qtile.screens[o], qtile.screens[i]
    qtile.cmd_reconfigure_screens()

def swap_current_screen_next(qtile) -> None:
    swap_current_screen(qtile)

def swap_current_screen_prev(qtile) -> None:
    swap_current_screen(qtile, -1)


def cycle_group_next(qtile) -> None:
    set_current_screen_group_by_offset(qtile)

def cycle_group_prev(qtile) -> None:
    set_current_screen_group_by_offset(qtile, -1)


def win_cycle_screen_next_switch(qtile) -> None:
    cycle_screen(qtile, 1, True, True)

def win_cycle_screen_prev_switch(qtile) -> None:
    cycle_screen(qtile, -1, True, True)

def win_cycle_screen_next_noswitch(qtile) -> None:
    cycle_screen(qtile, 1, False, True)

def win_cycle_screen_prev_noswitch(qtile) -> None:
    cycle_screen(qtile, -1, False, True)

def win_toggle_minimize(qtile) -> None:
    qtile.current_window.cmd_toggle_minimize()


# ----------


keys = [
    # Menus
    Key([sup], space, lazy.spawn(my_launcher)),
    Key([sup, shift], space, lazy.run_extension(
        extension.DmenuRun(
            foreground=fg_color,
            background=bg_color,
            selected_foreground=fg_txt_color,
            selected_background=bg_txt_color,
            font=my_font,
            fontsize=my_thick_font_size,
            dmenu_ignorecase=True,
            dmenu_lines=None,
        )
    )),
    #Key([sup, alt], space, lazy.spawn(my_launcher_alt)),
    Key([sup], tab, lazy.spawn(my_window_pager)),
    #Key([sup], tab, lazy.run_extension(
    #    extension.WindowList(
    #        foreground=fg_color,
    #        background=bg_color,
    #        selected_foreground=fg_txt_color,
    #        selected_background=bg_txt_color,
    #        font=my_font,
    #        fontsize=my_thick_font_size,
    #        dmenu_ignorecase=True,
    #        dmenu_lines=None,
    #    )
    #)),
    Key([sup, shift], tab, lazy.run_extension(
        extension.WindowList(
            all_groups=False,
            foreground=fg_color,
            background=bg_color,
            selected_foreground=fg_txt_color,
            selected_background=bg_txt_color,
            font=my_font,
            fontsize=my_thick_font_size,
            dmenu_ignorecase=True,
            dmenu_lines=None,
        )
    )),
    #Key([sup, alt], tab, lazy.spawn(my_window_pager)),
    #Key([sup, shift], tab, lazy.spawn(my_window_pager)),
    Key([sup], "v", lazy.spawn(my_clipmenu)),
    Key([sup, shift], "v", lazy.spawn(my_clipmenu_alt)),
    Key([sup], "q", lazy.spawn(my_powermenu)),
    Key([sup], "p", lazy.spawn(my_player_ctrl)),
    Key([sup], "y", lazy.spawn(my_workspaces)),
    #Key([sup], "r", lazy.spawn(my_handy)),
    Key([sup], "i", lazy.spawn(my_emoji)),

    # Window / Layout Management
    Key([sup], "f", lazy.window.toggle_fullscreen()),
    Key([sup], "f", lazy.window.toggle_fullscreen()),
    Key([sup], "t", lazy.window.toggle_floating()),
    Key([sup], "r", lazy.function(win_toggle_minimize)),
    Key([sup], "F4", lazy.window.kill()),
    Key([sup, shift], "F4", lazy.spawn(my_window_killer)),
    Key([sup, shift], "q", lazy.window.kill()),
    Key([sup, ctrl], "q", lazy.spawn(my_window_killer)),

    Key([sup], "j", lazy.layout.down()),
    Key([sup], "k", lazy.layout.up()),
    Key([sup], "h", lazy.layout.left()),
    Key([sup], "l", lazy.layout.right()),
    Key([sup, alt], "j", lazy.layout.shuffle_down()),
    Key([sup, alt], "k", lazy.layout.shuffle_up()),
    Key([sup, alt], "h", lazy.layout.shuffle_left()),
    Key([sup, alt], "l", lazy.layout.shuffle_right()),
    Key([sup, shift], "j", lazy.layout.grow_down()),
    Key([sup, shift], "k", lazy.layout.grow_up()),
    Key([sup, shift], "h", lazy.layout.grow_left()),
    Key([sup, shift], "l", lazy.layout.grow_right()),
    Key([sup, alt, shift], "h", lazy.layout.swap_column_left()),
    Key([sup, alt, shift], "l", lazy.layout.swap_column_right()),
    Key([sup], "g", lazy.layout.toggle_split()),
    Key([sup, shift], "g", lazy.layout.normalize()),
    Key([sup, alt], "g", lazy.function(set_current_force_auto_group_all)),
    Key([sup, alt, shift], "g", lazy.function(clear_force_auto_group_all)),

    # Key([sup], left, lazy.layout.shrink_main()),
    # Key([sup], right, lazy.layout.grow_main()),
    # Key([sup], down, lazy.layout.down()),
    # Key([sup], up, lazy.layout.up()),
    # Key([sup, shift], down, lazy.layout.shuffle_down()),
    # Key([sup, shift], up, lazy.layout.shuffle_up()),

    # Key([sup], "h", lazy.layout.shrink_main()),
    # Key([sup], "l", lazy.layout.grow_main()),
    # Key([sup], "j", lazy.layout.down()),
    # Key([sup], "k", lazy.layout.up()),
    # Key([sup, shift], "j", lazy.layout.shuffle_down()),
    # Key([sup, shift], "k", lazy.layout.shuffle_up()),

    # Groups
    # Key([sup], "n", lazy.screen.prev_group()),
    # Key([sup], "m", lazy.screen.next_group()),
    Key([sup], "n", lazy.function(cycle_group_prev)),
    Key([sup], "m", lazy.function(cycle_group_next)),
    Key([sup, alt], "n", lazy.function(win_cycle_group_prev_switch)),
    Key([sup, alt], "m", lazy.function(win_cycle_group_next_switch)),
    Key([sup, shift, alt], "n", lazy.function(win_cycle_group_prev_noswitch)),
    Key([sup, shift, alt], "m", lazy.function(win_cycle_group_next_noswitch)),
    Key([sup, ctrl], "n", lazy.function(cycle_screen_prev)),
    Key([sup, ctrl], "m", lazy.function(cycle_screen_next)),
    Key([sup, ctrl, alt], "n", lazy.function(win_cycle_screen_prev_switch)),
    Key([sup, ctrl, alt], "m", lazy.function(win_cycle_screen_next_switch)),
    Key([sup, shift, ctrl, alt], "n", lazy.function(win_cycle_screen_prev_noswitch)),
    Key([sup, shift, ctrl, alt], "m", lazy.function(win_cycle_screen_next_noswitch)),
    Key([sup, shift, ctrl], "n", lazy.function(swap_current_screen_prev)),
    Key([sup, shift, ctrl], "m", lazy.function(swap_current_screen_next)),


    # WM Cmds
    Key([sup, ctrl, shift, alt], "q", lazy.shutdown()),
    Key([sup, shift], "r", lazy.restart()),
    KeyChord([sup, ctrl, shift], "r", [
        Key([], "r", lazy.restart()),
        Key([], "b", lazy.function(reload_only_bars)),
        Key([], "c", lazy.reload_config()),
    ],),

    # Vim Emulation
    KeyChord([sup, ctrl, shift], "v", [
        Key([], "i", lazy.spawn(my_kbd_key_cmd + "Escape")),
        Key([], "h", lazy.spawn(my_kbd_key_cmd + "Left")),
        Key([], "j", lazy.spawn(my_kbd_key_cmd + "Down")),
        Key([], "k", lazy.spawn(my_kbd_key_cmd + "Up")),
        Key([], "l", lazy.spawn(my_kbd_key_cmd + "Right")),
        Key([], "w", lazy.spawn(my_kbd_key_cmd + "ctrl+Right")),
        Key([], "b", lazy.spawn(my_kbd_key_cmd + "ctrl+Left")),
    ], mode=True, name="vim"),

    # Mouse Emulation
    Key([sup, ctrl], "h", lazy.spawn(my_mouse_move_cmd + f"-{my_mouse_move_dist} 0")),
    Key([sup, ctrl], "j", lazy.spawn(my_mouse_move_cmd + f"0 {my_mouse_move_dist}")),
    Key([sup, ctrl], "k", lazy.spawn(my_mouse_move_cmd + f"0 -{my_mouse_move_dist}")),
    Key([sup, ctrl], "l", lazy.spawn(my_mouse_move_cmd + f"{my_mouse_move_dist} 0")),
    Key([sup, ctrl], "a", lazy.spawn(my_mouse_click_cmd + "1")), # LC
    Key([sup, ctrl], "d", lazy.spawn(my_mouse_click_cmd + "3")), # RC
    Key([sup, ctrl], "x", lazy.spawn(my_mouse_click_cmd + "2")), # MC
    Key([sup, ctrl], "s", lazy.spawn(my_mouse_click_cmd + "5")), # WU
    Key([sup, ctrl], "w", lazy.spawn(my_mouse_click_cmd + "4")), # WD
    KeyChord([sup, ctrl, shift], "a", [
        Key([], "h", lazy.spawn(my_mouse_move_cmd + f"-{my_mouse_move_dist} 0")),
        Key([], "j", lazy.spawn(my_mouse_move_cmd + f"0 {my_mouse_move_dist}")),
        Key([], "k", lazy.spawn(my_mouse_move_cmd + f"0 -{my_mouse_move_dist}")),
        Key([], "l", lazy.spawn(my_mouse_move_cmd + f"{my_mouse_move_dist} 0")),
        Key([], "a", lazy.spawn(my_mouse_click_cmd + "1")), # LC
        Key([], "d", lazy.spawn(my_mouse_click_cmd + "3")), # RC
        Key([], "x", lazy.spawn(my_mouse_click_cmd + "2")), # MC
        Key([], "s", lazy.spawn(my_mouse_click_cmd + "5")), # WU
        Key([], "w", lazy.spawn(my_mouse_click_cmd + "4")), # WD
    ], mode=True, name="mouse"),

    # Apps
    Key([sup], period, lazy.spawn(my_audio_mixer)),
    Key([sup, shift], period, lazy.spawn(my_audio_mixer_alt)),
    KeyChord([sup, ctrl, shift], period, [
        Key([], period, lazy.spawn(my_audio_mixer)),
        Key([shift], period, lazy.spawn(my_audio_mixer_alt)),
        Key([], "1", lazy.spawn(my_audio_mixer_alt1)),
    ]),
    Key([sup], apostrophe, lazy.function(exec_func_no_qtile, run_keysboard, [True])),
    #Key([sup], apostrophe, lazy.function(exec_func_no_qtile, run_kmonad, [True])),
    Key([sup, shift], apostrophe, lazy.function(exec_func_no_qtile, run_keysboard, [False])),
    #Key([sup, shift], apostrophe, lazy.function(exec_func_no_qtile, run_kmonad, [False])),
    Key([sup], ret, lazy.spawn(my_terminal)),
    Key([sup, shift], ret, lazy.spawn(my_terminal_alt)),
    KeyChord([sup, ctrl, shift], ret, [
        Key([], ret, lazy.spawn(my_terminal)),
        Key([shift], ret, lazy.spawn(my_terminal_alt)),
        Key([], "1", lazy.spawn(my_terminal_alt1)),
        Key([], "2", lazy.spawn(my_terminal_alt2)),
        Key([], "3", lazy.spawn(my_terminal_alt3)),
        Key([], "4", lazy.spawn(my_terminal_alt4)),
    ]),
    Key([sup], "w", lazy.spawn(my_editor)),
    Key([sup, shift], "w", lazy.spawn(my_editor_alt)),
    KeyChord([sup, ctrl, shift], "w", [
        Key([], "w", lazy.spawn(my_editor)),
        Key([shift], "w", lazy.spawn(my_editor_alt)),
        Key([], "1", lazy.spawn(my_editor_alt1)),
        Key([], "2", lazy.spawn(my_editor_alt2)),
    ]),
    Key([sup], "b", lazy.spawn(my_browser)),
    Key([sup, ctrl], "b", lazy.spawn(my_browser_profile_menu)),
    Key([sup, shift], "b", lazy.spawn(my_browser_alt)),
    KeyChord([sup, ctrl, shift], "b", [
        Key([], "b", lazy.spawn(my_browser)),
        Key([shift], "b", lazy.spawn(my_browser_alt)),
        Key([], "1", lazy.spawn(my_browser_alt1)),
        Key([], "2", lazy.spawn(my_browser_alt2)),
        Key([], "3", lazy.spawn(my_browser_alt3)),
    ]),
    Key([sup, alt], "b", lazy.spawn(my_private_browser)),
    Key([sup, alt, shift], "b", lazy.spawn(my_private_browser_alt)),
    Key([sup], "e", lazy.spawn(my_file_manager)),
    Key([sup, shift], "e", lazy.spawn(my_file_manager_alt)),
    KeyChord([sup, ctrl, shift], "e", [
        Key([], "e", lazy.spawn(my_file_manager)),
        Key([shift], "e", lazy.spawn(my_file_manager_alt)),
        Key([], "1", lazy.spawn(my_file_manager_alt1)),
    ]),
    Key([sup], "x", lazy.spawn(my_mp)),
    Key([sup, alt], "x", lazy.spawn(my_mp_private)),
    Key([sup, shift], "x", lazy.spawn(my_mp_alt)),
    Key([sup, alt, shift], "x", lazy.spawn(my_mp_private_alt)),
    KeyChord([sup, ctrl, shift], "x", [
        Key([], "x", lazy.spawn(my_mp)),
        Key([shift], "x", lazy.spawn(my_mp_alt)),
        Key([], "1", lazy.spawn(my_mp_alt1)),
        Key([], "2", lazy.spawn(my_mp_alt2)),
    ]),
    Key([sup], "s", lazy.spawn(my_package_manager)),
    Key([sup, shift], "s", lazy.spawn(my_package_manager_alt)),
    Key([sup], "c", lazy.spawn(my_calculator)),
    Key([sup, shift], "c", lazy.spawn(my_calculator_alt)),
    Key([sup], semicolon, lazy.spawn(my_control_panel)),
    Key([sup, shift], semicolon, lazy.spawn(my_control_panel_alt)),
    KeyChord([sup, ctrl, shift], semicolon, [
        Key([], semicolon, lazy.spawn(my_control_panel)),
        Key([shift], semicolon, lazy.spawn(my_control_panel_alt)),
        Key([], "1", lazy.spawn(my_control_panel_alt1)),
    ]),
    Key([sup], comma, lazy.spawn(my_notification_drop)),
    Key([sup, shift], comma, lazy.spawn(my_notification_show)),

    # DropDown
    KeyChord([sup], "d", [
        # Sys
        Key([], ret, lazy.group['sys'].dropdown_toggle('term')),
        KeyChord([shift], ret, [
            Key([], "1", lazy.group['sys'].dropdown_toggle('term1')),
            Key([], "2", lazy.group['sys'].dropdown_toggle('term2')),
            Key([], "3", lazy.group['sys'].dropdown_toggle('term3')),
        ]),
        Key([], semicolon, lazy.group['sys'].dropdown_toggle('panel')),
        Key([], "e", lazy.group['sys'].dropdown_toggle('files')),
        KeyChord([shift], "e", [
            Key([], "1", lazy.group['sys'].dropdown_toggle('files1')),
            Key([], "2", lazy.group['sys'].dropdown_toggle('files2')),
            Key([], "3", lazy.group['sys'].dropdown_toggle('files3')),
        ]),

        # Media
        Key([], 'x', lazy.group['media'].dropdown_toggle('mp')),

        # CMD
        Key([], "p", lazy.group['cmd'].dropdown_toggle('pass')),
        KeyChord([shift], "p", [
            Key([], "1", lazy.group['cmd'].dropdown_toggle('pass1')),
        ]),
    ]),

    # System
    # Key([sup, shift, ctrl], "F11", lazy.spawn("sudo hibernate-reboot")),
    # Key([sup, shift, ctrl], "F12", lazy.spawn("systemctl hibernate")),
    Key([sup], "Escape", lazy.function(exec_func_no_qtile, run_cmd, [my_lock_device_cmd])),
    Key([], "Print", lazy.function(exec_func_no_qtile, take_screenshot)),

    # Special Keys
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('amixer sset Master 1%+')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('amixer sset Master 1%-')),
    Key([shift], 'XF86AudioRaiseVolume', lazy.spawn('amixer sset Master 1%+')),
    Key([shift], 'XF86AudioLowerVolume', lazy.spawn('amixer sset Master 1%-')),
    Key([], 'XF86AudioMute', lazy.spawn('amixer sset Master toggle')),
    Key([], 'XF86AudioPause', lazy.spawn('playerctl play-pause')),
    Key([], 'XF86AudioPlay', lazy.spawn('playerctl play-pause')),
    Key([ctrl], 'XF86AudioPause', lazy.spawn('playerctl -a play-pause')),
    Key([ctrl], 'XF86AudioPlay', lazy.spawn('playerctl -a play-pause')),
    Key([], 'XF86AudioNext', lazy.spawn('playerctl position 1+')),
    Key([], 'XF86AudioPrev', lazy.spawn('playerctl position 1-')),
    Key([shift], 'XF86AudioNext', lazy.spawn('playerctl position 1+')),
    Key([shift], 'XF86AudioPrev', lazy.spawn('playerctl position 1-')),
    Key([], 'XF86AudioStop', lazy.spawn('playerctl stop')),
    Key([shift], 'XF86AudioStop', lazy.spawn('playerctl stop')),
    Key([ctrl], 'XF86AudioStop', lazy.spawn('playerctl -a stop')),
    Key([], 'XF86MonBrightnessUp', lazy.spawn('brightnessctl set 1%+')),
    Key([], 'XF86MonBrightnessDown', lazy.spawn('brightnessctl set 1%-')),
]

for i, g in enumerate(my_base_groups):
    g_key = g
    if g_key != "1" and not g_key in get_keys():
        if i == 0:
            g_key = grave
        elif i == 11:
            g_key = minus
        elif i == 12:
            g_key = equal
    if g_key in get_keys():
        keys.extend(
            [
                Key([sup], g_key, lazy.function(set_current_screen_group_on_current_screen, g)),
                Key([sup, shift], g_key, lazy.function(set_current_screen_group_on_current_screen_no_toggle, g)),
                Key([sup, alt], g_key, lazy.function(send_current_win_to_group_on_current_screen_switch, g)),
                Key([sup, shift, alt], g_key, lazy.function(send_current_win_to_group_on_current_screen_noswitch, g)),
            ]
        )

mouse = [
    # Drag([sup], "Button1", lazy.window.set_position(),
    #     start=lazy.window.get_position()),
    # Drag([sup], "Button3", lazy.window.set_size(),
    #     start=lazy.window.get_size()),
    Drag([sup], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([sup], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
]


# -------------------------------- #
# -- Widgets & Screens & Groups -- #
# -------------------------------- #


widget_defaults = dict(
    font=my_font,
    fontsize=my_normal_font_size,
    padding=my_thin_border_width,
    margin=my_thin_margin,
    border_width=my_thin_border_width,
    border_color=[fg_txt_color, fg_txt_color],
    background=[dark_bg_color, dark_bg_color],
    foreground=[fg_txt_color, fg_txt_color],
    graph_color=[fg_txt_color, fg_txt_color],
    fill_color=[bg_txt_color, bg_txt_color],
)
extension_defaults = widget_defaults.copy()



class FileReaderWidget(widget_base.ThreadPoolText):
    def __init__(self, msg_base: str | None = "", msg_empty: str | None = "No Data", read_file: str = "", **config):
        widget_base.ThreadPoolText.__init__(self, "", **config)
        self.msg_base: str = msg_base if msg_base is not None else ""
        self.msg_empty: str = msg_empty if msg_empty is not None else ""
        self.read_file: str = read_file

    def poll(self):
        msg = ""
        try:
            print(self.read_file)
            if os.path.isfile(self.read_file):
                with open(self.read_file, 'r') as f:
                    lines = f.readlines()
                    if len(lines) > 0:
                        msg = str(lines[-1])
                    f.close()
        except Exception as e:
            msg = f"Error: {e}"
        finally:
            if msg == "":
                msg = self.msg_empty
            return self.msg_base + msg

class OpenWidgetBox(widget.WidgetBox):
    def __init__(self, _widgets: list[widget_base._Widget] = [], starts_open: bool = True, **config):
        super().__init__(_widgets=_widgets, **config)
        self.starts_open: bool = starts_open
        Thread(target=self.wait_open, daemon=True).start()

    def wait_open(self):
        if self.box_is_open != self.starts_open:
            while not self.configured:
                sleep(0.1)
            if self.box_is_open != self.starts_open:
                self.cmd_toggle()


class ColorGmailChecker(widget.GmailChecker):
    def __init__(self, clear_foreground: str = green_color, unseen_foreground: str = red_color, **config):
        super().__init__(**config)
        self.clear_foreground: str = clear_foreground
        self.unseen_foreground: str = unseen_foreground

    def poll(self):
        self.gmail = imaplib.IMAP4_SSL("imap.gmail.com")
        self.gmail.login(self.username, self.password)
        answer, raw_data = self.gmail.status(self.email_path, "(MESSAGES UNSEEN)")
        if answer == "OK":
            dec = raw_data[0].decode()
            messages = int(re.search(r"MESSAGES\s+(\d+)", dec).group(1))
            unseen = int(re.search(r"UNSEEN\s+(\d+)", dec).group(1))
            if unseen == 0:
                self.foreground = self.clear_foreground
            else:
                self.foreground = self.unseen_foreground
            if self.status_only_unseen:
                return self.display_fmt.format(unseen)
            else:
                return self.display_fmt.format(messages, unseen)
        else:
            self.foreground = self.unseen_foreground
            qtile.logger.exception(
                "GmailChecker UNKNOWN error, answer: %s, raw_data: %s", answer, raw_data
            )
            return "UNKNOWN ERROR"


#class BarWidget(bar.Bar, widget.base._Widget):
#    def __init__(self, widgets, size, **config):
#        bar.Bar.__init__(self, widgets, size, **config)
#        widget.base._Widget.__init__(self, size, **config)


def get_alternating_colors_of(color) -> list[str]:
    return [color, dark_bg_color, dark_bg_color, dark_bg_color, color]

def get_alternating_colors_dark() -> list[str]:
    return get_alternating_colors_of(bg_line_color)

def get_alternating_colors_red() -> list[str]:
    return get_alternating_colors_of(red_color)

def get_alternating_colors_green() -> list[str]:
    return get_alternating_colors_of(green_color)

def get_alternating_colors_blue() -> list[str]:
    return get_alternating_colors_of(blue_color)

def get_alternating_colors_cyan() -> list[str]:
    return get_alternating_colors_of(cyan_color)


def get_bend_widget(left=False) -> widget_base._Widget:
    return widget.TextBox(text=char_left_bend if left else char_right_bend, padding=0, fontsize=bar_height, foreground=dark_bg_color, background=invisible_color if segment_bars else dark_bg_color, font="PowerlineSymbols")

def get_sep_widget(mid_bar=False, stretch_right=False) -> widget_base._Widget:
    if mid_bar:
        #return widget.Sep(linewidth=my_thick_margin, foreground=invisible_color, background=invisible_color)
        return widget.Spacer(bar.STRETCH if stretch_right else my_thick_margin, background=invisible_color if segment_bars else dark_bg_color)
    return widget.Sep(linewidth=my_thick_border_width, padding=my_thick_margin)


def get_sys_stat_widgets() -> list:
    return [
        widget.Sep(linewidth=my_thin_border_width, padding=my_thick_margin),
        widget.TextBox("CPU:", background=get_alternating_colors_red(), fontsize=my_tiny_font_size),
        widget.CPUGraph(
            width=30,
            border_width=1,
            border_color=dark_bg_color,
            frequency=5,
            line_width=1,
            samples=50,
            background=get_alternating_colors_red(),
            fontsize=my_tiny_font_size,
        ),
        widget.CPU(
            format='{freq_current}GHz {load_percent}%',
            frequency=5,
            background=get_alternating_colors_red(),
            fontsize=my_tiny_font_size,
        ),
        widget.Sep(linewidth=my_thin_border_width, padding=my_thick_margin, fontsize=my_tiny_font_size),
        widget.TextBox("GPU:", background=get_alternating_colors_green(), fontsize=my_tiny_font_size),
        widget.NvidiaSensors(
            format='{temp}°C {fan_speed} {perf}',
            background=get_alternating_colors_green(),
            fontsize=my_tiny_font_size,
        ),
        widget.Sep(linewidth=my_thin_border_width, padding=my_thick_margin, fontsize=my_tiny_font_size),
        widget.TextBox("MEM:", background=get_alternating_colors_cyan(), fontsize=my_tiny_font_size),
        widget.MemoryGraph(
            width=30,
            border_width=1,
            border_color=dark_bg_color,
            line_width=1,
            frequency=5,
            background=get_alternating_colors_cyan(),
            fontsize=my_tiny_font_size,
        ),
        widget.Memory(
            measure_mem = "G",
            measure_swap = "G",
            frequency=5,
            background=get_alternating_colors_cyan(),
            fontsize=my_tiny_font_size,
        ),
        widget.Sep(linewidth=my_thin_border_width, padding=my_thick_margin, fontsize=my_tiny_font_size),
        widget.TextBox("NET:", background=get_alternating_colors_blue(), fontsize=my_tiny_font_size),
        widget.Net(
            format = '{down} ↓↑ {up}',
            padding = 0,
            background=get_alternating_colors_blue(),
            fontsize=my_tiny_font_size,
        ),
        widget.Sep(linewidth=my_thin_border_width, padding=my_thick_margin),
    ]

def get_widgets_1(i) -> list:
    widgets = [
                get_sep_widget(True),
                get_bend_widget(True),
                widget.TextBox(
                    fontsize=16,
                    foreground=green_color,
                    fmt='::',
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(my_launcher)},
                ),
                get_sep_widget(),
                OpenWidgetBox(
                    widgets=[
                        widget.GroupBox(
                            border_width=my_thin_border_width,
                            disable_drag=True,
                            rounded=True,
                            active=[fg_txt_color, fg_color],
                            inactive=[bg_txt_color, fg_color],
                            highlight_method="line",
                            #highlight_method="box",
                            this_current_screen_border=fg_line_color_alt,
                            this_screen_border=bg_line_color,
                            highlight_color=[bg_color, fg_color],
                            visible_groups=get_full_group_names_for_screen(i),
                            spacing=0,
                        ),
                    ],
                ),
                get_sep_widget(),
                widget.CurrentScreen(active_color=green_color, inactive_color=red_color),
                get_sep_widget(),
#                widget.TextBox(
#                    fontsize=16,
#                    fmt='',
#                    mouse_callbacks={
#                        'Button1': lambda: qtile.current_window.kill(),
#                        'Button3': lambda: qtile.cmd_spawn(my_window_killer),
#                    },
#                ),
                get_bend_widget(False),
                #widget.Spacer(50, background=invisible_color),
                get_sep_widget(True),
                get_bend_widget(True) if i == my_systray_screen else get_sep_widget(True),
                #get_sep_widget(),
                OpenWidgetBox(
                    widgets=[
                        widget.Systray(icon_size=24, foreground=dark_bg_color, background=dark_bg_color),
                    ],
                ) if i == my_systray_screen else None,
                #get_sep_widget(),
                get_bend_widget(False) if i == my_systray_screen else get_sep_widget(True),
                get_sep_widget(True),
                widget.Spacer(bar.STRETCH, background=invisible_color if segment_bars else dark_bg_color),
                get_bend_widget(True),
                #widget.Wttr(
                #    location = {my_city: ""},
                #    background=get_alternating_colors_green(),
                #),
                #get_sep_widget(),
                #OpenWidgetBox(
                #    widgets=[
                #        widget.Wttr(
                #                #location = {datetime.datetime.now().astimezone().tzname(): "W"},
                #                location = {my_city: "Wttr"},
                #                background=get_alternating_colors_green(),
                #            ),
                #        ],
                #    ),
                OpenWidgetBox(
                    widgets=[
                        #widget.CheckUpdates(
                        #    distro=my_distro,
                        #    custom_command=my_check_updates_cmd if my_check_updates_cmd is not None else ...,
                        #    no_update_string=":)",
                        #    colour_no_updates=green_color,
                        #    colour_have_updates=red_color,
                        #),
                        #widget.Spacer(length=5),
                        ##widget.Canto(),
                        #widget.Spacer(length=5),
                        #ColorGmailChecker(
                        #    username=my_gmail_username,
                        #    password=my_gmail_pass,
                        #),
                    ]
                ),
                get_sep_widget(),
                widget.Clock(
                    format='%a %b %d %Y, %I:%M:%S',
                    background=get_alternating_colors_green(),
                ),
                get_sep_widget(),
                widget.CapsNumLockIndicator(
                    frequency=0.1,
                    background=get_alternating_colors_cyan(),
                ),
                widget.TextBox("Light:", background=get_alternating_colors_cyan()),
                widget.Backlight(backlight_name=(os.listdir("/sys/class/backlight")+[None])[0], background=get_alternating_colors_cyan()),
                widget.TextBox("Bat:", background=get_alternating_colors_cyan()),
                widget.Battery(update_interval=my_slow_update_interval, background=get_alternating_colors_cyan()),
                get_sep_widget(),
                OpenWidgetBox(widgets=get_sys_stat_widgets()),
                #widget.WidgetBox(widgets=get_sys_stat_widgets()),
                get_bend_widget(False),
                get_sep_widget(True),
                get_bend_widget(True),
                widget.TextBox(
                    fmt='[-',
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('playerctl position 2-')},
                ),
                widget.Spacer(7),
                widget.TextBox(
                    fmt='>/=',
                    mouse_callbacks={
                        'Button1': lambda: qtile.cmd_spawn('playerctl -a pause'),
                        'Button2': lambda: qtile.cmd_spawn('playerctl stop'),
                        'Button3': lambda: qtile.cmd_spawn('playerctl play'),
                    },
                ),
                widget.Spacer(7),
                widget.TextBox(
                    fmt='-]',
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('playerctl position 2+')},
                ),
                widget.Spacer(length=7),
                widget.TextBox("vol:"),
                widget.Volume(update_interval=my_fast_update_interval, step=1),
                #get_sep_widget(),
                # widget.CurrentLayoutIcon(scale=0.70),
                get_sep_widget(),
                widget.TextBox(
                    fontsize=16,
                    foreground=red_color,
                    fmt='Q',
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(my_powermenu)},
                ),
                get_bend_widget(False),
                get_sep_widget(True),
            ]
    for iw, w in enumerate(widgets):
        if w is None or (isinstance(w, widget.Systray) and i != my_systray_screen):
            widgets.pop(iw)
    return widgets


def get_widgets_2(i) -> list:
    widgets = [
                get_bend_widget(True),
                widget.TaskList(
                    border=fg_line_color,
                    unfocused_border=bg_line_color,
                    rounded=True,
                ),
                get_bend_widget(False),
                get_sep_widget(True),
                get_bend_widget(True),
                FileReaderWidget(
                    file = "/tmp/tmux-bar-keysboard-pipe",
                    msg_base = "Keysboard: ",
                    #file = "/tmp/tmux-bar-kmonad-pipe",
                    #msg_base = "Kmonad: ",
                    margin_y=4,
                    padding_y=4,
                    update_interval=my_slow_update_interval,
                    mouse_callbacks={
                        'Button1': lambda: run_keysboard(True),
                        'Button3': lambda: run_keysboard(False),
                        #'Button1': lambda: run_kmonad(True),
                        #'Button3': lambda: run_kmonad(False),
                    },
                ),
                get_bend_widget(False),
    ]
    return widgets


groups: list = [
    ScratchPad(
        "sys", [
            DropDown("term", my_terminal, opacity=0.8),
            DropDown("term1", my_terminal, opacity=0.8),
            DropDown("term2", my_terminal, opacity=0.8),
            DropDown("term3", my_terminal, opacity=0.8),
            DropDown("panel", my_control_panel, opacity=0.8, height=0.5),
            DropDown("files", my_file_manager, opacity=0.8, height=0.5),
            DropDown("files1", my_file_manager, opacity=0.8, height=0.5),
            DropDown("files2", my_file_manager, opacity=0.8, height=0.5),
            DropDown("files3", my_file_manager, opacity=0.8, height=0.5),
        ]
    ),
    ScratchPad(
        "media", [
            DropDown("mp", my_mp, opacity=1.0),
        ]
    ),
    ScratchPad(
        "cmd", [
            DropDown("pass", my_passwd_manager, opacity=1.0),
            DropDown("pass1", my_passwd_manager_alt, opacity=1.0),
        ]
    ),
]

screens: list = []
bars: list = []
img_fmts: tuple = (".png", ".jpeg", ".jpg", ".webp")
if os.path.isfile(my_wallpapers) and my_wallpapers.endswith(img_fmts):
    wallpapers = [my_wallpapers]
elif os.path.isdir(my_wallpapers):
    wallpapers = []
    for f in os.listdir(my_wallpapers):
        img = my_wallpapers + f"/{f}"
        if not img.startswith(".") and img.endswith(img_fmts) and os.path.isfile(img):
            wallpapers.append(img)
else:
    wallpapers = []

i = 0
for monitor in monitors:
    if len(monitor) > 0 and monitor != "\n":
        do_solid_wall = False
        wallpaper = None
        if draw_wallpaper:
            if draw_wallpaper_img:
                if len(wallpapers) > 0:
                    wallpaper = choice(wallpapers)
            else:
                do_solid_wall = True
        top_bar=bar.Bar(get_widgets_1(i), bar_height, margin=my_thin_margin, foreground=invisible_color if segment_bars else fg_color, background=invisible_color if segment_bars else dark_bg_color, border_color=invisible_color if segment_bars else [fg_line_color, dark_bg_color]*2, border_width=0 if segment_bars else my_thin_border_width)
        bottom_bar=bar.Bar(get_widgets_2(i), bar_height, margin=my_thin_margin, foreground=invisible_color if segment_bars else fg_color, background=invisible_color if segment_bars else dark_bg_color, border_color=invisible_color if segment_bars else [fg_line_color, dark_bg_color]*2, border_width=0 if segment_bars else my_thin_border_width)
        bars.extend([top_bar, bottom_bar])
        screens.append(
            Screen(
                top=top_bar,
                bottom=bottom_bar,
                wallpaper=wallpaper if not do_solid_wall else None,
                wallpaper_mode="stretch" if wallpaper is not None and not do_solid_wall else None,
            )
        )
        for g in get_full_group_names_for_screen(i):
            groups.append(Group(g))
        m_key = str(i)
        if m_key in get_keys():
            keys.extend(
                    [
                        Key([sup, ctrl], m_key, lazy.function(set_screen, i, True, False)),
                        Key([sup, ctrl, alt], m_key, lazy.function(set_screen, i, True, True)),
                    ]
                    )
        if do_solid_wall:
            run_cmd(my_solid_wallpaper_cmd)
        i += 1


# ---------- #
# -- Vars -- #
# ---------- #


#dgroups_key_binder = None
#dgroups_app_rules = []
#extentions = []
reconfigure_screens = True
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
wmname = "LG3D"


# --------------------- #
# -- Layouts & Hooks -- #
# --------------------- #


layouts: list = [
    layout.Columns(
        #border_normal=[bg_line_color, dark_bg_color],
        border_normal=[fg_line_color],
        #border_focus=[fg_line_color, fg_line_color_alt],
        border_focus=[fg_line_color_alt],
        #border_normal_stack=[bg_line_color, dark_bg_color],
        border_normal_stack=[fg_line_color],
        #border_focus_stack=[fg_line_color, fg_line_color_alt],
        border_focus_stack=[fg_line_color_alt],
        border_on_single=True,
        border_width=my_thick_border_width,
        margin=my_thick_margin,
        num_columns=2,
        ratio=0.70,
    )
]

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
    ],
    #border_normal=[bg_line_color, dark_bg_color],
    border_normal=[fg_line_color],
    #border_focus=[fg_line_color, fg_line_color_alt],
    border_focus=[fg_line_color_alt],
    border_width=my_thick_border_width,
)


force_auto_float_rules = []
no_auto_float_rules = []
@hook.subscribe.client_new
def floating_dialogs_hook(window) -> None:
    dialog = window.window.get_wm_type() == 'dialog'
    transient = window.window.get_wm_transient_for()
    forced = is_win_in_classes(window, force_auto_float_rules, False)
    allowed = not is_win_in_classes(window, no_auto_float_rules, False)
    if allowed and (forced or dialog or transient):
        window.floating = True


force_auto_group_rules: list[tuple[str, str | int, bool]] = []
no_auto_group_rules: list[tuple[str, list[str | int]]] = []
@hook.subscribe.client_new
def pref_group_hook(window) -> None:
    if force_auto_group_all is not None:
        gn, follow = force_auto_group_all
    else:
        forced, i = is_win_in_classes(window, [r[0] for r in force_auto_group_rules], False, True)
        if forced and i is not None:
            gn, follow = force_auto_group_rules[i][1:]
        else:
            gn, follow = None, None
    if gn is not None and follow is not None:
        if isinstance(gn, str):
            g = get_group_by_name(qtile, gn)
        elif isinstance(gn, int):
            g = get_group_by_index(qtile, gn)
        else:
            return
        if not is_win_in_classes(window, [r[0] for r in no_auto_group_rules if r[1] not in [get_group_name(qtile, g), get_group_index(qtile, g)]], False):
            send_win_to_group(qtile, window, get_group_name(qtile, g), follow)


@hook.subscribe.screen_change
def screen_change_hook(qtile) -> None:
    run_cmd(os.path.join(cfg_dir, "scripts", "run", "run-monitors.sh"))


@hook.subscribe.startup
def autostart_hook() -> None:
    run_cmd(os.path.join(cfg_dir, "autostart.sh"))
    for b in bars:
        if b.window is not None:
            b.window.window.set_property('WM_NAME', 'qtile_bar_segmented' if segment_bars else 'qtile_bar', type='STRING', format=8)

