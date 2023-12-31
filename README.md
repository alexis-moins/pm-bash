<div align='center'>

```
                  
                  
  _ __  _ __ ___  
 | '_ \| '_ ` _ \ 
 | |_) | | | | | |
 | .__/|_| |_| |_|
 | |              
 |_|              
```

![Version](https://img.shields.io/badge/version-1.3.0-blue.svg)

</div>

---

`pm` is a bash script allowing users to rapidly create new projects. It integrate with tmux to allow for a seemless navigation.

## Prerequisites

- bash 4.0 or higher
- [gum](https://github.com/charmbracelet/gum)
- [fd](https://github.com/sharkdp/fd)
- tmux
- git


## Installation

Clone the repository:
```bash
git clone git@github.com:alexis-moins/pm.git ~/.pm
```

And let pm create the symbolic link for you!
```bash
cd ~/.pm && ./pm link
```

The last command creates a symbolic link to the `pm` script in the `~/.local/bin/` directory. You can also change the link destination path with the `PM_LINK` environment variable.

> If you wish to change the default install location, feel free to do so! Just remember to set the `PM_INSTALL` environment variable to point to the right location.

## Quick Start

After installing, you can follow these steps to quickly see how it works:

```bash
# Add a new space (a 'default' space is setup by pm for you)
pm space add personal

# You can then create new projects in this space
pm new portal --space personal

# Opening the project is even simpler
pm open portal --space personal

# You can even clone github repositories
pm clone alexis-moins/portfolio --space work
```

## Tmux integration

`pm` comes with the following default tmux keybindings:
```bash
# Leader + o: open a pm project
bind-key o display-popup -E "pm open"

# Leader + -: create a new pm project
bind-key - display-popup -E "pm tmux new"
```

You can either add them to your tmux config manually or by running the following command which will append the keybindings to your configuration.
```bash
pm keybindings --set
```

## Usage

```
$ pm

pm - Project manager built on top of tmux

Usage:
  pm COMMAND
  pm [COMMAND] --help | -h
  pm --version | -v

Commands:
  help     Show help about a command
  dir      Show projects' root directory
  space    Create, delete or list spaces
  link     Create a link to this script
  update   Update to the latest version
  tmux     Commands for tmux integration
  env      Show environment information

PROJECT Commands:
  new      Create a new empty project
  clone    Clone a remote git repository
  open     Open a project in a tmux session
  filter   Filter projects by name
  list     List projects

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Environment Variables:
  PM_INSTALL
    Directory where the repository was cloned
    Default: ~/.pm

  PM_HOME
    Directory where the projects will be managed
    Default: ~/dev

  PM_LINK
    Directory where the script will be linked
    Default: ~/.local/bin
```
