# Martins Emacs-Config

## Features

*  automatically installs required packages
*  supports two themes (night and day) `C-=`
*  uses projectile to detect projects
*  automatically provides python completion and code navigation within projects
*  for git repo control use magit `C-x g`
*  for file browsing use sunrise command `C-x s`

## Installation

Install emacs and then get the config:
``` shell
git clone https://github.com/dfrkp/emacs.d.git ~/.emacs.d
```
Run Emacs and wait for all the packages to be installed, then within emacs run:
Python completion backend:
``` elisp
jedi:install-server
```
C/C++ completion backend:
``` elisp
irony-install-server
```

## External dependencies

### React / Javascript

Flycheck will find ESlint either globally or (preferred) locally in
node_modules.
