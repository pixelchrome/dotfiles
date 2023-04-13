# Changelog

## 20230413

`setup.zsh`

* Debian added to `function install-zsh-features()`

`README.md`

* Info about **Docker** added

## 20230215

`setup.zsh`

added

* neofetch added to `function configure-zshrc()`

`.zshrc`

* .zshrc typo fixed
* `ENABLE_CORRECTION="true"`
* `POWERLEVEL9K_INSTANT_PROMPT=quiet`

`README.md`

* Info about **JetBrains Mono** font added

`.vimrc`

My first version of `vimrc` most infos are from here -> https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/

other

* macOS Terminal Profile **luci** added


## 20211229

`setup.zsh`

added

* `function change-shell()` checks if loginshell is `zsh` otherwise starts `chsh`

updated

* `function install-zsh-features()` installs zsh feature and useful tools

removed

* `function install-brew()`

## 20211221

`setup.zsh` 

updated

* `function install-brew()` install brew only on macOS

## 20211219

`setup.zsh` 

fuctions added

* `CHANGELOG.md`
* `function install-brew()`
* `function install-zsh-features()`

updated

* `function configure-zshrc()`
* `.gitignore`
* `.zshrc`
* `README.md`
