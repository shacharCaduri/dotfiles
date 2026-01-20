# Powerlevel10k Configuration
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Prompt Customization
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}

# Prompt Elements Configuration
() {
  emulate -L zsh -o extended_glob

  # Prompt Segments
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon          # OS identifier
    dir              # Current directory
    vcs              # Git status
    newline          # New line before prompt
    prompt_char      # Prompt symbol
  )

  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status           # Exit code of last command
    command_execution_time  # Duration of last command
    background_jobs  # Background jobs count
    pyenv            # Python version
    rust_version     # Rust version
    time             # Current time
  )

  # Directory Styling
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=004
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=004
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=004

  # Git Status Colors
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=2
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=2
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=3

  # Custom Icons
  typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='${P9K_CONTENT}⚡'

  # Prompt Character
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=2
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=1

  # Performance Optimization
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off

  # Disable Right Frame
  typeset -g POWERLEVEL9K_RIGHT_FRAME_ENABLED=false
}

# Runtime Configuration
(( ${+functions[p10k-on-pre-prompt]} )) || function p10k-on-pre-prompt() {
  p10k display '*/exec_time=show'
}

(( ${+functions[p10k-on-post-prompt]} )) || function p10k-on-post-prompt() {
  p10k display '*/exec_time=hide'
}
