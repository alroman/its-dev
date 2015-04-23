## Bash colors

#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
# Add git support to prompt
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export CLICOLOR=1
#export LSCOLORS=ExFxBxDxCxegedabagacad
export LSCOLORS=GxFxCxDxBxegedabagaced
# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

#export PS1='[\[\033[32m\]\u\[\033[m\]: \[\033[01;34m\]\W\[\033[00m\]$(declare -F __git_ps1 &>/dev/null && __git_ps1 " \[\e[0;34m\](%s)\[\e[0m\]")]\$ '

export PS1='[\[\033[35m\]\u\[\033[m\]: \[\033[01;35m\]\W\[\033[00m\]$(declare -F __git_ps1 &>/dev/null && __git_ps1 " \[\e[01;32m\](%s)\[\e[0m\]")]\$ '

#alias ls='ls -G'
alias ll='ls -Gla'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

## Brew support
source `brew --repository`/Library/Contributions/brew_bash_completion.sh

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi


#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

## Sublime shortcut
#alias e='subl . &'


## Add MAMP PHP and MySQL
#export PATH=/Applications/MAMP/Library/bin:/Applications/MAMP/bin/php/php5.3.3/bin:$PATH
#export PATH=/Applications/MAMP/Library/bin:/Applications/MAMP/bin/php/php5.5.10/bin:$PATH

## Increase history buffer size
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTCONTROL=ignoreboth

#export PATH=/usr/local/share/npm/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
