# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME=$HOME
# [[ $TERM != "screen" ]] && tmux && exit  # default tmux

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="fred"   # at custom folder
#ZSH_THEME="miloshadzic"
#ZSH_THEME="nebirhos"            # have rvm list

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby)
# plugins=(git ruby vi-mode)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/fred/.rvm/bin

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# alias
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# dir
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
function p { cd ~/project/$1; }
function h { cd ~/$1; }
 
# newly added by fred (20110915)
alias clr='clear'
function cc { wget -qO- "http://www.google.com/finance/converter?a=$1&from=$2&to=$3" | sed '/res/!d;s/<[^>]*>//g'; }
    
# newly added by fred (20110920)
alias grep='ack-grep'
alias g='ack-grep'

alias reload='source ~/.zshrc'

# newly added by fred (20111007)
function sql { psql igs_dev -c "$@" }

# from Calvin
alias cnull='cat /dev/null > '

# newly added by fred (20111128)
function pug  { ps aux | grep "$@" }
function pugs { ps aux | grep "$@" | sort }

alias tl='tail -f log/development.log'
alias tl10='tail log/development.log --lines=10'
alias tl20='tail log/development.log --lines=20'
alias tm='tmux attach || tmux new'
alias lc='bin/rake log:clear'

#####################################################
# git related
#####################################################
alias gdh='git diff HEAD'
alias gd='git diff'
alias tigfred='tig --author=fred.wong'
alias gsth='git stash list'
alias gsths='git stash save'
alias gsthp='git stash pop'
alias gsthd='git stash drop'
alias gstha='git stash apply'


# from alex ----------------
new_hotfix () {
  echo -n "Self create? "   
  read SELF_CREATE
  if [[ $SELF_CREATE =~ "y|Y|yes|Yes" ]]; then
    SELF_CREATE=true
  else
    SELF_CREATE=false
  fi
  echo -n "Old hotfix branch: "
  read OLD_HOTFIX
  echo -n "New hotfix branch: "
  read NEW_HOTFIX

  if [[ $SELF_CREATE == true ]]; then
    git flow hotfix start $NEW_HOTFIX
    git push origin hotfix/$NEW_HOTFIX
    git push origin :hotfix/$$OLD_HOTFIX
    git branch --set-upstream hotfix/$NEW_HOTFIX origin/hotfix/$NEW_HOTFIX
  else
    git checkout develop && git pull
    git checkout master && git pull
    git branch -d hotfix/$OLD_HOTFIX
    git branch --set-upstream hotfix/$NEW_HOTFIX origin/hotfix/$NEW_HOTFIX
    git remote prune origin
    git checkout hotfix/$NEW_HOTFIX
  fi
  echo -n "Done!"
}
# --------------- end from alex

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*:processes' command 'ps xo pid,user:10,cmd | ack-grep -v "sshd:|-zsh$"'

#zstyle ':completion:*:*:kill:*:processes' command 'ps --forest xo pid,user:10,cmd'
#zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'

#####################################################
# specific for amoebaba
#####################################################

alias psqlamoebadev='psql -d amoeba_dev'

# newly added by fred (20111228)
export TERM=xterm-256color
function tig { TERM=screen-256color /usr/bin/tig $@ }

# default cluster port
export PGPORT=5434 

# newly added by fred (20120131) - for ruby performance
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000


