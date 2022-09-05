export PATH="$HOME/.bin:$PATH"

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
    }' "$@"
}

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

