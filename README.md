# dotfiles
version controlling some tried and true configurations for me


## on the linux
To save myself the most time, I should remember to clone this repo with: `git clone --recurse-submodules` instead.

When cloning the project from scratch, [read this](https://git-scm.com/book/en/v2/Git-Tools-Submodules) and the section on `Cloning a Project with Submodules` to appropriately pull in the submodules' files:
1. `git submodule init`
1. `git submodule update`

Alternatively, `git submodule update --init` for a combined command.

After that has happened, then you can `cp -r vim/.vim ~/` and copy the `.vimrc` over as well.
