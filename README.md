# DevKit - GitROR
**Tool for automatic installation of:**
* **Git** with Git Kurwa! option (colorful Bash prompt with Git integration, new git aliases and some nice options already set)

**push.default** is set to **simple** (default in Git 2.0)

* Latest stable **Ruby** version via **rbenv**
* Latest stable **Ruby on Rails**
* **MySQL** client and dev files

You can check versions that are used in  [versions.sh](versions.sh) file.

## Requirements
* Debian/Ubuntu
* You should be able to use **sudo apt-get** command
* GNU Bash

## Installation

```bash
git clone https://github.com/felixdgniezno/linux-devkit-gitror.git
cd linux-devkit-gitror
./install.sh
```

In case of any displaying problems your can run installer with **txt** parameter:

```bash
./install txt
```
## Files that will be changed/created

* ~/.bashrc
* ~/.bash_aliases
* ~/.gitconfig - global Git configuration file (**git config --global**)

They will be backed up with **.old** extenstion.

## Stuff used to create this repo

[Git Kurwa!](https://github.com/jakubnabrdalik/gitkurwa) for initial nice Git aliases and BASH Git support
