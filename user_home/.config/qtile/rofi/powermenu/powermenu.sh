#!/usr/bin/env bash

dir="$HOME/.config/qtile/rofi/powermenu"

uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme ~/.config/qtile/rofi/gruvbox-dark.rasi"

# Options
shutdown="⏻ - Poweroff"
reboot="累 - Reboot"
monitor=" - Lock & Monitor Off"
lock=" - Lock"
suspend=" - Suspend"
logout=" - Logout"


# Message
bad_ans_msg() {
	rofi -theme "~/.config/qtile/rofi/gruvbox-dark.rasi" -e "Available Options  -  yes / y / no / n"
}

# Confirmation
confirm_exit() {
	ans=$(rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme "$HOME/.config/qtile/rofi/gruvbox-dark.rasi")
	if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
		echo "y"
	elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
		exit 0
    else
		bad_ans_msg
    fi
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$monitor\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
		if [[ $(confirm_exit &) == "y" ]]; then
			poweroff
		fi
        ;;
    $reboot)
		if [[ $(confirm_exit &) == "y" ]]; then
			reboot
        fi
        ;;
    $lock)
        #if [[ ! -f "$HOME/.cache/betterlockscreen/wall_color.png" ]]; then betterlockscreen -u . --fx color --color 252323; fi
        #betterlockscreen --lock dimblur
        #xss-lock -l -- i3lock --ignore-empty-password --color=3c3836 
        loginctl lock-session
        ;;
    $suspend)
		if [[ $(confirm_exit &) == "y" ]]; then
            playerctl --all-players pause
			amixer set Master mute
			loginctl suspend
        fi
        ;;
	$monitor)
		sleep 0.5; xset dpms force standby
        ;;
    $logout)
		if [[ $(confirm_exit &) == "y" ]]; then
            killall qtile || killall .qtile-real;
        fi
        ;;
esac
