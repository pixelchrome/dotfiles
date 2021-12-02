#!/usr/bin/env sh

git submodule init && git submodule update
rsync -av .zshrc ~
rsync -av .p10k.zsh ~
rsync -av .oh-my-zsh ~
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k