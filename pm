#!/usr/bin/env bash
# This script was generated by bashly 1.0.5 (https://bashly.dannyb.co)
# Modifying it manually is not recommended

if [[ "${BASH_VERSINFO:-0}" -lt 4 ]]; then
  printf "bash version 4 or higher is required\n" >&2
  exit 1
fi

version_command() {
  echo "$version"
}

pm_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm - Local project manager\n"
    echo

  else
    printf "pm - Local project manager\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm COMMAND\n"
  printf "  pm [COMMAND] --help | -h\n"
  printf "  pm --version | -v\n"
  echo

  printf "%s\n" "Commands:"
  printf "  %s   Create a new empty project\n" "new   "
  printf "  %s   Clone a remote git repository\n" "clone "
  printf "  %s   Switch to a project\n" "switch"
  printf "  %s   Create a symbolic link to the pm script\n" "link  "
  printf "  %s   Print the root of the projects\n" "root  "
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo
    printf "  %s\n" "--version, -v"
    printf "    Show version number\n"
    echo

    printf "%s\n" "Environment Variables:"

    printf "  %s\n" "PM_ROOT_DIR"
    printf "    Root directory used to manage projects\n"
    printf "    Default: ${HOME}/dev\n"
    echo

    printf "  %s\n" "PM_MAX_DEPTH"
    printf "    Maximum depth to display sub-directories\n"
    printf "    Default: 2\n"
    echo

  fi
}

pm_new_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm new - Create a new empty project\n"
    echo

  else
    printf "pm new - Create a new empty project\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm new [NAME] [OPTIONS]\n"
  printf "  pm new --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--no-git, -n"
    printf "    Skip git repository initialization\n"
    echo

    printf "  %s\n" "--detach, -d"
    printf "    Don't create a tmux session\n"
    echo

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Arguments:"

    printf "  %s\n" "NAME"
    printf "    Name of the new project\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm new recipe --no-git\n"
    printf "  pm new personal/recipe --detach\n"
    echo

  fi
}

pm_clone_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm clone - Clone a remote git repository\n"
    echo

  else
    printf "pm clone - Clone a remote git repository\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm clone URL [DESTINATION]\n"
  printf "  pm clone --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Arguments:"

    printf "  %s\n" "URL"
    printf "    URL of the remote repository\n"
    echo

    printf "  %s\n" "DESTINATION"
    printf "    Where to clone the project (relative to the PM_ROOT_DIR)\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm clone git@github.com:alexis-moins/portal.git\n"
    printf "  pm clone git@github.com:alexis-moins/portal.git personal/portal\n"
    echo

  fi
}

pm_switch_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm switch - Switch to a project\n"
    echo

  else
    printf "pm switch - Switch to a project\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm switch [NAME]\n"
  printf "  pm switch --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Arguments:"

    printf "  %s\n" "NAME"
    printf "    Name of the project\n"
    echo

  fi
}

pm_link_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm link - Create a symbolic link to the pm script\n"
    echo

  else
    printf "pm link - Create a symbolic link to the pm script\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm link [PATH] [OPTIONS]\n"
  printf "  pm link --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--remove, -r"
    printf "    Remove the symbolic link instead\n"
    echo

    printf "  %s\n" "--source, -s SOURCE"
    printf "    Path to the directory containing the pm script\n"
    printf "    Default: ${HOME}/.pm\n"
    echo

    printf "  %s\n" "--copy, -c"
    printf "    Copy the script instead of creating a symbolic link\n"
    echo

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Arguments:"

    printf "  %s\n" "PATH"
    printf "    Path to the symbolic link\n"
    printf "    Default: ${HOME}/.local/bin\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm link /usr/local/bin\n"
    printf "  pm link --source ~/scripts/pm --remove\n"
    echo

  fi
}

pm_root_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm root - Print the root of the projects\n"
    echo

  else
    printf "pm root - Print the root of the projects\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm root\n"
  printf "  pm root --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

  fi
}

normalize_input() {
  local arg flags

  while [[ $# -gt 0 ]]; do
    arg="$1"
    if [[ $arg =~ ^(--[a-zA-Z0-9_\-]+)=(.+)$ ]]; then
      input+=("${BASH_REMATCH[1]}")
      input+=("${BASH_REMATCH[2]}")
    elif [[ $arg =~ ^(-[a-zA-Z0-9])=(.+)$ ]]; then
      input+=("${BASH_REMATCH[1]}")
      input+=("${BASH_REMATCH[2]}")
    elif [[ $arg =~ ^-([a-zA-Z0-9][a-zA-Z0-9]+)$ ]]; then
      flags="${BASH_REMATCH[1]}"
      for ((i = 0; i < ${#flags}; i++)); do
        input+=("-${flags:i:1}")
      done
    else
      input+=("$arg")
    fi

    shift
  done
}

inspect_args() {
  if ((${#args[@]})); then
    readarray -t sorted_keys < <(printf '%s\n' "${!args[@]}" | sort)
    echo args:
    for k in "${sorted_keys[@]}"; do echo "- \${args[$k]} = ${args[$k]}"; done
  else
    echo args: none
  fi

  if ((${#other_args[@]})); then
    echo
    echo other_args:
    echo "- \${other_args[*]} = ${other_args[*]}"
    for i in "${!other_args[@]}"; do
      echo "- \${other_args[$i]} = ${other_args[$i]}"
    done
  fi

  if ((${#deps[@]})); then
    readarray -t sorted_keys < <(printf '%s\n' "${!deps[@]}" | sort)
    echo
    echo deps:
    for k in "${sorted_keys[@]}"; do echo "- \${deps[$k]} = ${deps[$k]}"; done
  fi

}

print_in_color() {
  local color="$1"
  shift
  if [[ -z ${NO_COLOR+x} ]]; then
    printf "$color%b\e[0m\n" "$*"
  else
    printf "%b\n" "$*"
  fi
}

red() { print_in_color "\e[31m" "$*"; }
green() { print_in_color "\e[32m" "$*"; }
yellow() { print_in_color "\e[33m" "$*"; }
blue() { print_in_color "\e[34m" "$*"; }
magenta() { print_in_color "\e[35m" "$*"; }
cyan() { print_in_color "\e[36m" "$*"; }
bold() { print_in_color "\e[1m" "$*"; }
underlined() { print_in_color "\e[4m" "$*"; }
red_bold() { print_in_color "\e[1;31m" "$*"; }
green_bold() { print_in_color "\e[1;32m" "$*"; }
yellow_bold() { print_in_color "\e[1;33m" "$*"; }
blue_bold() { print_in_color "\e[1;34m" "$*"; }
magenta_bold() { print_in_color "\e[1;35m" "$*"; }
cyan_bold() { print_in_color "\e[1;36m" "$*"; }
red_underlined() { print_in_color "\e[4;31m" "$*"; }
green_underlined() { print_in_color "\e[4;32m" "$*"; }
yellow_underlined() { print_in_color "\e[4;33m" "$*"; }
blue_underlined() { print_in_color "\e[4;34m" "$*"; }
magenta_underlined() { print_in_color "\e[4;35m" "$*"; }
cyan_underlined() { print_in_color "\e[4;36m" "$*"; }

confirm() {
    local response=`gum input --prompt "${1} $(green "(yes|no)") " --placeholder ""`
    [[ "${response}" == "yes" ]] && return 0 || return 1
}

run_silent() {
  command ${@} &> /dev/null
}

pm_new_command() {
  local project="${args[name]}"

  if [[ -z "${project}" ]]; then
      local prompt='Project name: '
      project=`gum input --prompt "${prompt}"  --placeholder 'work/awesme-project'`
      echo "${prompt}$(cyan ${project})"
  fi

  local path="${PM_ROOT_DIR}/${project}"

  if [[ -d "${path}" ]]; then
      echo "$(red np:) project already exists"
      exit 1
  fi

  command mkdir -p "${path}"

  if confirm "Initialize git repository?"; then
      pushd "${path}" &> /dev/null
      command git init &> /dev/null

      echo "Initialize git repository: $(cyan yes)"
  else
      echo "Initialize git repository: $(cyan no)"
  fi

  local name=`basename "${path}" | sed 's/\./dot-/'`

  if [[ -z "${TMUX}" ]]; then
      # Outside tmux session
      tmux new-session -c "${path}" -s "${name}"
  else
      # Inside tmux session
      tmux new-session -c "${path}" -d -s "${name}"
      tmux switch-client -t "${name}"
  fi

}

pm_clone_command() {
  local url="${args[url]}"
  local destination="${args[destination]}"

  if [[ -z "${destination}" ]]; then
      local prompt='Project destination: '
      destination=`gum input --prompt "${prompt}" --placeholder 'work/awesome-project' --value "$(basename ${url})"`
      echo "${prompt}$(cyan ${destination})"
  fi

  if [[ -d "${PM_ROOT_DIR}/${destination}" ]]; then
      echo "$(red pm:) destination already contains this project"
      exit 1
  fi

  local project_name=`basename "${destination}"`

  local project_dir=`dirname "${destination}"`
  local destination_dir="${PM_ROOT_DIR}/${project_dir}"

  [[ ! -d "${project_dir}" ]] && command mkdir -p "${destination_dir}"
  pushd "${destination_dir}" &> /dev/null

  command git clone "${url}" "$project_name"
  echo "$(green ✔) Added project"

}

pm_switch_command() {
  local project="${args[name]}"

  if [[ -z "${project}" ]]; then
      pushd "${PM_ROOT_DIR}" &> /dev/null
      project=`fd --hidden --type d --max-depth ${PM_MAX_DEPTH} | gum filter --placeholder "Select a project"`
      popd &> /dev/null
  fi

  local path="${PM_ROOT_DIR}/${project}"
  local name=`basename "${path}" | sed 's/\./dot-/'`

  local session=`tmux list-windows -aF '#S: #{pane_current_path}' | \
      uniq | command rg "${name}: ${path::-1}"`

  if [[ -z "${TMUX}" ]]; then
      # Outside tmux session
      if [[ -z "${session}" ]]; then
          tmux new-session -c $path -s "${name}"
      else
          tmux attach -t "${name}"
      fi
  else
      # Inside tmux session
      if [[ -z "${session}" ]]; then
          tmux new-session -c $path -d -s "${name}"
          tmux switch-client -t "${name}"
      else
          tmux switch-client -t "${name}"
      fi
  fi

}

pm_link_command() {
  local path="${args[path]}"

  local source="${args[--source]}"
  local remove="${args[--remove]}"
  local copy="${args[--copy]}"

  if [[ -n "${remove}" ]]; then
      if [[ -f "${path}/pm" ]]; then
          run_silent rm -rf "${path}/pm"
          echo "$(green ✔) Link removed from $(magenta "${path}")"
      else
          echo "$(red pm:) no link found in $(magenta "${path}")"
          exit 1
      fi
  else
      if [[ -f "${path}/pm" ]]; then
          echo "$(red pm:) there is already a link in $(magenta "${path}")"
          exit 1
      fi

      if [[ ! -d "${source}" ]]; then
          echo "$(red pm:) source directory $(magenta "${source}") does not exist"
          exit 1
      fi

      source=`realpath "${source}"`

      if [[ ! -f "${source}/pm" ]]; then
          echo "$(red pm:) script 'pm' not found in $(magenta "${source}")"
          exit 1
      fi

      local executable=`test -n "${copy}" && echo "cp" || echo "ln -s"`

      run_silent ${executable} "${source}/pm" "${path}/pm"
      echo "$(green ✔) Link created in $(magenta "${path}")"
  fi

}

pm_root_command() {
  echo "${PM_ROOT_DIR}"

}

parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --version | -v)
        version_command
        exit
        ;;

      --help | -h)
        long_usage=yes
        pm_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  export PM_ROOT_DIR="${PM_ROOT_DIR:-${HOME}/dev}"
  export PM_MAX_DEPTH="${PM_MAX_DEPTH:-2}"

  if command -v git >/dev/null 2>&1; then
    deps['git']="$(command -v git | head -n1)"
  else
    printf "missing dependency: git\n" >&2
    exit 1
  fi

  if command -v tmux >/dev/null 2>&1; then
    deps['tmux']="$(command -v tmux | head -n1)"
  else
    printf "missing dependency: tmux\n" >&2
    exit 1
  fi

  if command -v fd >/dev/null 2>&1; then
    deps['fd']="$(command -v fd | head -n1)"
  else
    printf "missing dependency: fd\n" >&2
    exit 1
  fi

  if command -v gum >/dev/null 2>&1; then
    deps['gum']="$(command -v gum | head -n1)"
  else
    printf "missing dependency: gum\n" >&2
    exit 1
  fi

  action=${1:-}

  case $action in
    -*) ;;

    new)
      action="new"
      shift
      pm_new_parse_requirements "$@"
      shift $#
      ;;

    clone)
      action="clone"
      shift
      pm_clone_parse_requirements "$@"
      shift $#
      ;;

    switch)
      action="switch"
      shift
      pm_switch_parse_requirements "$@"
      shift $#
      ;;

    link)
      action="link"
      shift
      pm_link_parse_requirements "$@"
      shift $#
      ;;

    root)
      action="root"
      shift
      pm_root_parse_requirements "$@"
      shift $#
      ;;

    "")
      pm_usage >&2
      exit 1
      ;;

    *)
      printf "invalid command: %s\n" "$action" >&2
      exit 1
      ;;

  esac

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        printf "invalid argument: %s\n" "$key" >&2
        exit 1

        ;;

    esac
  done

}

pm_new_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_new_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="new"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      --no-git | -n)

        args['--no-git']=1
        shift
        ;;

      --detach | -d)

        args['--detach']=1
        shift
        ;;

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        if [[ -z ${args['name']+x} ]]; then

          args['name']=$1
          shift
        else
          printf "invalid argument: %s\n" "$key" >&2
          exit 1
        fi

        ;;

    esac
  done

}

pm_clone_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_clone_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="clone"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        if [[ -z ${args['url']+x} ]]; then

          args['url']=$1
          shift
        elif [[ -z ${args['destination']+x} ]]; then

          args['destination']=$1
          shift
        else
          printf "invalid argument: %s\n" "$key" >&2
          exit 1
        fi

        ;;

    esac
  done

  if [[ -z ${args['url']+x} ]]; then
    printf "missing required argument: URL\nusage: pm clone URL [DESTINATION]\n" >&2
    exit 1
  fi

}

pm_switch_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_switch_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="switch"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        if [[ -z ${args['name']+x} ]]; then

          args['name']=$1
          shift
        else
          printf "invalid argument: %s\n" "$key" >&2
          exit 1
        fi

        ;;

    esac
  done

}

pm_link_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_link_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="link"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      --remove | -r)

        args['--remove']=1
        shift
        ;;

      --source | -s)

        if [[ -n ${2+x} ]]; then

          args['--source']="$2"
          shift
          shift
        else
          printf "%s\n" "--source requires an argument: --source, -s SOURCE" >&2
          exit 1
        fi
        ;;

      --copy | -c)

        args['--copy']=1
        shift
        ;;

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        if [[ -z ${args['path']+x} ]]; then

          args['path']=$1
          shift
        else
          printf "invalid argument: %s\n" "$key" >&2
          exit 1
        fi

        ;;

    esac
  done

  [[ -n ${args['path']:-} ]] || args['path']="${HOME}/.local/bin"
  [[ -n ${args['--source']:-} ]] || args['--source']="${HOME}/.pm"

}

pm_root_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_root_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="root"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        printf "invalid argument: %s\n" "$key" >&2
        exit 1

        ;;

    esac
  done

}

initialize() {
  version="0.1.0"
  long_usage=''
  set -e

  export PM_ROOT_DIR="${PM_ROOT_DIR:-${HOME}/dev}"
  export PM_MAX_DEPTH="${PM_MAX_DEPTH:-2}"

}

run() {
  declare -A args=()
  declare -A deps=()
  declare -a other_args=()
  declare -a input=()
  normalize_input "$@"
  parse_requirements "${input[@]}"

  case "$action" in
    "new") pm_new_command ;;
    "clone") pm_clone_command ;;
    "switch") pm_switch_command ;;
    "link") pm_link_command ;;
    "root") pm_root_command ;;
  esac
}

initialize
run "$@"
