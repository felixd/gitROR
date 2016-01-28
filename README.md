# DevKit - GitROR
**Tool for automatic installation of:**
* Git fancy improvements - colors and aliases + some setting

**push.default** is set to **simple** (default in Git 2.0)

* Latest stable Ruby version (2.2.4) via rbenv

## TODO
Automatization of:
* Git installation
* Ruby on Rails installation

## Requirements
What's required:
* GNU Linux - I've tested it on Debian/Ubuntu
* Already installed Git - https://git-scm.com/
* GNU Bash

## Installation

```bash
$ git clone https://github.com/felixdgniezno/linux-devkit-gitror.git
$ cd linux-devkit-gitror
$ ./install.sh
```

In case of any displaying problems your can run installer with **txt** parameter:

```
$ ./install txt
```
## Files that will be changed/created

* ~/.bashrc
* ~/.bash_aliases
* ~/.gitconfig - global Git configuration file (**git config --global**)

They will be backed up with **.old** extenstion.

## Stuff used to create this repo

[Git Kurwa!](https://github.com/jakubnabrdalik/gitkurwa) for initial nice Git aliases and BASH Git support
