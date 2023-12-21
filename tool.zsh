[[ -f "$HOME/.env" ]] && source "$HOME/.env"

[[ -f "$HOME/.bin" ]] && export PATH="$HOME/.bin:$PATH"

# GNUPG
if type gpg > /dev/null 2>&1; then
    export GPG_TTY=$(tty)
fi

# Python venv
function ap() {
  source /opt/data/pyvenv/${1}/bin/activate; 
}

# base64 encode/decode
function be() { base64          <(echo "$1")
}
function bd() { base64 --decode <(echo "$1")}

# URL encode/decode
# https://unix.stackexchange.com/a/678894
function ue() {
  LC_ALL=C awk -- '
    BEGIN {
      for (i = 1; i <= 255; i++) hex[sprintf("%c", i)] = sprintf("%%%02X", i)
    }
    function urlencode(s, c, i, r, l) {
      l = length(s)
      for (i = 1; i <= l; i++) {
        c = substr(s, i, 1)
        r = r "" (c ~ /^[-._~0-9a-zA-Z]$/ ? c : hex[c])
      }
      return r
    }
    BEGIN {
      for (i = 1; i < ARGC; i++)
        print urlencode(ARGV[i])
    }' "$@" }

function ud() { echo -e "${1//\%/\\x}" }

# Timestamp to datetime or inversely
function ts() {
    if [[ "${1}" =~ ^[0-9]{10}$ ]]; then
        date -d "@${1}" '+%Y-%m-%d %H:%M:%S'
    elif [[ "${1}" =~ ^[0-9]{13}$ ]]; then
        date -d "@${1:0:10}" "+%Y-%m-%d %H:%M:%S%.${1:10:13}"
    else
        date -d "${1}" "+%s"
    fi
}

function brew-completions() {
    for i in $(ls $(brew --prefix)/opt/*/share/zsh/site-functions/* \
                  $(brew --prefix)/share/zsh/site-functions/*
        ); do
        if [[ ! -f "$HOME/.zi/completions/${i##/*/}_" ]]; then
            ln -s "${i}" "$HOME/.zi/completions/${i##/*/}_"
        fi
    done
}

# fzf
if [[ -f ~/.fzf.zsh ]]; then
    export FZF_CTRL_T_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude .cache'
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow'
    source ~/.fzf.zsh
fi

# Tmux
function sendkeys() {
    tmux send-keys -t "$1" "$2" Enter
    tmux capture-pane -p -t "$1"
}

# NVIDIA
if [[ -d "/usr/local/cuda" ]]; then
    export PATH=$PATH:/usr/local/cuda/bin
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64/
    export CUDA_HOME=/usr/local/cuda
fi

#####################################
# Some aliases

# Docker / Podman
if type podman > /dev/null 2>&1; then
    alias docker='podman'
fi

# Nginx
if   [[ -f "/usr/local/nginx/sbin/nginx"    ]]; then
    alias ng='/usr/local/nginx/sbin/nginx'
elif [[ -f "/opt/data/etc/nginx/sbin/nginx" ]]; then
    alias ng='/opt/data/etc/nginx/sbin/nginx'
elif type nginx > /dev/null 2>&1; then
    alias ng='nginx'
fi

# Golang
export GOPATH="/opt/data/go"
export PATH="$PATH:$GOPATH/bin"

# NodeJS - pnpm
if type pnpm > /dev/null 2>&1; then
    export PNPM_HOME="/opt/data/pnpm"
    export PATH="$PATH:$PNPM_HOME"
    alias npm='pnpm'
fi

# Emacs
if type emacs > /dev/null 2>&1; then
    function start_emacs() { exec emacsclient -c -a "" "$@" }
    alias killemacs="emacsclient -e '(kill-emacs)'"
    alias emacs='start_emacs'
fi

# Vim/NeoVim
if   type nvim > /dev/null; then
    alias vi='nvim'
    alias vim='nvim'
elif type vim  > /dev/null; then
    alias vi='vim'
fi

# Zoxide
if type zoxide > /dev/null; then
    eval "$(zoxide init zsh)"
    # Because i use `Zi`
    \builtin unalias zi
    \builtin alias zd=__zoxide_zi
fi
