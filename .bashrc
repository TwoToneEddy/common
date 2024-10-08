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

# Colors for the prompt
blue="\033[0;34m"
white="\033[0;37m"
green="\033[0;32m"

# Brackets needed around non-printable characters in PS1
ps1_blue='\['"$blue"'\]'
ps1_green='\['"$green"'\]'
ps1_white='\['"$white"'\]'

parse_git_branch() {
    gitstatus=`git status 2> /dev/null`
    if [[ `echo $gitstatus | grep "Changes to be committed"` != "" ]]
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1***)/'
    elif [[ `echo $gitstatus | grep "Changes not staged for commit"` != "" ]]
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1**)/'
    elif [[ `echo $gitstatus | grep "Untracked"` != "" ]]
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1*)/'
    elif [[ `echo $gitstatus | grep "nothing to commit"` != "" ]]
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    else
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1?)/'
    fi
}

# Echo a non-printing color character depending on whether or not the current git branch is the master    
# Does NOT print the branch name                                                                          
# Use the parse_git_branch() function for that.                                                           
parse_git_branch_color() {
    br=$(parse_git_branch)
    if [[ $br == "(master)" || $br == "(master*)" || $br == "(master**)" || $br == "(master***)" ]]; then
        echo -e "${blue}"
    else
        echo -e "${green}"
    fi
}

shopt | grep -q '^direxpand\b'&& shopt -s direxpand
shopt -s nocasematch
# No color:
#export PS1="@\h:\W\$(parse_git_branch) \$ "
# With color:
export PS1="$ps1_green@\h:$ps1_white\W\[\$(parse_git_branch_color)\]\$(parse_git_branch) $ps1_blue\$$ps1_white "
export GH="https://github.com/LeeHudsonDLS/"
export PATH="/home/lee/.local/bin:$PATH"
export PATH="/home/lee/clion-2019.2.5/bin:$PATH"
export PATH="/opt/gephi/bin:$PATH"
export PATH="$PATH:/opt"
export PIPENV_VENV_IN_PROJECT=1
alias g='gedit'
alias pi='ssh pi@raspberrypi'
alias cf="sudo socat PTY,link=$H/dev/ttyACM0,raw,echo=0  EXEC:'ssh pi@octopi.local socat - /dev/ttyUSB0'"
alias mm='platformio run -e sanguino_atmega1284p'
alias com='sudo chmod 777 /dev/ttyACM0'
alias com1='sudo chmod 777 /dev/ttyACM1'
alias com2='sudo chmod 777 /dev/ttyACM2'
alias com3='sudo chmod 777 /dev/ttyACM3'
alias com4='sudo chmod 777 /dev/ttyACM4'
alias com5='sudo chmod 777 /dev/ttyACM5'
alias ports="ls /dev | grep ttyACM"
alias windows='sudo /opt/reboot-into-windows'
alias usbw='grep . /sys/bus/usb/devices/*/power/wakeup'
alias reload='source ~/.bashrc'
alias b='/home/lee/common/scripts/commit.sh'
alias cura='LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libstdc++.so.6 /opt/Ultimaker-Cura-5.1.1-linux.AppImage'

# GPU
alias gpu='glxinfo|egrep "OpenGL vendor|OpenGL renderer"'
alias gpud='inxi -Gx'
alias nvid='nvidia-smi'



# Git
alias gs='git status -s'
alias gk='gitk --all &'
alias pull='git pull origin master'
alias push='git push origin master'
alias commit='git commit -m "Updates"'
alias add='git add *'
alias gr='git remote -v'
alias prune='git fetch --all --tags --prune'
alias tag='git describe --tags $(git rev-list --tags --max-count=1)'
alias tagl='git describe --tags $(git rev-list --tags --max-count=100)'


alias rpi='ssh pi@retropie'
alias elec='ssh root@351ELEC'
alias elec='ssh root@351ELEC'
alias ark='ssh root@rg351p'

# Work ssh
alias workssh='ssh -C -A -X jjc62351@ssh.diamond.ac.uk'
alias workfs6='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.3 /dls_sw/work/R3.14.12.3'
alias workfs7='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7 /dls_sw/work/R3.14.12.7'
alias workfsHome='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/home/jjc62351 ~/workHome'
alias workfsmpc='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/support/digitelMpc /dls_sw/work/R3.14.12.7/support/digitelMpc'
alias workfsd2afef='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/home/jjc62351/work/d2afe-firmware /home/lee/work/workfs/d2afe-firmware'
alias workfsd2afefu='fusermount -u /home/lee/work/workfs/d2afe-firmware'
alias workfsd2afe='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/support/d2afe /home/lee/work/workfs/d2afe'
alias workfsd2afeu='fusermount -u /home/lee/work/workfs/d2afe'
alias workfsdigitelMpc='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/support/digitelMpc /home/lee/work/workfs/digitelMpc'
alias workfsdigitelMpcu='fusermount -u /home/lee/work/workfs/digitelMpc'
alias workfspy='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/ioc/FE16B/FE16B-PY-IOC-01 /home/lee/work/workfs/FE16B-PY-IOC-01'
alias workfspyu='fusermount -u /home/lee/work/workfs/FE16B-PY-IOC-01'
alias workfsva='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/ioc/SR/SR-VA-IOC-04 /home/lee/work/workfs/SR-VA-IOC-04'

alias workfsvau='fusermount -u /home/lee/work/workfs/SR-VA-IOC-04'


alias workfsfe='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/support/FE /home/lee/work/workfs/FE'
alias workfsfeu='fusermount -u /home/lee/work/workfs/FE'

alias workfsmks937a='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/support/mks937a /home/lee/work/workfs/mks937a'
alias workfsmks937au='fusermount -u /home/lee/work/workfs/mks937a'

alias workfsmks937b='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/support/mks937b /home/lee/work/workfs/mks937b'
alias workfsmks937bu='fusermount -u /home/lee/work/workfs/mks937b'

alias workfsdlsPLC='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/support/jjc62351/dlsPLC /home/lee/work/workfs/dlsPLC'
alias workfsdlsPLCu='fusermount -u /home/lee/work/workfs/dlsPLC'

alias workfsWBPcs8000='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/support/WBPcs8000 /home/lee/work/workfs/WBPcs8000'
alias workfsWBPcs8000u='fusermount -u /home/lee/work/workfs/WBPcs8000'
alias workfsgirderDev='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/support/girderDev /home/lee/work/workfs/girderDev'
alias workfsgirderDevu='fusermount -u /home/lee/work/workfs/girderDev'

alias workfspmac='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/support/jjc62351/pmac /home/lee/work/workfs/pmac'
alias workfspmacu='fusermount -u /home/lee/work/workfs/pmac'

alias workfspmacCoord='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/support/pmacCoord /home/lee/work/workfs/pmacCoord'
alias workfspmacCoordu='fusermount -u /home/lee/work/workfs/pmacCoord'

alias workfsid='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/home/jjc62351/work/id02j /home/lee/work/workfs/id02j'
alias workfsidu='fusermount -u /home/lee/work/workfs/id02j'

alias workfsFE16I='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/ioc/FE16I /home/lee/work/workfs/FE16I'
alias workfsFE16Iu='fusermount -u /home/lee/work/workfs/FE16I'

alias workfszepto='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/support/zeptoQuadrupole /home/lee/work/workfs/zeptoQuadrupole'
alias workfszeptou='fusermount -u /home/lee/work/workfs/zeptoQuadrupole'

alias workfsec='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/R3.14.12.7/support/jjc62351/BL99I/BL99I-LCH-ECIOC-01 /home/lee/work/workfs/BL99I-LCH-ECIOC-01'
alias workfecu='fusermount -u /home/lee/work/workfs/BL99I-LCH-ECIOC-01'

alias workfsfv='sshfs -o reconnect jjc62351@ssh.diamond.ac.uk:/dls_sw/work/python3/RHEL7-x86_64/dls_fast_vacuum_utils /home/lee/work/workfs/dls_fast_vacuum_utils'
alias workfsfvu='fusermount -u /home/lee/work/workfs/dls_fast_vacuum_utils'

# VPN
alias socks='ssh -N -D9090 jjc62351@ssh.diamond.ac.uk'
alias vpn='sshuttle --dns --pidfile=/tmp/sshuttle.pid -HDr jjc62351@ssh.diamond.ac.uk 172.23.0.0/16 193.62.221.72/32'
alias vpnk='kill $(cat /tmp/sshuttle.pid)'

#retropie
alias ems='grep -nr --include emulators.cfg default /opt/retropie/configs'
alias emsl='grep -nr --include emulators.cfg default /home/lee/retropie/retropie/configs'

# Work Directories
alias work6='cd /dls_sw/work/R3.14.12.3'
alias work='cd /dls_sw/work/R3.14.12.7'
alias prod6='cd /dls_sw/prod/R3.14.12.3'
alias prod='cd /dls_sw/prod/R3.14.12.7'
alias w='cd ~/work'
alias mcu='make clean uninstall'
alias avr='avrdude -C/home/lee/common/avrdude.conf -v -v -v -v -patmega328p -cstk500v1 -P/dev/ttyACM0 -b19200'
alias gps='cd /home/lee/Documents/PlatformIO/Projects'

alias avrrf='avrdude -C/home/lee/common/avrdude.conf -v -v -v -v -F -patmega328p -cstk500v1 -P/dev/ttyACM0 -b19200 -Ulfuse:r:'

alias avraf='avrdude -C/home/lee/common/avrdude.conf -v -v -v -v -patmega328p -cstk500v1 -P/dev/ttyACM0 -b19200 -Ulfuse:w:0xFF:m'
alias avrefl='avrdude -C/home/lee/common/avrdude.conf -v -v -v -v -F -patmega328p -cstk500v1 -P/dev/ttyACM0 -b19200 -Ulfuse:w:0xE2:m'
alias avrefh='avrdude -C/home/lee/common/avrdude.conf -v -v -v -v -F -patmega328p -cstk500v1 -P/dev/ttyACM0 -b19200 -Uhfuse:w:0xDE:m'
alias avrefe='avrdude -C/home/lee/common/avrdude.conf -v -v -v -v -F -patmega328p -cstk500v1 -P/dev/ttyACM0 -b19200 -Uefuse:w:0xFD:m'
alias ledF='avrdude -C/home/lee/common/avrdude.conf -v -v -v -v -patmega328p -cstk500v1 -P/dev/ttyACM0 -b19200 -Ulfuse:w:0xE2:m -Uhfuse:w:0xDE:m -Uefuse:w:0xF5:m'

alias gpsf='avrdude -C/home/lee/common/avrdude.conf -v -v -v -v -patmega328p -cstk500v1 -P/dev/ttyACM0 -b19200 -Ulfuse:w:0xE2:m -Uhfuse:w:0xD9:m -Uefuse:w:0xFF:m'

alias rmn="rename 's/^\d+ //' *"
alias state="scp -r root@192.168.0.17:/storage/roms/savestates ."
alias net="nmap -sP 192.168.1.0/24 | grep report"

alias pifreq="watch -n 1 cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq"
alias pitemp="watch -n 1 -d /opt/vc/bin/vcgencmd measure_temp"
alias bt="sudo rfcomm bind 0 00:18:E4:40:00:06 1"
alias eagle="/opt/eagle-9.6.2/eagle &"


source ~/.git-completion1.7.1.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
