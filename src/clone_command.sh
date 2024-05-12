local repository="${args[repository]}"

local name="${args[--name]}"
local space="${args[--space]}"

[[ -z "${name}" ]] && name="$(basename "${repository}")"

if [[ -d "${PM_HOME}/${destination}/${name}" ]]; then
    error "space '${space}' already contains this project"
    exit 1
fi

local destination="${PM_HOME}/${space}/${name}"

command git clone "git@github.com:${repository}.git" "$destination"
sucess "cloned project in space '${space}' as '${name}'"
