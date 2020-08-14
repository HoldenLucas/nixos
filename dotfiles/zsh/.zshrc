#eval "$(fasd --init auto)"
export ZGEN_DIR="$HOME/.zgen"
export ZGEN_SOURCE="$ZGEN_DIR/zgen.zsh"

[ -d "$ZGEN_DIR" ] || git clone https://github.com/tarjoilija/zgen "$ZGEN_DIR"
source $ZGEN_SOURCE
if ! zgen saved; then
  echo "Initializing zgen"
  zgen load chrissicool/zsh-256color
  zgen load zsh-users/zsh-history-substring-search
  zgen load zsh-users/zsh-completions src
  zgen load junegunn/fzf shell

  zgen load mafredri/zsh-async
  zgen load sindresorhus/pure

  [ -z "$SSH_CONNECTION" ] && zgen load zdharma/fast-syntax-highlighting

  zgen save
fi

# must be loaded before other keybindings
bindkey -v #vim mode
bindkey "^?" backward-delete-char

alias ls="exa"

## Prompt
PURE_PROMPT_SYMBOL=❱
PURE_PROMPT_VICMD_SYMBOL=❰

# --POWER--
function pow {
  acpi | rg -o "[0-9]*%"
}
POWER='%F{blue}$(pow)% '

# --TIME--
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#SEC59
RPROMPT='%F{blue} %T'
TMOUT=10
TRAPALRM() {
    zle reset-prompt
}

# --background jobs
JOB_INDICATOR='%(1j.%F{red}❱.)% '

PROMPT=$POWER$JOB_INDICATOR$PROMPT
prompt_pure_set_title() {}

## History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
# ignore duplicated commands history list
setopt hist_ignore_dups
# ignore commands that start with space
setopt hist_ignore_space
# show !! to user before running it
setopt hist_verify

export FZF_DEFAULT_OPS="--color=light"
export FZF_DEFAULT_COMMAND='rg --files --hidden'

if [[ -n $SSH_CONNECTION ]] ; then
    export TERM=linux
fi

unsetopt beep
setopt extendedglob
setopt promptsubst

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -d "$BASE16_SHELL" ] || git clone https://github.com/chriskempson/base16-shell.git $BASE16_SHELL
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

lp () {
	lesspass $1 holdenlucas "mungus\creying" | wl-copy
}

# vim: set ts=2 sw=2 et;
