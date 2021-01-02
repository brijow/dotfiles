#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias x='exit'
alias tmn="bash ~/.scripts/tmux-new-session-2"
alias tma="tmux a -t"
alias tm="tmux"
alias csdb="bash ~/.scripts/cscopeDB.sh"

#PS1='[\u@\h \W]\$ '
#export PS1="\n\[\033[1;32m\] 👽 \u@\h\[\033[0m\]:\[\033[1;32m\]\w\[\033[0m\] "
export PS1="\n\[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;32m\]\w\[\033[0m\] "
export TERM="xterm-256color"
export TERMINAL=/usr/bin/termite
export EDITOR=/usr/bin/nvim

# Fix for a issue I was having from reddit script:
# https://stackoverflow.com/questions/54067580/programatically-set-a-env-var-for-each-tmux-session
if [[ -n $TMUX ]]; then
    session=$(tmux display-message -p '#S')
    address="/tmp/$session"
    export NVIM_LISTEN_ADDRESS="$address"
fi

# https://www.reddit.com/r/neovim/comments/aex45u/integrating_nvr_and_tmux_to_use_a_single_tmux_per/
nv() {
  if [[ $TMUX ]] 
    then
        local pane_id=$(tmux list-panes -F '#{pane_id} #{pane_current_command}' | grep nvim|cut -f1 -d' '|head -n1)
        if [[ $pane_id ]]
        then
            tmux select-pane -t $pane_id
        fi
    fi
  ~/miniconda3/bin/nvr -s $@
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/brian/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/brian/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/brian/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/brian/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export PATH="$PATH:/home/brian/.config/nvim/nvimr-tmux-config"
export PYTHONDONTWRITEBYTECODE=1

alias got='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
