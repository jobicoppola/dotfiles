# shellcheck shell=bash
#
#-=>•</\>•<=-------------------------------------------------------------------
#
# .bash_aliases :: jcopp.cfxd.net
#
# - 'Single quotes' will be evaluated dynamically each time the alias is used
# - "Double quotes" will be evaluated once when the alias is created
#
#=-----------------------------------------------------------------------------
#`

# ls
#
eval "$(gdircolors)"         # get `ls` to colorize orphaned links on macos
alias ls="gls --color=auto"  # alias ls="ls --color"
alias ll="ls -lh"
alias la="ll -a"
alias lsh="ll -S"
alias lshr="ll -Sr"
alias ltr="ll -tr"
alias latr="ll -atr"
alias lld="ll --group-directories-first"

# cd / navigation
#
alias dl="cd ~/downloads"
alias tor="cd ~/downloads/torrents"
alias bin="cd ~/bin"
alias logs="cd ~/logs"
alias wgets="cd ~/wgets"
alias curls="cd ~/curls"
alias lbin="cd /usr/local/bin"
alias dtop="cd ~/Desktop"
alias dbox="cd ~/Dropbox"
alias dbin="cd  ~/Dropbox/jhome/bin"
alias gitdot='cd ~/git/github/jobicoppola/dotfiles && git st'
alias venvs='cd ~/venvs/'
#
alias cdghjc='cd ~/git/github/jobicoppola'
alias cdgh='cd ~/git/github'
alias cdgl='cd ~/git/gitlab'
alias cdbb='cd ~/git/bitbucket'
alias cdprojects='cd ~/projects'
alias cdansible='cd ~/projects/ansible'
alias cdsync='cd ~/Dropbox/sync'
alias cdsyncsh='cd ~/Dropbox/sync/shell'
alias cdnotes='cd ~/Dropbox/files/notes'
alias cdwords='cd ~/Dropbox/files/notes/words'
alias cdu='cd ../'
alias cdu2='cd ../../'
alias cdu3='cd ../../../'
alias cdu4='cd ../../../../'

# vi
#
alias vi='vim'
alias sbash=". ~/.bashrc"
alias vbash="vi ~/git/github/jobicoppola/dotfiles/.bashrc"
alias jcc="vi ~/Dropbox/sync/shell/legacy/jc3"
alias svim="cp -p ~/git/github/jobicoppola/dotfiles/.vimrc ~/"
alias valias="vi ~/git/github/jobicoppola/dotfiles/.bash_aliases"
alias vvim="vi ~/git/github/jobicoppola/dotfiles/.vimrc"
alias vioneliners='vi ~/Dropbox/sync/shell/one-liners'
alias viquotes='vi ~/Dropbox/files/notes/misc/quotes.md'
alias vlans='~/venvs/vlans/bin/python ~/venvs/vlans/vlans.py'

# cmd various
#
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias Grep='grep'
alias getip='wget -qO - https://icanhazip.com'
alias gi='gem install --no-rdoc --no-ri'
alias gu='gem update --no-rdoc --no-ri'
alias tail='grc tail'
alias diff='colordiff'
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
alias dnsflush='dscacheutil -flushcache'

# git
#
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
alias tagsort='git tag |sort -V'

# github
#
alias gistit='gist --shorten --copy'
alias prgist='gistit --private'
alias pgist='gistit --paste'
alias hpr='hub pull-request'
alias hpro='hub pull-request --labels ops'
alias gitshort='curl -i https://git.io -F'

# virtualenv
# courtesy @doughellman
#
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

# django
#
alias mpy='python manage.py'
alias mpys='python manage.py shell'
alias mpydbs='python manage.py dbshell'
alias mpyrs='python manage.py runserver'
alias mpysm='python manage.py schemamigration'
alias mpysma='python manage.py schemamigration --auto'

# ansible
#
alias anv='ansible-vault'
alias anvv="python2 \$HOME/bin/ansible-inline-vault-view"
alias anve="ansible_vault_encrypt_oneline_string"
alias anvec="ansible_vault_encrypt_oneline_string | pbcopy"
alias anvd="sed -E 's/^[ \t]+//g' | ansible-vault decrypt 2>/dev/null"
alias anves="ansible-vault encrypt_string"
alias ansibleupdate='git pull --rebase && git submodule update --init --recursive'

# rg aka ripgrep
#
alias rga='rg --no-ignore --hidden --ignore-case' # prioritize over rga aka ripgrep-all below
alias rgi="rg --no-ignore --hidden --smart-case -g='!.git' -g='!site-packages/'"
alias rgblanks="rga -g='!.git' -g='!venv/' '[[:blank:]]$' ."
alias rgaf='rga-fzf' # rga aka ripgrep-all tool to search pdf zip gz etc
alias rgafo='rga-fzf-open'

# fd fast find
#
alias fdh='fd --hidden'
alias fde='fd --extension'
alias fda='fd --no-ignore --hidden'
alias fdi='fd --no-ignore'

# t task manager
#
alias t='python ~/git/github/t/t.py --task-dir ~/tasks --list tasks'
alias g='python ~/git/github/t/t.py --task-dir ~/tasks --list groceries'
alias m='python ~/git/github/t/t.py --task-dir ~/tasks --list music'

# http status codes reference
#
alias http-status='httpsc'
alias hsc='httpsc'

# k8s
#
alias k='kubectl'
alias kx='kubectx'
alias kn='kubens'
alias ybat='bat -p --theme="gruvbox-dark" -l yaml'

# jira
#
alias jb='jira browse'
alias jms='jira mine --size small'
#
eval "$(jira --completion-script-bash)" # jira cli completions

# use bundler to manage ruby applications
#
alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

# curl
#
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

# weather
#
alias wttr='WTTR_PARAMS=0 bash wttr'
alias wttr1='WTTR_PARAMS=1Fq bash wttr'

# sound generation
#
# requires `sox`, which installs the `play` command; see HN link:
# https://news.ycombinator.com/item?id=32998960
#
alias brownnoise='play -n synth brownnoise synth pinknoise mix synth sine amod 0.3 10'
alias whitenoise='play -q -c 2 -n synth brownnoise band -n 1600 1500 tremolo .1 30'
alias pinknoise='play -t sl -r48000 -c2 -n synth -1 pinknoise .1 80'

# source other custom alias files from dotfiles config dir
#
config=~/.config/$(whoami)/dotfiles
#
[ -f "$config/.bash_sensible" ] && . "$config/.bash_sensible"
