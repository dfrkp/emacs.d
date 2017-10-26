;;; init.el --- ensure basic emacs features are available and set base parameter
;;; Commentary:

;;; Code:

					; (package-initialize)
(require 'package)
;; Read init file before loading packages
(setq package-enable-at-startup nil)

(defvar dropbox-directory "~/Dropbox/")


;; Host dependent stuff

;; Windows
(if (string-equal system-type "windows-nt")
    (progn
      ;; Prevent issues with the Windows null device (NUL)
      ;; when using cygwin find with rgrep.
      (defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
	"Use cygwin's /dev/null as the null-device."
	(let ((null-device "/dev/null"))
	  ad-do-it))
      (ad-activate 'grep-compute-defaults)
      ;; setup cygwin environment
      (setenv "PATH" (concat "c:/cygwin/bin;" (getenv "PATH")))
      (setq exec-path (cons "c:/cygwin/bin" exec-path))
      (setq w32-get-true-file-attributes nil)
      (when (boundp 'w32-pipe-read-delay)
	(setq w32-pipe-read-delay 0))
      ;; Set the buffer size to 64K on Windows (from the original 4K)
      (when (boundp 'w32-pipe-buffer-size)
	(setq irony-server-w32-pipe-buffer-size (* 64 1024)))
      )
  (progn
    (setq select-enable-clipboard t)
    (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
    )
  )

;; Basics
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)
(setq visible-bell 1)
(setq make-backup-files t)
;; Save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; start emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Package Manager
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("sunrise" . "http://joseito.republika.pl/sunrise-commander/"))

(defconst my-init-dir "~/.emacs.d/init.d")

(eval-when-compile (package-initialize))

;; copied from https://github.com/edvorg/emacs-configs/blob/master/init-real.el
(defun require-package (package)
  "Refresh package archives, check PACKAGE presence and install if it's not \
installed."
  (if (null (require package nil t))
      (progn (let* ((ARCHIVES (if (null package-archive-contents)
                                  (progn (package-refresh-contents)
                                         package-archive-contents)
                                package-archive-contents))
                    (AVAIL (assoc package ARCHIVES)))
               (if AVAIL
                   (package-install package)))
             (require package))))


;; use package
(require-package 'use-package)
(require 'use-package)

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require-package 'el-get)
(require 'el-get)
(use-package el-get
  :config
  (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/el-get/recipes")
  (el-get 'sync))

;; req-package
(require-package 'req-package)
(require 'req-package)
(req-package--log-set-level 'trace)

;; init.d
(dolist (i-file '(
		  "i-ccode.el"
		  "i-completion.el"
		  "i-dirnav.el"
		  "i-editing.el"
		  "i-erc.el"
		  "i-fix-mark-command.el"
		  "i-flycheck.el"
		  "i-ido-smex.el"
		  "i-insert-file-name-in-buffer.el"
		  "i-look-and-feel.el"
		  "i-lua.el"
		  "i-markdown.el"
		  "i-org.el"
		  "i-osx.el"
		  "i-projects.el"
		  "i-python.el"
		  "i-term.el"
		  "i-tex.el"
		  "i-typescript.el"
		  "i-vcs.el"
		  "i-web.el")
		)
  (message "Loading %s ..." i-file)
  (load-file
   (concat
    my-init-dir
    "/"
    i-file)))
(req-package-finish)
;;; * Global Key bindings
(global-set-key [f3] 'flyspell-mode)
(global-set-key [f8] 'comment-region)


(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (js2-mode json-mode web-mode irony-eldoc flycheck-irony company-irony zenburn-theme tide sunrise-commander smex smart-mode-line sane-term req-package rainbow-delimiters python projectile org-bullets org markdown-mode magit lua-mode load-dir iedit idomenu highlight-parentheses flx-ido fill-column-indicator erc-hl-nicks dired+ company-jedi company-flx column-enforce-mode autopair)))
 '(safe-local-variable-values (quote ((TeX-PDF-mode . t) (TeX-master . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
