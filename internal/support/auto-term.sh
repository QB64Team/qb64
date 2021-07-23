#!/bin/sh
# list taken from i3-sensible-terminal(1)
terms="'$TERM' '$TERMINAL' terminal x-terminal-emulator xdg-terminal urxvt rxvt termit terminator Eterm aterm uxterm xterm gnome-terminal roxterm xfce4-terminal termite lxterminal mate-terminal terminology st qterminal lilyterm tilix terminix konsole kitty guake tilda alacritty hyper"

for term in $terms; do
  if [ $(command -v $term) ]; then
    useterm=$term
    break
  fi
done
printf $term
