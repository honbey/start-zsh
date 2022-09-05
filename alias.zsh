
# Emacs
if type emacs > /dev/null 2>&1; then
    function start_emacs() { exec emacsclient -c -a "" "$@" }
    alias killemacs="emacsclient -e '(kill-emacs)'"
    alias emacs='start_emacs'
fi

# NeoVim
if   type nvim > /dev/null 2>&1; then
    alias v='nvim'
    alias vi='nvim'
elif type vim  > /dev/null 2>&1; then
    alias vi='vim'
fi

# Docker / Podman
if type podman > /dev/null 2>&1; then
    alias docker='podman'
fi

# Gnupg
if type gpg > /dev/null 2>&1; then
    export GPG_TTY=$(tty)
fi

# Nginx
if   [[ -f "/usr/local/nginx/sbin/nginx"    ]]; then
    alias ng='/usr/local/nginx/sbin/nginx'
elif [[ -f "/var/data/etc/nginx/sbin/nginx" ]]; then
    alias ng='/var/data/etc/nginx/sbin/nginx'
elif type nginx > /dev/null 2>&1; then
    alias ng='nginx'
fi

