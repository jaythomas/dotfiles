# Colors
if [[ $(tty) = /dev/tty? ]] ; then
  # 16-Colors (for TTY Prompt)
  c0='echo' # reset colors
  c1=6 # root // cyan
  c2=3 # user // yellow
  c3=4 # host // dark blue
  c4=5 # path // magenta
  c5=6 # vcs  // cyan
  c6=1 # return code // red
else
  # 256-Colors
  c0='echo' # reset colors
  c1=043 # root // turqoise
  c2=172 # user // orange
  c3=027 # host // dark blue
  c4=133 # path // purple
  c5=006 # vcs  // teal
  c6=127 # return code // dark magenta
fi

# Prompt
autoload -Uz vcs_info # Load module to fetch version control info
precmd() { vcs_info } # Refresh the info every prompt
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
zstyle ':vcs_info:git:*' formats '%F{$c5%}%b' # Format the vcs_info_msg_0_ variable (%b=branch)
setopt PROMPT_SUBST # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html

prompt_user='%(!.%F{$c1}.%F{$c2})%n%f'
prompt_host='%F{$c3}%m%f:%F{$c4}'
PROMPT="${prompt_user}@${prompt_host}%~ %F{$c0%}"
RPROMPT='${vcs_info_msg_0_} %F{$c6}%?'

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
bindkey -v
stty -ctlecho

# Tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*:matches' group 'yes' # Group directories and files together
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case-insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Colorize suggestions and highlight active match

# Options
setopt SH_WORD_SPLIT # This option has nothing to do with word splitting
setopt alwaystoend # When complete from middle, move cursor
setopt auto_list # Automatically list choices on an ambiguous completion
setopt autocd # Enter directory without need for 'cd'
setopt automenu # Use menu completion after the second consecutive request
setopt autopushd # Automatically append dirs to the push/pop list
setopt banghist # csh-style textual history expansion using '!'
unsetopt beep # Just in case
unsetopt bg_nice # Otherwise backgrounded jobs are niced
setopt cdablevars # Avoid the need for an explicit $
setopt completealiases # For autocompletion of command line switches for aliases
setopt completeinword # And not just at the end
setopt extendedglob # Weird & wacky pattern matching - yay zsh!
setopt globdots # bash compatibility
setopt hist_ignore_all_dups # Don't record duplicate commands
setopt hist_ignore_space # Ignore commands by preceding them with whitespace
setopt hist_reduce_blanks
setopt histverify # When using ! cmds, confirm first
setopt inc_append_history # Appends new line incrementally instead of on exit
setopt interactivecomments # Allow comments in interactive shell
setopt interactivecomments # Escape commands so I can use them later
setopt noclobber
setopt nohup # Report status of background jobs before exiting a shell with job control
setopt nohup # and don't kill them, either
setopt nolisttypes # Show types in completion
setopt nopromptcr # Don't add \n which overwrites cmds with no \n
setopt pushdignoredups # and don't duplicate them
setopt pushdminus
setopt pushdsilent # Do not print the directory stack after pushd or popd
setopt share_history

#
# Key bindings
#

bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string.
                                                      # The string may begin with ^ to anchor the search to the beginning of the line.
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
fi
#bindkey '\e[OH' beginning-of-line
#bindkey '\e[OF' end-of-line

bindkey '^[[A' up-line-or-search                      # start typing + [Up-Arrow]/[Down-Arrow] -
bindkey '^[[B' down-line-or-search                    # partial match against command history with arrows keys

bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi


# GPG
export GPG_TTY=$(tty)

# Grep highlight color (why is this an environment variable instead of an argument?)
export GREP_COLOR='1;36'

# Text editor
EDITOR=nvim
export EDITOR

# Aliases
source ~/.bash_aliases

# Plugins... maybe
#source <(antibody init)
#antibody bundle < ~/.zsh_plugins

# Elixir/Erlang
#. $HOME/.asdf/asdf.sh

# Node/Yarn
eval "$(fnm env --use-on-cd)"
#export PATH=$HOME/.fnm:$PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Ruby
#source /usr/share/chruby/chruby.sh
#source /usr/share/chruby/auto.sh

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep.conf"
