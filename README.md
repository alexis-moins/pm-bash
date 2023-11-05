<div align='center'>

```
                  
                  
  _ __  _ __ ___  
 | '_ \| '_ ` _ \ 
 | |_) | | | | | |
 | .__/|_| |_| |_|
 | |              
 |_|              
```

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)

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

### Using pm

```bash
# Clone the repository
git clone git@github.com:alexis-moins/pm.git ~/.pm

# Let pm create the symbolic link for you!
cd ~/.pm && ./pm link
```

The last command creates a symbolic link to the `pm` script in the `~/.local/bin/` directory. You can also change the link destination path with the optional `path` argument.
```bash
./recipe link /usr/local/bin/
```

### Manually

Clone the repository then move the [pm](pm) script to `~/.local/bin/` or anywhere in your `PATH`, and ensure it is executable!

## Quick Start

After installing, you can follow these steps to quickly see how it works:

```bash
# First initialize pm
pm init

# Add a new space (a 'default' space is setup by pm for you)
pm space add personal

# You can then create new projects in this space
pm new portal --space personal

# Opening the project is even simpler
pm open personal/portal

# You can even clone github repositories
pm clone alexis-moins/portfolio personal/portfolio
```

## Tmux integration

`pm` comes with the following interactive tmux keybindings:

| Keybinding   | Command        | Code                                         | Description                                        |
| ------------ | -------------- | -------------------------------------------- | -------------------------------------------------- |
| `Leader + o` | `pm tmux open` | `bind-key o display-popup -E 'pm tmux open'` | Select an existing project to navigate to          |
| `Leader + -` | `pm tmux new`  | `bind-key - display-popup -E 'pm tmux new'`  | Create a new project and create a new tmux session |

You will be asked to add them to your tmux config when running `pm init` but you can also manually add them by running
```bash
pm tmux keybindings >> ~/.tmux.conf
```

## Usage

```
$ pm

pm - Project manager built on top of tmux

Usage:
  pm COMMAND
  pm [COMMAND] --help | -h
  pm --version | -v

PROJECT Commands:
  new      Create a new empty project
  clone    Clone a remote git repository
  open     Open a project in a tmux session
  filter   Filter projects by name
  list     List projects

SCRIPT Commands:
  dir      Show projects' root directory
  link     Create a link to this script
  update   Update to the latest version

Commands:
  space    Create, delete or list spaces
  tmux     Commands for tmux integration

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
```

