# dotfiles

```
mkdir -p $HOME/dotfiles
git init --bare $HOME/dotfiles

echo "alias dot='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'" >> .zshrc
source .zshrc
dot config --local status.showUntrackedFiles no

dot add /path/to/file
dot commit -m "Your commit message"
dot push
```
