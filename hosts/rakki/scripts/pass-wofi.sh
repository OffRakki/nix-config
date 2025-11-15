if [ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]; then
    class="$(hyprctl activewindow -j | jq -r '.class')"
elif [ "$XDG_CURRENT_DESKTOP" == "sway" ]; then
    focused="$(swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select(.focused==true)')"
    class=$(jq -r '.window_properties.class' <<< "$focused")
elif [ "$XDG_CURRENT_DESKTOP" == "niri" ]; then
    class="$(niri msg --json focused-window | jq -r '.app_id')"
fi

if [[ "$class" == "org.qutebrowser.qutebrowser" ]] || [[ "$class" == "qutebrowser" ]]; then
    wtype -k escape
    wtype yy
    sleep 0.2
    query=$(wl-paste | cut -d '/' -f3 | sed s/"www."//)
    wtype i
elif [[ "$class" == "vesktop" ]]; then
    query="discord.com"
elif [[ "$class" == "Steam" ]]; then
    query="steampowered.com"
fi

list=$(rbw list --fields name,user | tr '\t' '/')

selected=$(echo "$list" | wofi -S dmenu -Q "$query") || exit 2
user=$(echo "$selected" | cut -d / -f2)
url=$(echo "$selected" | cut -d / -f1)

if [ -n "$1" ]; then
    field="$1"
    shift 1
else
    fields="Password
Username
OTP
URL
Fill"

    field=$(printf "$fields" | wofi -S dmenu) || field="password"
fi

secret=0

case "${field,,}" in
    "username")
        value="$user"
        ;;
    "url")
        value="$url"
        ;;
    "password")
        value="$(rbw get "$url" "$user")" && [ -n "$value" ] || \
            { notify-send "Error" "No password for $selected" -i error -t 6000; exit 3; }
        secret=1
        ;;
    "otp")
        value="$(rbw code "$url" "$user")" || \
            { notify-send "Error" "No OTP for $selected" -i error -t 6000; exit 3; }
        secret=1
        ;;
    "fill")
        password="$(rbw get "$url" "$user" | head -n 1)" && [ -n "$password" ] || \
            { notify-send "Error" "No password for $selected" -i error -t 6000; exit 3; }
        wtype "$user" -s 50 -k tab -s 50 "$password"
        if otp="$(rbw code "$url" "$user")" && [ -n "$otp" ]; then
            field="OTP"
            value="$otp"
            secret=1
        fi
        ;;
    *)
        exit 4
esac

if [ -n "$value" ]; then
    if [ "$secret" = 1 ]; then
        mime="text/secret"
    else
        mime="text/plain"
    fi
    wl-copy -t "$mime" "$value"
fi
