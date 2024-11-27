# Here are my dotfiles

My dotfiles and the setup and tools I use

## Installation useful tools

### Ubuntu

```sh
sudo apt install git zsh zsh-autosuggestions zsh-syntax-highlighting curl apt-transport-https ca-certificates gnupg lsb-release tmux
```

#### Install tmux-xpanes

```sh
sudo apt install software-properties-common
sudo add-apt-repository ppa:greymd/tmux-xpanes
sudo apt update
sudo apt install tmux-xpanes
```

### macOS

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```sh
brew install tmux tmux-xpanes zsh-autosuggestions zsh-syntax-highlighting
```

## Installation dotfiles

ATTENTION! `setup.sh` deletes files and directories (`.oh-my-zsh`) and overwrites configfiles (`.zshrc`, `.p10k.zsh`)

### macOS homebrew

* brew will be installed if not found

### zsh features

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

## More setup stuff

### SUDO

If `sudo` should not ask for a password

```sh
echo "harry ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/harry
```

### FreeBSD - `doas`

Permit members of the wheel group to perform actions as root and user harry should not be asked for a password.

Add below lines to `/usr/local/etc/doas.conf`

```sh
permit keepenv :wheel
permit keepenv nopass harry
```

### Fonts for the terminal and more

Get the JetBrains Mono here <https://www.jetbrains.com/lp/mono/> and install it

#### macOS Terminal

In the directory `other` you can find `luci.terminal`. Just doubleclick to install it. This is inspired by NetApp colortheme **luci** <http://luci.netapp.com/visual-language/color.html>

#### VS Code

Open the *User Settings (JSON)* with CMD + SHIFT + p

and add:

```json
    "editor.fontFamily": "JetBrains Mono",
    "editor.fontLigatures": true,
```

### Docker

Install Docker

```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

Manage Docker as a non-root user

```sh
sudo usermod -aG docker $USER
```
