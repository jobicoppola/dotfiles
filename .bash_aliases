# shellcheck shell=bash
#
#^=>•</\>•<=-------------------------------------------------------------------
#
#-
# ~/.bash_aliases :: jcopp.cfxd.net
#=-----------------------------------------------------------------------------
#`

# aliases
alias ls="ls --color"
alias ll="ls -lh"
alias la="ll -a"
alias lsh="ll -S"
alias lshr="ll -Sr"
alias ltr="ll -tr"
alias latr="ll -atr"

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
alias gitdot='cd ~/git/github/dotfiles && git st'
alias venvs='cd ~/venvs/'

# vi
alias vi='vim'
alias vif='vi "$(fzf)"'
alias vifp='vi "$(fzf -m --preview="bat --color=always --theme=zenburn {}")"'
alias sbash=". ~/.bashrc"
alias vbash="vi ~/git/github/dotfiles/.bashrc"
alias jcc="vi ~/Dropbox/sync/shell/legacy/jc3"
alias svim="cp -p ~/git/github/dotfiles/.vimrc ~/"
alias valias="vi ~/git/github/dotfiles/.bash_aliases"
alias vvim="vi ~/git/github/dotfiles/.vimrc"

# cmd
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias Grep="grep"
alias getip='wget -qO - https://icanhazip.com'
alias gi="gem install --no-rdoc --no-ri"
alias gu="gem update --no-rdoc --no-ri"
alias tail="grc tail"
alias diff="colordiff"
alias less='less -iRFX'
alias pipup='pip install --upgrade'
alias fib='echo 0,1,1,2,3,5,8,13,21,34,55,89,144'
alias mtr='mtr --curses'
alias mtail='multitail'
alias mvi='mv -i'
alias emo='emojify'
alias emol='emo --list'
alias emog='emol |grep'
alias nodig='dig +nocmd +nostats +nocomments'

# git
alias cdgit='cd ~/git/'
alias gp='git push'
alias gpl='git pull'
alias gpr='git pull --rebase'
alias gst='git status -sb'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gcma='git commit -am'
alias gd='git diff'
alias gds='git diff --stat'
alias gdno='git diff --name-only'
alias gdns='git diff --name-status'
alias gdc='git diff --color-words'
alias gra='git remote add'
alias grr='git remote rm'
alias gl='git log'
alias glc='git show --name-only $(git rev-parse HEAD)'
alias glf='git log --name-status --oneline'
alias ga='git add'
alias gctb='git checkout --track -b'
alias gph='git push heroku master'
alias gpuo='git push -u origin'
alias grwm='git fetch && git rebase origin/master'
alias grwmm='git fetch && git rebase origin/main'
alias gpf='git push --force-with-lease'

# github
alias gistit='gist --shorten --copy'
alias prgist='gistit --private'
alias pgist='gistit --paste'
alias hpr='hub pull-request'
alias gitshort='curl -i https://git.io -F'

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

# django aliases
alias mpy='python manage.py'
alias mpys='python manage.py shell'
alias mpydbs='python manage.py dbshell'
alias mpyrs='python manage.py runserver'
alias mpysm='python manage.py schemamigration'
alias mpysma='python manage.py schemamigration --auto'

# ansible
alias ansibleupdate='git pull --rebase && git submodule update --init --recursive'

# rg aka ripgrep
alias rga='rg --no-ignore --hidden --ignore-case'

# fzf
alias fzh='fzf --preview "head -100 {}"'
alias fzp='fzf --preview="bat --color=always --theme=zenburn {}"'

# fd fast find
alias fdh='fd --hidden'
alias fde='fd --extension'
alias fda='fd --no-ignore --hidden'

# t task manager
alias t='python ~/git/github/t/t.py --task-dir ~/tasks --list tasks'
alias g='python ~/git/github/t/t.py --task-dir ~/tasks --list groceries'
alias m='python ~/git/github/t/t.py --task-dir ~/tasks --list music'

# http status codes reference
alias http-status='httpsc'
alias hsc='httpsc'

# curl
ak_headers=(
    akamai-x-cache-on
    akamai-x-cache-remote-on
    akamai-x-check-cacheable
    akamai-x-get-cache-key
    akamai-x-get-extracted-values
    akamai-x-get-nonces
    akamai-x-get-ssl-client-session-id
    akamai-x-get-true-cache-key
    akamai-x-serial-no
)
# shellcheck disable=SC2139
alias acurl="curl -H 'Pragma: ${ak_headers[*]}' -sSiLD - -o /dev/null"
alias scurl="curl -sSiLD - -o /dev/null"
