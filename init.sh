
if [[ ! -f "$HOME/.env" ]]; then
    touch "$HOME/.env"
fi

if [[ ! -d "$HOME/.bin" ]]; then
    mkdir "$HOME/.bin"
fi

if [[ ! -d "/opt/data/pyvenv" ]]; then
    sudo mkdir -p "/opt/data/pyvenv"
    sudo chown -R "$USER" "/opt/data"
fi

# Package management
if ! type app > /dev/null 2>&1; then
    if [[ "$OSTYPE" =~ "darwin*" && -f /opt/homebrew/bin/brew ]]; then
        # export HOMEBREW_BREW_GIT_REMOTE=""
        # export HOMEBREW_CORE_GIT_REMOTE=""
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        ln -s $(brew --prefix)/bin/brew $(brew --prefix)/bin/app
        brew install coreutils neovim bash curl bat fd ripgrep tree jq
    elif type yum > /dev/null 2>&1; then
        sudo ln -s $(which yum) ${$(which yum)%/*}/app
    elif type apt > /dev/null 2>&1; then
        sudo ln -s $(which apt) ${$(which apt)%/*}/app
    fi
fi
