# Remove beeping
xset -b &

# Xresources
xrdb -merge $HOME/.Xresources

# Wallpaper
#feh --bg-fill <file location> &

# Start URxvt daemon
urxvtd -q -o -f &

# Map caps-lock to control
setxkbmap -option ctrl:nocaps

# WM
compton -CGb --config ~/.config/compton.conf
exec bspwm

