#!/usr/bin/env zsh

function backup-dotfiles() {
    echo "Creating backup"
    if [ ! -e ~/.dotfiles-backup ]; then
        echo "Creating ~/.dotfiles-backup"
        mkdir ~/.dotfiles-backup
        mkdir ~/.dotfiles-backup/config
    fi
    if [ ! -e ~/.dotfiles-backup/config ]; then
        echo "Creating ~/.dotfiles-backup/config"
        mkdir ~/.dotfiles-backup/config
    fi
    echo -e "\nBackup dotfiles..."
    cp ~/.zshrc ~/.dotfiles-backup
    cp ~/.p10k.zsh ~/.dotfiles-backup
    cp ~/.vimrc ~/.dotfiles-backup
    cp ~/.zprofile ~/.dotfiles-backup
    cp -Rf ~/.config/* ~/.dotfiles-backup/config*
    echo
}

function install-brew() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if [ ! -x "$(which brew)" ] ; then
            echo -e "\nInstalling brew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
    fi
}

function install-zsh-features() {
    echo -e "\nInstalling zsh features..."
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ~/.oh-my-zsh/custom/plugins/zsh-autocomplete
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
}

function install-ohmyzsh() {
    echo -e "\nRemoving ~/.oh-my-zsh"
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

function install-other() {
    echo -e "\nInstalling other..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew update
        brew install wakeonlan neofetch
    elif [[ -f /etc/lsb-release || -f /etc/debian_version ]]; then
        echo "Ubuntu or Debian"
        sudo apt-get update
        sudo apt -y install git curl apt-transport-https ca-certificates gnupg lsb-release neofetch vim
    elif [[ -f /etc/os-release ]]; then
        doas pkg update
        doas pkg install -y doas git gnupg neofetch vim
    elif [[ -f /etc/redhat-release ]]; then
        sudo yum update
        echo "Please install zsh features manually"
    else
        echo "Please install zsh features manually"
    fi
}

function install-powerlevel10k() {
    echo -e "\nInstalling powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo
}

function copy-dotfiles() {
    echo "Create .config"
    if [ ! -e ~/.config ]; then
        echo "Creating ~/.config"
        mkdir ~/.config
    fi
    echo "Copy..."
    /bin/cp .zshrc ~
    /bin/cp .p10k.zsh ~
    /bin/cp .vimrc ~
    /bin/cp config/* ~/.config
    echo
}

function configure-zshrc() {
    echo -e "\nConfiguring .zshrc"
    echo "- adding neofetch"
    if [ -x "$(which neofetch)" ] ; then
        echo `which neofetch` >> ~/.zshrc
    else
        echo "!!! Could not find neofetch. !!!" >&2
    fi
}

function configure-zprofile() {
    echo -e "\nConfiguring .zprofile"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "eval $(/opt/homebrew/bin/brew shellenv)" >> ~/.zprofile
        echo 'export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"' >> ~/.zprofile
    else
        echo "Please configure your .zprofile"
    fi
}

function change-shell() {
    if [[ "$SHELL" != *"zsh" ]]; then
        echo -e "\n$SHELL in use... Select *zsh* from available shells..."
        cat /etc/shells
        chsh
        echo "ATTENTION! logout/login and re-run this script"
        exit 0
    fi
}

function this-is-the-end() {
    echo -e "\nFinished. Use 'source ~/.zshrc'"
    echo "Consider to add yourself to sudoers"
    echo "e.g.: echo \"harry ALL=(ALL) NOPASSWD:ALL\" > /etc/sudoers.d/harry"
    source ~/.zshrc
}

main() {
    backup-dotfiles
    install-brew
    install-other
    change-shell
    install-ohmyzsh
    install-zsh-features
    install-powerlevel10k
    copy-dotfiles
    configure-zshrc
    configure-zprofile
    this-is-the-end
}

main "$@"
