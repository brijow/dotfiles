# stop tmux from sourcing /etc/profile and effectively prepending /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin to path
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

# Suppress iterm warning of default shell not being zsh
export BASH_SILENCE_DEPRECATION_WARNING=1
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# Aliases
alias ls="ls -lG"
#alias ls='ls --color=auto'
alias ll="ls -laG"
alias x="exit"
alias tmn="bash ~/scripts/tmuxScript.sh"
#alias tmn="bash ~/.scripts/tmux-new-session-2"
alias tmnn="bash ~/scripts/tmuxScriptNested.sh"
alias tma="tmux a -t"
alias tm="tmux"
alias csdb="bash ~/.scripts/cscopeDB.sh"
#alias r-env="conda activate r_env"
#alias py-env="conda activate python_env"
#alias java-env="conda activate java_env"
#alias web-env="conda activate web_env"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias 'em'='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
alias got='/usr/local/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# PS1 config
#export PS1="\[\033[38;5;251m\][\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;208m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;251m\]][\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;39m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;251m\]]\n🐍 "
#export PS1="\[\033[38;5;251m\][\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;208m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;251m\]][\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;39m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;251m\]]\n🐍 \[$(tput sgr0)\]"
export PS1="\n\[\033[1;36m\]\u\[\033[0m\]:\[\033[1;32m\]\w\[\033[0m\] 🐍  "

#PS1='[\u@\h \W]\$ '
#export PS1="\n\[\033[1;32m\] 👽 \u@\h\[\033[0m\]:\[\033[1;32m\]\w\[\033[0m\] "
#export PS1="\n\[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;32m\]\w\[\033[0m\] "
#export TERM="xterm-256color"
#export TERMINAL=/usr/bin/termite
#export EDITOR=/usr/bin/nvim

# Fix for a issue I was having from reddit script:
# https://stackoverflow.com/questions/54067580/programatically-set-a-env-var-for-each-tmux-session
if [[ -n $TMUX ]]; then
    session=$(tmux display-message -p '#S')
    address="/tmp/$session"
    export NVIM_LISTEN_ADDRESS="$address"
fi


# https://www.reddit.com/r/neovim/comments/aex45u/integrating_nvr_and_tmux_to_use_a_single_tmux_per/
#nv() {
#  if [[ $TMUX ]] 
#    then
#        local pane_id=$(tmux list-panes -F '#{pane_id} #{pane_current_command}' | grep nvim|cut -f1 -d' '|head -n1)
#        if [[ $pane_id ]]
#        then
#            tmux select-pane -t $pane_id
#        fi
#    fi
#  ~/miniconda3/bin/nvr -s $@
#}

# Step 1: connect to yogaserver
function yoga(){
    ssh localadmin@192.168.1.70 -Y
}

# Step 2: on server, run jupyter or jupyter-lab on port 8888 (this is already default)
#  jupyter notebook --no-browser --port=8888
#         OR
#  jupyter-lab --no-browser --port=8888

# Step 3: Forward remote's port 8888 to local port 8889
#  e.g., jptt 8889 8888
function jptt(){
    # Forwards port $1 (remote's localhost) into port $2 (local's localhost) and listens to it
    #ssh -N -f -L localhost:$2:localhost:$1 localadmin@192.168.1.70
    ssh -N -f -L localhost:8889:localhost:8888 localadmin@192.168.1.70
}

# Step 4: check the local process listening on port 8889
#  e.g., ljptt 8889
function ljptt(){
    # Forwards port $1 (remote's localhost) into port $2 (local's localhost) and listens to it
    #sudo lsof -iTCP:$1 -sTCP:LISTEN
    sudo lsof -iTCP:8889 -sTCP:LISTEN
}


# Step 5: Finally, kill the process if one showed up in step 4
#  e.g., "kill <number>"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/brijow/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/brijow/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/brijow/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/brijow/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
conda activate dev
# <<< conda initialize <<<

#export PATH="$PATH:/home/brian/.config/nvim/nvimr-tmux-config"
export PYTHONDONTWRITEBYTECODE=1
export HOST=localhost
