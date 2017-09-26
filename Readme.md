# Martins Emacs-Config

## Features

*  automatically installs required packages
*  supports two themes (night and day) `C-=`
*  uses projectile to detect projects
*  automatically provides python completion and code navigation within projects

## Installation

Install emacs and then get the config:
``` shell
git clone https://github.com/dfrkp/emacs.d.git ~/.emacs.d
```
Run Emacs and wait for all the packages to be installed, then within emacs run:
``` elisp
jedi:install-server
```

## External dependencies

### React / Javascript

Install ESLint for react:
```
npm install -g eslint babel-eslint eslint-plugin-react
```
and create a ~/.eslintrc like
```
{
  "parser": "babel-eslint",
  "plugins": [ "react" ],
  "env": {
    "browser": true,
    "es6": true,
    "node": true
  },
  "rules": {
    "consistent-return": [0],
    "key-spacing": [0],
    "quotes": [0],
    "new-cap": [0],
    "no-multi-spaces": [0],
    "no-shadow": [0],
    "no-unused-vars": [1],
    "no-use-before-define": [2, "nofunc"],
    "react/jsx-no-undef": 1,
    "react/jsx-uses-react": 1,
    "react/jsx-uses-vars": 1
  }
}
```
