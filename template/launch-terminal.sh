#!/bin/sh

~/bin/tunnel.sh
sleep 1
exec gnome-terminal --full-screen -x tmux new-session -d 'irssi' \; split-window -d  -c '/home/hunter/dev' \; split-window -dh \; select-pane -D -t 0 \; split-window -dh \; attach
