#!/usr/bin/env zsh



function backup-dotfiles() {
    echo "Creating backup"
    if [ ! -e ~/.dotfiles-backup ]; then
        echo "Creating ~/.dotfiles-backup"
        mkdir ~/.dotfiles-backup
    fi
    echo -e "\nBackup dotfiles..."
    cp ~/.zshrc ~/.dotfiles-backup
    cp ~/.p10k.zsh ~/.dotfiles-backup
    cp ~/.vimrc ~/.dotfiles-backup
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
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew update
        brew install zsh-syntax-highlighting zsh-autosuggestions neofetch
    elif [[ -f /etc/lsb-release ]]; then
        sudo apt-get update
        sudo apt install git zsh zsh-autosuggestions zsh-syntax-highlighting curl apt-transport-https ca-certificates gnupg lsb-release neofetch
    elif [[ -f /etc/redhat-release ]]; then
        sudo yum update
        echo "Please install zsh features manually"
    else
        echo "Please install zsh features manually"
    fi
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

function install-powerlevel10k() {
    echo -e "\nInstalling powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo
}

function copy-dotfiles() {
    echo "Copy..."
    /bin/cp .zshrc ~
    /bin/cp .p10k.zsh ~
    /bin/cp .vimrc ~
    echo
}

function configure-zshrc() {
    echo -e "\nConfiguring .zshrc"
    echo "- adding zsh-syntax-highlighting"
    echo "- adding zsh-autosuggestions"
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
        echo "source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
            echo "source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
            echo "source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
        elif [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
            echo "source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
            echo "source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
        else
            echo "WARNING macOS: zsh-syntax-highlighting & zsh-autosuggestions & neofetch not found!"
        fi
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        echo "source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
        echo "source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
    else
        echo "!!! Unknown OS !!!"
    fi
    echo "- adding neofetch"
    if [ -x "$(which neofetch)" ] ; then
        echo `which neofetch` >> ~/.zshrc
    else
        echo "!!! Could not find neofetch. !!!" >&2
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
    install-zsh-features
    change-shell
    install-ohmyzsh
    install-powerlevel10k
    copy-dotfiles
    configure-zshrc
    this-is-the-end
}

main "$@"