# Initial Setup

- Install [OhMyZsh](https://ohmyz.sh).
  - Install plugins:
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
```
- Install [Homebrew](https://brew.sh).
- Using Homebrew, install the GitHub CLI:
```sh
brew install gh
```
- Login to your GitHub account.
  - Select SSH and the CLI will add a new SSH key to your GitHub account.
```sh
gh auth login
```
- Clone the repository as a bare repository and checkout the files.
```sh
git clone --bare git@github.com:connorwyatt/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
```
