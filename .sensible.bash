# shamelessly stolen from:
#
# https://github.com/mrzool/bash-sensible/blob/master/sensible.bash
#
#
## SMARTER TAB-COMPLETION (Readline bindings) ##
#
# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"
#
# Treat hyphens and underscores as equivalent (just for completion)
bind "set completion-map-case on"
#
# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"
#
# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"
#
