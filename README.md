This setup uses a _bare_ git repo titled `$HOME/.dotfiles`, which eliminates the issues involved with having a .git directory reside in your home directory.  The alias `dotfiles` is created, which replaces `git` in all cases where you'd normally use the later command.

I found this in a SO post but it's best descibed [here](https://www.atlassian.com/git/tutorials/dotfiles).

## setup

```
cd
git init --bare .dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME" # this should be added to .bashrc also but it's needed in the current shell scope
dotfiles config --local status.showUntrackedFiles no
dotfiles add .vimrc .tmux.conf .ideavimrc .functions .bashrc
dotfiles commit -m "first commit"
dotfiles remote add origin https://github.com/umrosbrian/dotfiles.git
dotfiles branch -M 'main'
dotfiles push -u origin 'main'
```

## cloning

```
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME" # this may already be in the .bashrc that's on Github but you need it in the current shell scope
git clone --bare https://github.com/umrosbrian/dotfiles.git  $HOME/.dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

## working in a local repo

Every home directory that this repo will be cloned to is going to contain different items.  You probably don't want to see all of the contents when you issue something like `dotfiles status`.  Rather than adding all files and directories to a `.gitignore` file it's very helpful to have a `.dotfiles/info/exclude` file on each system that the repo is cloned to.  The bash command `cd ; find . -maxdepth 1 ! -name \.bashrc  ! -name \.vimrc ! -name \.tmux\.conf ! -name \.functions ! -name README\.md ! -name \.ideavimrc | sed '/^\.$/d;s/^\.\///' > .dotfiles/info/exclude` will populate the file with everything in the home directory apart from the files that are tracked in this repo.  After issuing the command you shouldn't see any `untracked` files when issuing `dotfiles status`.  If you happen to see an item pop up but don't want it tracked you can use `echo <item_you_don't_want_tracked> >> .dotfiles/info/exclude` to add the item rather than reissuing the prior command.

