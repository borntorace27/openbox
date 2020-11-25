##########################################################
#    _________  _   _    ____ ___  _   _ _____ ___ ____  #
#   |__  / ___|| | | |  / ___/ _ \| \ | |  ___|_ _/ ___| #
#     / /\___ \| |_| | | |  | | | |  \| | |_   | | |  _  #
#  _ / /_ ___) |  _  | | |__| |_| | |\  |  _|  | | |_| | #
# (_)____|____/|_| |_|  \____\___/|_| \_|_|   |___\____| #
#                                                        #
##########################################################

export TERMCMD=urxvtc
export LANG=en_US.UTF-8
export SUDO_EDITOR=nano
export EDITOR=nano
export VISUAL=nano
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PAGER="most"
export PATH="/home/josh/.cargo/bin:$PATH"
export PATH="/home/josh/.local/bin:$PATH"
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export PATH=$HOME/bin:/usr/local/bin:$PATH
source ~/.zsh_git.sh
source ~/Git\ Repos/zsh-git-prompt/zshrc.sh
source ~/.zsh_aliases
#================================================================================
# DO NOT EDIT AFTER THIS LINE
# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'Introduce %d'
zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' condition 0
zstyle ':completion:*' expand prefix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SHit TAB for more results...%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=0
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt 'Found %e errors...'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose true

##zstyle ':vcs_info:git*' formats "%{$fg[green]%}%s %{$reset_color%}%r/%S%{$fg[blue]%} %{$fg[cyan]%}on branch %b%{$reset_color%}%m%u%c%{$reset_color%} "
##zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:git:*' formats 'on branch %b'

zstyle :compinstall filename '/home/josh/.zshrc'

autoload -Uz vcs_info compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# DO NOT EDIT BEFORE THIS LINE
#================================================================================
# Own configuration:
setopt nohashdirs
setopt completealiases
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt PROMPT_SUBST

function ranger-cd {
    tempfile='/tmp/chosendir'
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history
[[ -n "${key[Up]}"   ]]  && bindkey  "${key[Up]}"    history-beginning-search-backward
[[ -n "${key[Down]}" ]]  && bindkey  "${key[Down]}"  history-beginning-search-forward

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

autoload -U colors && colors

# Prompt 1

#PROMPT='
#%F{cyan}%~%f
#%B%F{blue}❯%F{green}❯%F{red}❯ %b%f'
#RPROMPT='${vcs_info_msg_0_}%# '

# Prompt 2

return_status="%{$fg[red]%}%(?..⏎)%{$reset_color%} "
#EXITCODE="$?"

host_color="yellow"
if [ -n "$SSH_CLIENT" ]; then
  host_color="red"
fi

#function check_last_exit_code() {
#  local LAST_EXIT_CODE=$?...
#  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
#    local EXIT_CODE_PROMPT=' '
#    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
#    EXIT_CODE_PROMPT+="%{$fg[red]%}$LAST_EXIT_CODE%{$reset_color%}"
#    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
#    echo "EXIT_CODE_PROMPT"
#  fi
#}

PROMPT='
%{$fg[red]%}[%{$reset_color%}%{$fg[${host_color}]%}%n%{$reset_color%}%{$fg[white]%}@%{$reset_color%}%{$fg[blue]%}%m%{$reset_color%}%{$fg[red]%}]%{$reset_color%} %{$fg[cyan]%}%10c%{$reset_color%}
%{$fg[green]%}➜ %{$reset_color%}'

#if [ $return_status 0 ]; then
#  PS1+="%{fg[green]%}➜ %{$reset_color%}";
#else
#  PS1+="%{fg[red]%}➜ %{$reset_color%}";
#fi

RPROMPT='$(git_super_status) ${return_status}'
#'${return_status}${vcs_info_msg_0_}'

autoload -U compinit && compinit -u
