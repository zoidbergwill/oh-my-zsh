# pieces from kennethreithz's theme
# prompt_char code from suvash.zsh-theme
# The rest from suvash.zsh-theme who cites:
#  prompt style and colors based on Steve Losh's Prose theme:
#  # http://github.com/sjl/oh-my-zsh/blob/master/themes/prose.zsh-theme
#  #
#  # vcs_info modifications from Bart Trojanowski's zsh prompt:
#  # http://www.jukie.net/bart/blog/pimping-out-zsh-prompt
#  #
#  # git untracked files modification from Brian Carper:
#  # http://briancarper.net/blog/570/git-info-in-your-zsh-prompt

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo 'Hg' && return
    echo '○'
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('%F{blue}`basename $VIRTUAL_ENV`%f') '
}
PR_GIT_UPDATE=1

setopt prompt_subst

autoload -U add-zsh-hook
# autoload -Uz vcs_info

#use extended color pallete if available
if [[ $terminfo[colors] -ge 256 ]]; then
    turquoise="%F{81}"
    orange="%F{166}"
    purple="%F{135}"
    hotpink="%F{161}"
    limegreen="%F{118}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    hotpink="%F{red}"
    limegreen="%F{green}"
fi

# enable VCS systems you use
# zstyle ':vcs_info:*' enable git hg

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
# zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%f"
# FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
# FMT_ACTION="(%{$limegreen%}%a${PR_RST})"
# FMT_UNSTAGED="%{$orange%}●"
# FMT_STAGED="%{$limegreen%}●"

# zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
# zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
# zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
# zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
# zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

# function steeef_preexec {
#     case "$(history $HISTCMD)" in
#         *git*)
#             PR_GIT_UPDATE=1
#             ;;
#         *hg*)
#             PR_GIT_UPDATE=1
#             ;;
#         *svn*)
#             PR_GIT_UPDATE=1
#             ;;
#     esac
# }
# add-zsh-hook preexec steeef_preexec

# function steeef_chpwd {
#     PR_GIT_UPDATE=1
# }
# add-zsh-hook chpwd steeef_chpwd

# function steeef_precmd {
#     if [[ -n "$PR_GIT_UPDATE" ]] ; then
#         # check for untracked files or updated submodules, since vcs_info doesn't
#         if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
#             PR_GIT_UPDATE=1
#             FMT_BRANCH="(%{$turquoise%}%b%u%c%{$hotpink%}●${PR_RST})"
#         else
#             FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
#         fi
#         zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "
# 
#         vcs_info 'prompt'
#         PR_GIT_UPDATE=
#     fi
# }
# add-zsh-hook precmd steeef_precmd

# From oh-my-zsh's lib/git.zsh
# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function prompt_git_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo "(${ref#refs/heads/}) "
}

# turquoise="%F{81}"
# orange="%F{166}"
# purple="%F{135}"
# hotpink="%F{161}"
# limegreen="%F{118}"
PROMPT='%{$hotpink%}%C%{$reset_color%} \
%{$orange%}$(prompt_git_branch)%{$reset_color%}\
$(virtualenv_info)\
%{$turquoise%}$(prompt_char)%{$reset_color%} '
# PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='%{$purple%}%*%{$reset_color%}'

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$reset_color%}%{$fg[blue]%}"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="!%{$reset_color%} "

# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
# ZSH_THEME_GIT_PROMPT_CLEAN=""
