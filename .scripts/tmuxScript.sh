SESSIONNAME=$1

tmux new-session -s $SESSIONNAME \; \
   split-window -h -p 40\; \
   split-window -v -p 25\; \
   send-keys 'tmux select-pane -t 1' C-m\; \
   setw synchronize-panes \; \
   send-keys 'clear' C-m \; \
   setw synchronize-panes \;

#select-pane -t L C-m\;
