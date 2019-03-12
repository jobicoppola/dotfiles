# ~/.bash_aliases :: jcopp.cfxd.net
#
# aliases
alias ls="ls --color"
alias ll="ls -lh"
alias la="ll -a"
alias lsh="ll -S"
alias lshr="ll -Sr"
alias ltr="ll -tr"
alias latr="ll -atr"
#
# cd
alias dl="cd ~/downloads"
alias tor="cd ~/downloads/torrents"
alias bin="cd ~/bin"
alias logs="cd ~/logs"
alias wgets="cd ~/wgets"
alias curls="cd ~/curls"
alias lbin="cd /usr/local/bin"
alias dbox="cd ~/Dropbox"
alias dbin="cd  ~/Dropbox/jhome/bin"
alias gitdot='cd ~/git/dotfiles && git st'
alias venvs='cd ~/venvs/'
#
# vi
alias vi='vim'
alias jcc="vi ~/Dropbox/jhome/jc3"
alias vbash="vi ~/git/dotfiles/.bashrc"
alias sbash="cp -p ~/git/dotfiles/.bash* ~/ && . ~/.bashrc"
alias svim="cp -p ~/git/dotfiles/.vimrc ~/"
alias valias="vi ~/git/dotfiles/.bash_aliases"
alias vvim="vi ~/git/dotfiles/.vimrc"
#
# cmd
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias Grep="grep"
alias getip='wget -qO - icanhazip.com'
alias gi="gem install --no-rdoc --no-ri"
alias gu="gem update --no-rdoc --no-ri"
alias tail="grc tail"
alias diff="colordiff"
alias less='less -IR'
alias pipup='pip install --upgrade'
alias fib='echo 0,1,1,2,3,5,8,13,21,34,55,89,144'
alias mtr='mtr --curses'
alias mtail='multitail'
alias emo='emojify'
alias emol='emo --list'
alias emog='emol |grep'
#
# git
alias cdgit='cd ~/git/'
alias gp='git push'
alias gpl='git pull'
alias gpr='git pull --rebase'
alias gst='git status -sb'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gcma='git commit -am'
alias gd='git diff --color-words'
alias gra='git remote add'
alias grr='git remote rm'
alias gl='git log'
alias glf='git log --name-status --oneline'
alias ga='git add'
alias gctb='git checkout --track -b'
alias gctbe="echo 'git checkout --track -b <loc_branch> origin/<rem_branch>'"
alias gph='git push heroku master'
#
# virtualenv
# courtesy @doughellman
alias v='workon'
alias v.deactivate='deactivate'
alias v.mk='mkvirtualenv --no-site-packages'
alias v.mk_withsitepackages='mkvirtualenv'
alias v.rm='rmvirtualenv'
alias v.switch='workon'
alias v.add2virtualenv='add2virtualenv'
alias v.cdsitepackages='cdsitepackages'
alias v.cd='cdvirtualenv'
alias v.lssitepackages='lssitepackages'
#
# django aliases
alias mpy='python manage.py'
alias mpys='python manage.py shell'
alias mpydbs='python manage.py dbshell'
alias mpyrs='python manage.py runserver'
alias mpysm='python manage.py schemamigration'
alias mpysma='python manage.py schemamigration --auto'
#
# ansible
alias ansibleupdate='git pull --rebase && git submodule update --init --recursive'
#
# ag aka silver surfer
alias aga='ag --all-types --hidden'
#
# rg aka ripgrep
alias rga='rg --no-ignore --hidden --ignore-case'
#
# fzf
alias fzp='fzf --preview "head -100 {}"'
