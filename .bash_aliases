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
alias sites="cd ~/Sites"
alias fpro="cd ~/Sites/faderpro-k23/"
alias dtop="cd ~/Desktop"
alias dl="cd ~/downloads"
alias tor="cd ~/downloads/torrents"
alias bin="cd ~/bin"
alias logs="cd ~/logs"
alias wgets="cd ~/wgets"
alias curls="cd ~/curls"
alias crash="cd /Library/Logs/CrashReporter"
alias lbin="cd /usr/local/bin"
alias apache="cd /Library/Apache2"
alias tmate="cd ~/Library/Application\ Support/TextMate"
alias prefs="cd ~/Library/Preferences"
alias zen="cd /usr/local/zenoss"
alias notes="cd ~/Files/notes"
alias dbox="cd ~/Dropbox"
alias dbin="cd  ~/Dropbox/jhome/bin"
alias mampsql="cd /Applications/MAMP/Library/bin;pwd;./mysql -u root -p"
alias snbin="cd ~/ec2/sn/bin"
alias stp="cd ~/Library/Application\ Support/Sublime\ Text\ 2/Packages"
alias gitdot='cd ~/git/dotfiles && git st'
alias gitchef='cd ~/git/chef-repo'
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
alias Grep="grep"
alias dnsflush='dscacheutil -flushcache'
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias getip='echo "$(curl -s http://automation.whatismyip.com/n09230945.asp)"'
alias rdp="$(which rdio) play"
alias gi="gem install --no-rdoc --no-ri"
alias tail="grc tail"
alias diff="colordiff"
alias fplog="tail -100f /Users/jcopp/Sites/faderpro-k23/application/logs/$(date +'%Y-%m-%d').log.php"
alias less='less -IR'
alias mongod='mongod run --config /usr/local/Cellar/mongodb/2.0.2-x86_64/mongod.conf'
alias linkmysql='ln -s /Applications/MAMP/tmp/mysql/mysql.sock /tmp/mysql.sock'
alias pipup='pip install --upgrade'
alias fib='echo 0,1,1,2,3,5,8,13,21,34,55,89,144'
alias rcli='/Users/jcopp/venvs/redmine-py-cli/bin/python /Users/jcopp/venvs/redmine-py-cli/app/redmine.py'
alias mtr='mtr --curses'
#
# git
alias cdgit='cd ~/git/'
alias gp='git push'
alias gpl='git pull'
alias gst='git status'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gcma='git commit -am'
alias gd='git diff --color-words'
alias gra='git remote add'
alias grr='git remote rm'
alias gl='git log'
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
