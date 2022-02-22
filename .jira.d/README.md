# JIRA CLI

This directory contains basically just a starter pack for using:

[go-jira](https://github.com/go-jira/jira)

which is a Jira command line tool.  Here we are simply providing some custom
templates and commands to help anyone who would prefer to use cli instead of
the browser to manage their Jira tickets.

# Installation

First install `go` and `go-jira`:

* macOS: `brew install go-jira`
* Windows: install binaries for [go](https://golang.org/dl/) and
  [go-jira](https://github.com/go-jira/jira/releases)
* Linux: `[apt-get|yum] install golang` and then install binary for
  [go-jira](https://github.com/go-jira/jira/releases)

# Configuration

You can clone this repository to `~/.jira.d` or clone it wherever you want and
sync it into `~/.jira.d`.  Copy:

`config.example.yml` to `~/.jira.d/config.yml`

If you want tab completion, after installing `go-jira`, simply add the
following to your shell config (e.g. `~/.bashrc`):

    eval "$(jira --completion-script-bash)"

# Usage

* `usage: jira [<flags>] <command> [<args> ...]`

## Examples

Here are a few examples of how you might use this tool to get info from Jira:

* `jira print-project` - print name of currently configured project
* `jira mine` - show list of issues assigned to you
* `jira epics` - diplay list of epics in configured project
* `jira sprint` - show issues in active sprint
* `jira comment XYZ-0000` - add comment to issue (will open template in $EDITOR)
* `jira comment --noedit -m "example message" XYZ-0000` - add comment to issue
* `jira resolve XYZ-0000` - resolve issue, opens template in $EDITOR for comment
* `jira resolve --noedit -m "example msg" XYZ-0000` - resolve issue, with comment
* `jira create --issuetype Task -p XYZ` - create issue in "Xyz-name-here" project
* `jira epic add XYZ-0000 XYZ-XXXX` - add XYZ-XXXX to epic XYZ-0000
* `jira epic list XYZ-0000` - display issues in epic XYZ-0000
* `jira assign XYZ-0000 first.last` - assign issue to user
* `jira in-progress XYZ-0000` - move issue to status "in progress"
* `jira worklog add XYZ-0000` - open template in $EDITOR to add worklog
* `jira worklog add --noedit -T 1h XYZ-0000` - add 1hr of work with no description

# Known Issues

You still have to use Jira 😮

# Links

* [Jira](https://jira2.performgroup.com)
* [go-jira](https://github.com/go-jira/jira)

# Contact

