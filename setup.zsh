#!/usr/bin/env zsh

function backup-dotfiles() {
    echo "Creating backup"
    if [ ! -e ~/.dotfiles-backup ]; then
        echo "Creating ~/.dotfiles-backup"
        mkdir ~/.dotfiles-backup
    fi
    echo "Backup dotfiles..."
    cp ~/.zshrc ~/.dotfiles-backup
    cp ~/.p10k.zsh ~/.dotfiles-backup
    echo
}

function update() {
    git submodule init && git submodule update
}

function install-ohmyzsh() {
    echo "Removing ~/.oh-my-zsh"
    rm -rf ~/.oh-my-zsh
    echo 
    echo "Installing oh-my-zsh"
    if [ -x "$(which wget)" ] ; then
        sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
    elif [ -x "$(which curl)" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
    elif [ -x "$(which fetch)" ]; then
        sh -c "$(fetch -o - https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
    else
        echo "Could not find curl, wget or fetch, please install one." >&2
    fi
    echo
}

function install-powerlevel10k() {
    echo "powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo
}

function copy-dotfiles() {
    echo "Copy..."
    /bin/cp .zshrc ~
    /bin/cp .p10k.zsh ~
    echo
}

function configure-zshrc() {
    echo "Configure .zshrc"
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
        echo "source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
        echo "source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        echo "source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
        echo "source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
    else
        echo "Unknown OS"
    fi
}

function this-is-the-end() {
    echo "Finished. Use 'source ~/.zshrc'"
}

main() {
    backup-dotfiles
    install-ohmyzsh
    install-powerlevel10k
    copy-dotfiles
    configure-zshrc
}

main "$@"