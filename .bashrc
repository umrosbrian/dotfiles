# for commit
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# my additions
set -o vi # use Vi keybindings in the terminal

# This pertains to the repo at github.com/umrosbrian/dotfiles and is described in the README.md file.
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

#change colors that ls displays to make it more readable on tmux's white background
#found this at https://askubuntu.com/questions/466198/how-do-i-change-the-color-for-directories-with-ls-in-the-console
LS_COLORS=$LS_COLORS:'ex=0;35:' ; export LS_COLORS #makes executables purple
LS_COLORS=$LS_COLORS:'fi=0;32:' ; export LS_COLORS #makes files green

# User specific aliases and functions
alias killtmux="tmux kill-server"
alias temp="curl wttr.in/?0" # browse to https://wttr.in/:help to see all the options
alias weather="curl wttr.in"
alias sshpi="ssh pi@raspberrypi" # use the hostname since I have the pi on the static address of 192.168.1.100 when connected via ethernet but the wi-fi connection is still dynamic

# set an environmental variable having the hostname since I'll be using it in tests in both this file and in ~/.functions
export HN=$(hostname | tr -d '\n') # the 'hostname' command appends a newline character to the hostname so in the test I'm removing it
# set machine specific configs
case $HN in
    webservervm)
        alias pwrds="vim ~/mini/pwrds.txt"
        alias mountMini="sshfs rosbrian@192.168.1.102:/Users/rosbrian ~/mini"
        alias mounta2h="sshfs -p 7822 imgexcom@mi3-ss107.a2hosting.com:/home/imgexcom a2h"
        alias ssha2h="ssh -p 7822 imgexcom@mi3-ss107.a2hosting.com"
        alias newtmux="tmux new-session \; rename-window vim \; new-window \; rename-window bash \; new-window \; rename-window a2hosting \; new-window -c "~/python/mypkg" \; rename-window python \; split-window -v -c "~/python/mypkg" \; split-window -h -c "~/python/scripts" \; select-pane -U \; split-window -h -c "~/python/scripts" \; select-pane -L \; select-window -t :1"
        # use an absolute path rather than relying upon expansion of ~ 
        # set the path to the parent of `mypkg` and put a `__init__.py` within `mypkg`
        export PYTHONPATH="/home/rosbrian/python"
        export PATH="$PATH:/home/rosbrian/python/scripts"
        alias userfolder="cd ~/mini/z/;ls"
        alias startjup="jupyter notebook --no-browser"
        source /dev/shm/vars
        alias sshdarter="ssh rosbrian@pop-os"
        #rm /dev/shm/vars
        ;;
            
    mini\.local)
        alias pwrds="vim ~/pwrds.txt"
        alias sshvm="ssh -L 8000:localhost:8888 rosbrian@192.168.1.229" # use port forwarding so that when jupyter is running on the vm the attached machine can use it
        alias userfolder="cd ~/z;ls"
        export PATH="$PATH:~/python/scripts:~/.local/bin/:~/bin" # pip3 will be in ~/.local/bin
        #source /tmp/vars
        #rm /tmp/vars
        ;;
    raspberrypi)
        alias mountMini="sshfs rosbrian@192.168.1.102:/Users/rosbrian ~/mini"
        ;;
    pop-os)
        alias mountMini="sshfs rosbrian@192.168.1.102:/Users/rosbrian ~/mini"
        alias sshvm="ssh -L 8000:localhost:8888 rosbrian@192.168.1.229" # use port forwarding so that when jupyter is running on the vm the attached machine can use it
        alias mountVM="sshfs rosbrian@192.168.1.229:/home/rosbrian ~/vm"
        alias newtmux="tmux new-session \; rename-window vim \; new-window \; rename-window bash"
        ;;
esac



IFS=$'\n'

#customize command prompt to show current process number and exit status of last command
#PS1="\!-\$?-\u@\h:\w\$ "

source ~/.functions

#set the editor you want to use when the \e metacommand is issued in the psql's interactive mode
export PSQL_EDITOR=/usr/local/bin/vim
#use vim as the editor when \e is issued in psql's interface
#export EDITOR=/usr/local/bin/vim
#set variables so that rather than typing 'PGPASSWORD=postgres psql -t -h 192.168.1.102 -U postgres macdb -c "..."' I can simply type 'psql' to connect to the mini's macdb
export PGDATABASE=macdb
export PGHOST=192.168.1.102
export PGPORT=5433
export PGPASSWORD=postgres
export PGUSER=postgres
export PGOPTIONS=--search_path=map,postgis

# make vim the editor for crontab
# This will only change the editor for the user.  To use the same editor for sudo use `sudo -E crontab -e`
export VISUAL=vim

# don't make any bell sounds
# oddly, sourcing .bashrc may not turn off bell sounds...you may have to close and reopen the terminal
set bell-style none
