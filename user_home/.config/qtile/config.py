# ================================= #
# --------------------------------- #
# -- Dunkmania101's Qtile Config -- #
# --------------------------------- #
# ================================= #


import os, subprocess, imaplib, re #, gi
#gi.require_version("Gdk", "3.0")
#from gi.repository import Gdk
from json import loads as jloads #, dumps as jdumps
from time import sleep
from shutil import which
from threading import Thread
from random import choice
from libqtile import qtile, layout, hook, bar, widget, extension
from libqtile.backend.x11.core import get_keys
# from libqtile.backend.wayland.core import keyboard as wl_kbd
from libqtile.config import Key, KeyChord, Drag, Screen, Match, Group, ScratchPad, DropDown #, Click
from libqtile.widget import base as widget_base
from libqtile.lazy import lazy


# --------------------- #
# -- Basic Functions -- #
# --------------------- #


def shcmd_exists(cmd):
    return which(cmd) is not None

def sub_run_cmd(cmd, cwd):
    try:
        subprocess.run(cmd, cwd=cwd, shell=True)
    except Exception as e:
        print(str(e))
        pass

def run_cmd(cmd, cwd=None, thread=True):
   if thread:
        Thread(target=sub_run_cmd, args=(cmd, cwd,)).start()
   else:
       sub_run_cmd(cmd, cwd)

def get_cmd_output(cmd, cwd=None):
    output = ""
    try:
        output = str(subprocess.run(cmd, cwd=cwd, shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8'))
    except Exception as e:
        print(str(e))
        pass
    return output

def exec_func_no_qtile(_, func, args):
    if callable(func):
        func(*args)


def is_wayland():
    return qtile.core.name == "wayland"


def gen_jgmenu_cmd(fmt="uxterm"):
    return f"echo \'{fmt}\' | jgmenu --simple"


# -------------------- #
# -- Base Variables -- #
# -------------------- #


cfg_dir = os.path.expanduser("~/.config/qtile")
#run_cmd(cfg_dir + "/autostart.sh")
rofi_dir = cfg_dir + "/rofi"
env_file = os.path.expanduser("~/.private/data/env.json")
env_data = {}
if os.path.isfile(env_file):
    with open(env_file, "r") as f:
        try:
            env_data = jloads(f.read())
        except:
            pass


# Themes

my_font = "Iosevka"
my_term_font = "Iosevka Term"

my_color_theme = "blue_dark" # "blue_dark" or "red_dark"

if my_color_theme == "blue_dark":
    # Blue Dark
    bg_color = "#282c34"
    fg_color = "#5c6370"
    dark_bg_color = "#222222"
    bg_line_color = "#425370"
    fg_line_color = "#618fef"
    bg_line_color_alt = "#504d6d"
    fg_line_color_alt = "#4b4263"
    bg_txt_color = "#414f4f"
    fg_txt_color = "#abb2bf"
    green_color = "#504945"
    red_color = "#cc241d"
else:
    # Red Dark
    bg_color = "#29221B"
    fg_color = "#4f443a"
    dark_bg_color = "#222222"
    bg_line_color = "#3c3836"
    fg_line_color = "#4f4347"
    bg_line_color_alt = "#aa5000"
    fg_line_color_alt = "#ff8000"
    bg_txt_color = "#3c3836"
    fg_txt_color = "#ebdbb2"
    green_color = "#687b01"
    red_color = "#cc241d"


# Base Groups (copied to each monitor)
my_base_groups = "~ 1 2 3 4 5 6 7 8 9 0 - =".split(" ")

# Screen to put the systray widget on
my_systray_screen = 0

# Gap and border sizes
my_border_width = 4
my_margin = 1

# Directories
my_wallpapers = os.path.expanduser("~/Wallpapers") # Can point to a directory or a single image file.
my_screenshots_dir = os.path.expanduser("~/Pictures/Screenshots")

# Details
my_distro = "Arch"
my_check_updates_cmd = None
#my_check_updates_cmd = ""
##if shcmd_exists("pip"):
##    my_check_updates_cmd += "; pip list --outdated --format=freeze"
#if shcmd_exists("paru"):
#    my_check_updates_cmd += "; paru --query --upgrades"
#if shcmd_exists("guix"):
#    my_check_updates_cmd += "; guix refresh"

if is_wayland():
    my_get_monitors_cmd = "wlr-randr"
else:
    my_get_monitors_cmd = "xrandr --query | grep \" connected\" | cut -d\" \" -f1"

my_mouse_move_cmd = "xdotool mousemove_relative -- "
my_mouse_move_dist = "10"
my_mouse_click_cmd = "xdotool click "

my_gmail_username = env_data.get("gmail.username", "")
my_gmail_pass = env_data.get("gmail.pass", "")


# Applications
#my_terminal = "kitty -e tmux"
#my_terminal_tmux = f"kitty -e \'{cfg_dir}/scripts/run/run-tmux-session.sh\'"
my_terminal = "kitty"
#my_terminal = f"uxterm -si -fs 10 -fa \"{my_term_font}\" -bg \'#212121\' -bd \'#212111\'"
#my_terminal_alt = "kitty"
my_terminal_alt = f"uxterm -si -fs 10 -fa \"{my_term_font}\" -bg \'#212121\' -bd \'#212111\'"
#my_terminal_alt = "st"
#my_terminal_alt = "cool-retro-term"
#my_terminal_alt = "darktile"
#my_terminal_alt = "extraterm"
#my_terminal_alt1 = "kitty -e tmux"
#my_terminal_alt1 = "kitty"
my_terminal_alt1 = "cool-retro-term"
my_terminal_alt2 = "extraterm"
my_terminal_alt3 = "urxvt"
my_terminal_alt4 = f"uxterm -si -fa \"{my_font}\""

#my_editor = cfg_dir + "/scripts/run/run-emacs.sh"
my_editor = "emacs"
#my_editor = "emacsclient -a '' -c"
my_editor_alt = "neovide --multigrid"
#my_editor_alt = "vscodium"
# my_editor_alt = "notepadqq"
my_editor_alt1 = "emacs"
my_editor_alt2 = "kitty zsh -c \'source ~/.zshrc; nvim\'"

my_browser = "nyxt -S"
#my_browser_alt = os.path.expanduser("~/.nix-profile/bin/vivaldi")
my_browser_alt = "firefox-developer-edition"
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

my_file_manager = "pcmanfm"
my_file_manager_alt = "filezilla"
my_file_manager_alt1 = "thunar"

#my_mp = "deadbeef"
#my_mp = "kawaii-player"
#my_mp = "lollypop"
#my_mp = "celluloid"
my_mp = rofi_dir + "/mpvselect/mpvselect.sh"
my_mp_alt = rofi_dir + "/ytfzf/ytfzf.sh --savefile"
my_mp_alt1 = rofi_dir + "/ytfzf/ytfzf.sh"
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
my_calculator_alt = "qalculate-gtk"

my_control_panel = my_terminal + " -e btop"
#my_control_panel = "kitty -e btop"
my_control_panel_alt = "stacer"

my_audio_mixer = my_terminal + " -e pulsemixer"
my_audio_mixer_alt = "easyeffects"
my_audio_mixer_alt1 = my_terminal + " -e alsamixer"

# Menus (Rofi Scripts, etc...)
my_launcher = rofi_dir + "/launcher/launcher.sh"
my_launcher_alt = "jgmenu"
my_clipmenu = rofi_dir + "/clipmenu/clipmenu.sh"
my_clipmenu_alt = "copyq toggle"
my_powermenu = rofi_dir + "/powermenu/powermenu.sh"
my_handy = rofi_dir + "/handy/handy.sh"
my_window_pager = rofi_dir + "/window/window.sh"
my_player_ctrl = rofi_dir + "/player/player.sh"
my_workspaces = rofi_dir + "/workspaces/workspaces.sh"
my_emoji = rofi_dir + "/emoji/emoji.sh"

my_window_killer = f"{my_terminal} -e xkill"


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
minus = "minus"
equal = "equal"
# quote = "quoteright"


monitors = get_cmd_output(my_get_monitors_cmd).split("\n")
#gdkdsp = Gdk.Screen.get_default()
#monitors = [gdkdsp.get_monitor_plug_name(i) for i in range(gdkdsp.get_n_monitors())]


def take_screenshot(cmd="scrot", cwd=my_screenshots_dir):
    if not os.path.isdir(cwd):
        os.makedirs(cwd)
    run_cmd(cmd, cwd)


def run_keysboard(start=True):
    if start:
        run_cmd(cfg_dir + "/scripts/run/run-keysboard.sh")
    else:
        run_cmd('tmux kill-session -t keysboard-bar; rm -f /tmp/tmux-bar-keysboard-pipe')


def run_kmonad(start=True):
    if start:
        run_cmd(cfg_dir + "/scripts/run/run-kmonad.sh")
    else:
        run_cmd('tmux kill-session -t kmonad-bar; rm -f /tmp/tmux-bar-kmonad-pipe')


#def run_plank(start=True):
#    if start:
#        for _ in monitors:
#            run_cmd(f"plank")
#    else:
#        run_cmd("killall -q plank")


# ------------------------------ #
# -- Binds & Functions Galore -- #
# ------------------------------ #


def get_full_group_name(screen_name, base_name):
    return f"{screen_name}:{base_name}"

def get_full_group_names_for_screen(i):
    return [get_full_group_name(i, g) for g in my_base_groups]

def get_current_screen_index(qtile):
    return qtile.screens.index(qtile.current_screen)

def get_screen_by_offset(qtile, offset=1):
    return (get_current_screen_index(qtile) + offset) % len(qtile.screens)

def get_current_group_index(qtile):
    return qtile.groups.index(qtile.current_group)

def get_group_obj_by_name(qtile, g):
    return qtile.groups_map.get(g)

def get_current_group_index_on_current_screen(qtile):
    return get_current_group_index(qtile) - ((len(qtile.screens) * len(my_base_groups)))

def get_group_on_current_screen(qtile, g):
    return get_full_group_name(get_current_screen_index(qtile), g)

def get_group_index_on_current_screen_by_offset(qtile, offset=1):
    return ((get_current_group_index_on_current_screen(qtile) + offset) % len(my_base_groups)) + (len(my_base_groups) * get_current_screen_index(qtile))

def get_group_on_current_screen_by_offset(qtile, offset=1):
    return qtile.groups[get_group_index_on_current_screen_by_offset(qtile, offset)]


def set_screen(qtile, screen, move_focus=True, move_window=True):
    if move_window:
        qtile.current_window.cmd_toscreen(screen)
    if move_focus:
        qtile.cmd_to_screen(screen)

def cycle_screen(qtile, offset=1, move_focus=True, move_window=True):
    set_screen(qtile, get_screen_by_offset(qtile, offset), move_focus, move_window)


def set_current_screen_group(qtile, g, toggle=True):
    if toggle:
        qtile.current_screen.cmd_toggle_group(g)
    else:
        qtile.current_screen.set_group(get_group_obj_by_name(qtile, g))

def set_current_screen_group_on_current_screen(qtile, g, toggle=True):
    set_current_screen_group(qtile, get_group_on_current_screen(qtile, g), toggle)

def set_current_screen_group_on_current_screen_no_toggle(qtile, g):
    set_current_screen_group_on_current_screen(qtile, g, toggle=False)

def set_current_screen_group_by_offset(qtile, offset=1):
    set_current_screen_group(qtile, get_group_on_current_screen_by_offset(qtile, offset).name)


def send_current_win_to_group(qtile, g, switch_group=True):
    qtile.current_window.togroup(g, switch_group=switch_group)

def send_current_win_to_group_on_current_screen_switch(qtile, g):
    send_current_win_to_group(qtile, get_group_on_current_screen(qtile, g))

def send_current_win_to_group_on_current_screen_noswitch(qtile, g):
    send_current_win_to_group(qtile, get_group_on_current_screen(qtile, g), False)


def win_cycle_group_next_switch(qtile):
    send_current_win_to_group(qtile, get_group_on_current_screen_by_offset(qtile).name, switch_group=True)

def win_cycle_group_prev_switch(qtile):
    send_current_win_to_group(qtile, get_group_on_current_screen_by_offset(qtile, -1).name, switch_group=True)

def win_cycle_group_next_noswitch(qtile):
    send_current_win_to_group(qtile, get_group_on_current_screen_by_offset(qtile).name, switch_group=False)

def win_cycle_group_prev_noswitch(qtile):
    send_current_win_to_group(qtile, get_group_on_current_screen_by_offset(qtile, -1).name, switch_group=False)


def cycle_screen_next(qtile):
    cycle_screen(qtile, 1, True, False)

def cycle_screen_prev(qtile):
    cycle_screen(qtile, -1, True, False)


def swap_current_screen(qtile, offset=1):
    i = get_current_screen_index(qtile)
    o = i+offset
    if o >= len(qtile.screens):
        o = len(qtile.screens) % o
    qtile.screens[i], qtile.screens[o] = qtile.screens[o], qtile.screens[i]
    qtile.cmd_reconfigure_screens()

def swap_current_screen_next(qtile):
    swap_current_screen(qtile)

def swap_current_screen_prev(qtile):
    swap_current_screen(qtile, -1)


def cycle_group_next(qtile):
    set_current_screen_group_by_offset(qtile)

def cycle_group_prev(qtile):
    set_current_screen_group_by_offset(qtile, -1)


def win_cycle_screen_next_switch(qtile):
    cycle_screen(qtile, 1, True, True)

def win_cycle_screen_prev_switch(qtile):
    cycle_screen(qtile, -1, True, True)

def win_cycle_screen_next_noswitch(qtile):
    cycle_screen(qtile, 1, False, True)

def win_cycle_screen_prev_noswitch(qtile):
    cycle_screen(qtile, -1, False, True)

def win_toggle_minimize(qtile):
    qtile.current_window.cmd_toggle_minimize()


# ----------


keys = [
    # Menus
    Key([sup], space, lazy.spawn(my_launcher)),
    Key([sup, shift], space, lazy.spawn(my_launcher_alt)),
    Key([sup], tab, lazy.spawn(my_window_pager)),
    Key([sup, shift], tab, lazy.run_extension(
        extension.WindowList (
            foreground=fg_color,
            background=bg_color,
            selected_foreground=fg_txt_color,
            selected_background=bg_txt_color
        )
    )),
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
    Key([sup, shift], "r", lazy.restart()),
    Key([sup, shift, ctrl, alt], "q", lazy.shutdown()),

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

    # Apps
    Key([sup], period, lazy.spawn(my_audio_mixer)),
    Key([sup, shift], period, lazy.spawn(my_audio_mixer_alt)),
    KeyChord([sup, ctrl, shift], period, [
        Key([], period, lazy.spawn(my_audio_mixer)),
        Key([shift], period, lazy.spawn(my_audio_mixer_alt)),
        Key([], "1", lazy.spawn(my_audio_mixer_alt1)),
    ]),
    #Key([sup], apostrophe, lazy.function(exec_func_no_qtile, run_keysboard, [True])),
    Key([sup], apostrophe, lazy.function(exec_func_no_qtile, run_kmonad, [True])),
    #Key([sup, shift], apostrophe, lazy.function(exec_func_no_qtile, run_keysboard, [False])),
    Key([sup, shift], apostrophe, lazy.function(exec_func_no_qtile, run_kmonad, [False])),
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

    # DropDown
    KeyChord([sup], "d", [
        Key([], ret, lazy.group['main-scratchpad'].dropdown_toggle('term')),
        Key([], 'x', lazy.group['main-scratchpad'].dropdown_toggle('media')),
    ]),

    # System
    # Key([sup, shift, ctrl], "F11", lazy.spawn("sudo hibernate-reboot")),
    # Key([sup, shift, ctrl], "F12", lazy.spawn("systemctl hibernate")),
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
    fontsize=14,
    padding=2,
    margin=my_margin,
    background=[dark_bg_color, dark_bg_color],
    foreground=[fg_txt_color, fg_txt_color],
    graph_color=[fg_txt_color, fg_txt_color],
    fill_color=[bg_txt_color, bg_txt_color],
)


class DividerWidget(widget.TextBox):
    def __init__(self, div_mid="|", div_padding_left=1, div_padding_right=1, **config):
        super().__init__(f"{' ' * div_padding_left}{div_mid}{' ' * div_padding_right}", **config)

class FileReaderWidget(widget_base.ThreadPoolText):
    def __init__(self, msg_base="", empty_msg="No Data", read_file="", **config):
        self.msg_base = msg_base
        self.empty_msg = empty_msg
        self.read_file = read_file
        widget_base.ThreadPoolText.__init__(self, "", **config)

    def poll(self):
        msg = ""
        try:
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
                msg = self.empty_msg
            return self.msg_base + msg

class OpenWidgetBox(widget.WidgetBox):
    def __init__(self, _widgets: list[widget_base._Widget] | None = None, **config):
        super().__init__(_widgets=_widgets, **config)
        Thread(target=self.wait_open, daemon=True).start()

    def wait_open(self):
        if not self.box_is_open:
            while not self.configured:
                sleep(0.1)
            self.cmd_toggle()


class ColorGmailChecker(widget.GmailChecker):
    def __init__(self, clear_foreground=green_color, unseen_foreground=red_color, **config):
        super().__init__(**config)
        self.clear_foreground=clear_foreground
        self.unseen_foreground=unseen_foreground

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


def get_sys_stat_widgets():
    return [
        widget.Spacer(length=5),
        widget.TextBox("cpu:"),
        widget.CPUGraph(
            width=30,
            border_width=1,
            border_color=dark_bg_color,
            frequency=5,
            line_width=1,
            samples=50,
        ),
        widget.TextBox("mem:"),
        widget.MemoryGraph(
            width=30,
            border_width=1,
            border_color=dark_bg_color,
            line_width=1,
            frequency=5,
        ),
        widget.Memory(
            measure_mem = "G",
            measure_swap = "G",
        ),
        widget.Spacer(length=15),
        widget.TextBox("net:"),
        widget.Net(
            format = '{down} ↓↑ {up}',
            padding = 0
        ),
    ]

def get_widgets_1(i):
    widgets = [
                widget.Spacer(length=15),
                widget.TextBox(
                    fontsize=16,
                    fmt='::',
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(my_launcher)},
                ),
                DividerWidget(),
                OpenWidgetBox(
                    widgets=[
                        widget.GroupBox(
                            border_width=my_border_width,
                            disable_drag=True,
                            rounded=True,
                            active=[fg_txt_color, fg_txt_color],
                            inactive=[bg_txt_color, bg_txt_color],
                            highlight_method="line",
                            this_current_screen_border=fg_line_color_alt,
                            this_screen_border=bg_line_color_alt,
                            highlight_color=[fg_color, fg_color],
                            visible_groups=get_full_group_names_for_screen(i),
                            spacing=0,
                        ),
                    ],
                ),
                DividerWidget(),
                widget.CurrentScreen(active_color=green_color, inactive_color=red_color),
                DividerWidget(),
#                widget.TextBox(
#                    fontsize=16,
#                    fmt='',
#                    mouse_callbacks={
#                        'Button1': lambda: qtile.current_window.kill(),
#                        'Button3': lambda: qtile.cmd_spawn(my_window_killer),
#                    },
#                ),
                widget.Spacer(),
                widget.Systray(icon_size=24),
                widget.Spacer(),
                DividerWidget(),
                widget.Clock(
                    format='%a %b %d %Y, %I:%M:%S',
                ),
                DividerWidget(),
                OpenWidgetBox(
                    widgets=[
                        widget.CheckUpdates(
                            distro=my_distro,
                            custom_command=my_check_updates_cmd if my_check_updates_cmd is not None else ...,
                            no_update_string=":)",
                            colour_no_updates=green_color,
                            colour_have_updates=red_color,
                        ),
                        widget.Spacer(length=5),
                        widget.Canto(),
                        widget.Spacer(length=5),
                        ColorGmailChecker(
                            username=my_gmail_username,
                            password=my_gmail_pass,
                        ),
                    ]
                ),
                DividerWidget(),
                widget.CapsNumLockIndicator(
                    frequency=0.1,
                ),
                DividerWidget(),
                widget.WidgetBox(widgets=get_sys_stat_widgets()),
                DividerWidget(),
                widget.TextBox(
                    fmt='[-',
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('playerctl position 2-')},
                ),
                widget.Spacer(7),
                widget.TextBox(
                    fmt='>/=',
                    mouse_callbacks={
                        'Button1': lambda: qtile.cmd_spawn('playerctl -a pause'),
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
                widget.Volume(update_interval=0.1, step=1),
                # widget.CurrentLayoutIcon(scale=0.70),
                DividerWidget(),
                widget.TextBox(
                    fontsize=16,
                    fmt='Q',
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(my_powermenu)},
                ),
                widget.Spacer(length=15),
            ]
    if i != my_systray_screen:
        for w in widgets:
            if isinstance(w, widget.Systray):
                widgets.remove(w)
    return widgets


def get_widgets_2(i):
    widgets = [
                DividerWidget(),
                widget.TaskList(
                    border=fg_line_color,
                    unfocused_border=bg_line_color,
                    rounded=True,
                ),
                DividerWidget(),
                FileReaderWidget(
                    #file = "/tmp/tmux-bar-keysboard-pipe",
                    #msg_base = "Keysboard: ",
                    file = "/tmp/tmux-bar-kmonad-pipe",
                    msg_base = "Kmonad: ",
                    margin_y=4,
                    padding_y=4,
                    update_interval=0.3,
                    mouse_callbacks={
                        #'Button1': lambda: run_keysboard(True),
                        #'Button3': lambda: run_keysboard(False),
                        'Button1': lambda: run_kmonad(True),
                        'Button3': lambda: run_kmonad(False),
                    },
                ),
                DividerWidget(),
    ]
    return widgets


groups = [
        ScratchPad(
            "main-scratchpad", [
                DropDown("term", my_terminal, opacity=0.8),
                DropDown("media", my_mp, opacity=1.0),
                ]
    )
]

screens = []
img_fmts = (".png", ".jpeg", ".jpg")
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
        if len(wallpapers) > 0:
            wallpaper = wallpaper=choice(wallpapers)
        else:
            wallpaper = None
        screens.append(
            Screen(
                top=bar.Bar(get_widgets_1(i), 30, background=bg_color, border_color=bg_line_color, border_width=my_border_width),
                bottom=bar.Bar(get_widgets_2(i), 30, background=bg_color, border_color=bg_line_color, border_width=my_border_width),
                wallpaper=wallpaper,
                wallpaper_mode="stretch",
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
        i += 1


# ---------- #
# -- Vars -- #
# ---------- #


#dgroups_key_binder = None
#dgroups_app_rules = []
#extentions = []
reconfigure_screens = True
follow_mouse_focus = False
bring_front_click = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
wmname = "LG3D"


# --------------------- #
# -- Layouts & Hooks -- #
# --------------------- #


layouts = [
    layout.Columns(
        border_normal=bg_line_color,
        border_focus=[fg_line_color_alt, fg_line_color],
        border_normal_stack=bg_line_color,
        border_focus_stack=[fg_line_color_alt, fg_line_color],
        border_on_single=True,
        border_width=my_border_width,
        margin=my_margin,
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
    border_normal=bg_line_color_alt,
    border_focus=fg_line_color_alt,
    border_width=my_border_width,
)


dont_auto_float_rules = []
@hook.subscribe.client_new
def floating_dialogs_hook(window):
    dialog = window.window.get_wm_type() == 'dialog'
    transient = window.window.get_wm_transient_for()
    allowed = all(c not in dont_auto_float_rules for c in window.window.get_wm_class())
    if allowed and (dialog or transient):
        window.floating = True


@hook.subscribe.screen_change
def screen_change_hook(qtile):
    run_cmd(cfg_dir + "scripts/run/run-monitors.sh")


@hook.subscribe.startup_complete
def autostart_hook():
    run_cmd(cfg_dir + "/autostart.sh")

