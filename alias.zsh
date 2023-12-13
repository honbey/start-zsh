
# Emacs
if type emacs > /dev/null 2>&1; then
    function start_emacs() { exec emacsclient -c -a "" "$@" }
    alias killemacs="emacsclient -e '(kill-emacs)'"
    alias emacs='start_emacs'
fi

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

# Vim/NeoVim
if type nvim > /dev/null; then
    alias vi='nvim'
    alias vim='nvim'
else
    alias vi='vim'
fi

