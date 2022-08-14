# cloning to a local repo

CD to your home directory and issue `git clone https://github.com/umrosbrian/debian_home_dir`.  You'll need to then move all of the contents of the `debian_home_dir` directory into the home directory.  Do something like `mv debian_home_dir/.bashrc debian_home_dir/.functions debian_home_dir/.tmux.conf debian_home_dir/.vimrc debian_home_dir/.ideavimrc .`.
<!--You can do this by issuing the bash commands `find debian_home_dir -mindepth 1 -maxdepth 1 -exec mv '{}' . \; ; rmdir debian_home_dir`.-->

# working in a local repo

Every home directory that this repo will be cloned to is going to contain different items.  You probably don't want to see all of the contents when you issue something like `git status`.  Rather than adding all files and directories to the `.gitignore` file for all untracked files and directories of all the systems it's very helpful to have a `.git/info/exclude` file on each system that the repo is cloned to.  The bash command `cd ; find . -maxdepth 1 ! -name \.bashrc  ! -name \.vimrc ! -name \.tmux\.conf ! -name \.functions ! -name README\.md ! -name \.ideavimrc | sed '/^\.$/d;s/^\.\///' > .git/info/exclude` will populate the file with everything in the home directory apart from the files that are tracked in this repo.  After issuing the command you shouldn't see any `untracked` files when issuing `git status`.  If you happen to see an item pop up when issuing `git status` but don't want it tracked you can use `echo <item_you_don't_want_tracked >> .git/info/exclude` to add the item rather than reissuing the prior command.

You'll probably want to issue `. ~/.bashrc` after doing a pull since this will realize any changes made to `.bashrc` or `.functions` that came with the pull.
