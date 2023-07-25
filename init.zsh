# Try to find brew binary
if (( ${+commands[brew]} )); then
  local _homebrew_binary="${commands[brew]}"
else
  local _homebrew_paths=("/opt/homebrew" "/usr/local" "/home/linuxbrew/.linuxbrew")
  for _homebrew_path in $_homebrew_paths
  do
    if [[ -x "${_homebrew_path}/bin/brew" ]] then
      local _homebrew_binary="${_homebrew_path}/bin/brew"
      break
    fi
  done
fi

# Ensure brew is available
if (( ! ${+_homebrew_path} )); then
  return 1
fi


if (( ! ${+ZIM_HOMEBREW_ALIASES} )) typeset -g ZIM_HOMEBREW_ALIASES=true

fpath=(/opt/homebrew/share/zsh/site-functions(N) /home/linuxbrew/.linuxbrew/share/zsh/site-functions(N) ${fpath})

local _plugin_dir="${0:A:h}"

${_homebrew_binary} shellenv >| ${_plugin_dir}/_brew.zsh
source ${_plugin_dir}/_brew.zsh

#
# Aliases
#

if [[ ${ZIM_HOMEBREW_ALIASES} = true ]]; then
  # Homebrew
  alias brewa='brew autoremove'
  alias brewc='brew cleanup'
  alias brewC='brew cleanup -s'
  alias brewd='brew doctor --verbose'
  alias brewe='brew edit --formula'
  alias brewi='brew info --formula'
  alias brewI='brew install --formula'
  alias brewl='brew list --formula'
  alias brewL='brew leaves'
  alias brewo='brew outdated --formula'
  alias brewr='brew reinstall --formula'
  alias brews='brew search --formula'
  alias brewS='brew services'
  alias brewu='brew update'
  alias brewU='brew upgrade --formula --ignore-pinned'
  alias brewx='brew uninstall --formula'
  alias brewX='brew uninstall --formula --force'

  # Homebrew Cask
  alias caske='brew edit --cask'
  alias caski='brew info --cask'
  alias caskI='brew install --cask'
  alias caskl='brew list --cask'
  alias casko='brew outdated --cask'
  alias caskr='brew reinstall --cask'
  alias casks='brew search --cask'
  alias caskU='brew upgrade --cask'
  alias caskx='brew uninstall --cask'
  alias caskX='brew uninstall --cask --force'
  alias caskz='brew uninstall --cask --zap'
fi

unset _homebrew_paths _homebrew_path _plugin_dir
