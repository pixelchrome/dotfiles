# Here are my dotfiles

My dotfiles and the setup and tools I use

# Installation useful tools

## Ubuntu

```sh
sudo apt install git zsh zsh-autosuggestions zsh-syntax-highlighting curl apt-transport-https ca-certificates gnupg lsb-release tmux
```

### Install tmux-xpanes

```sh
sudo apt install software-properties-common
sudo add-apt-repository ppa:greymd/tmux-xpanes
sudo apt update
sudo apt install tmux-xpanes
```

## macOS

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```sh
brew install tmux tmux-xpanes zsh-autosuggestions zsh-syntax-highlighting
```

# Installation dotfiles

ATTENTION! `setup.sh` deletes files and directories (`.oh-my-zsh`) and overwrites configfiles (`.zshrc`, `.p10k.zsh`)

## macOS

* brew will be installed if not found

## zsh features

This zsh features will be installed

* zsh-syntax-highlighting
* zsh-autosuggestions

```sh
git clone https://github.com/pixelchrome/dotfile.git
cd dotfiles
zsh setup.zsh
cd ~
source .zshrc
```

# More setup stuff

```sh
echo "harry ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/harry
```