SESSIONNAME=$1

# set up right hand side nested session, dont attach to it yet
tmux new-session -d -s $SESSIONNAME-right \; \
   rename-window docker \; \
   split-window -v -p 5\; \
   setw synchronize-panes \; \
   send-keys 'clear' C-m \; \
   setw synchronize-panes\;

# set up left hand side nested session, dont attach to it yet
tmux new-session -d -s $SESSIONNAME-left \; \
   rename-window host \; \
   split-window -v -p 5\; \
   setw synchronize-panes \; \
   send-keys 'clear' C-m \; \
   setw synchronize-panes\;

# attach and set up host session, and from there attach to nested sessions
tmux new-session -s $SESSIONNAME \; \
   set status off \; \
   split-window -h \; \
   setw synchronize-panes \; \
   send-keys 'unset TMUX' C-m \; \
   setw synchronize-panes off\; \
   select-pane -t 1 \; \
   send-keys 'tmux attach -d -t ' $SESSIONNAME-left C-m\; \
   select-pane -t 2 \; \
   send-keys 'tmux attach -d -t ' $SESSIONNAME-right C-m\;
