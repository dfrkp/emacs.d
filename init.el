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
      )
  (progn
    (setq select-enable-clipboard t)
    (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
    )
  )

;; Mac
(if (string-equal system-type "darwin")
    (progn
      (setq ns-command-modifier 'meta)
      (defun copy-from-osx ()
	(shell-command-to-string "pbpaste"))

      (defun paste-to-osx (text &optional push)
	(let ((process-connection-type nil))
	  (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
	    (process-send-string proc text)
	    (process-send-eof proc))))
      (setq interprogram-cut-function 'paste-to-osx)
      (setq interprogram-paste-function 'copy-from-osx)
      )
  )

;; Basics
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)

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
(random t)
(req-package load-dir
  :force true
  :init
  (setq force-load-messages nil)
  (setq load-dir-debug t)
  (setq load-dir-recursive t)
  :config
  (load-dir-one my-init-dir)
  (req-package-finish))

;; OSX path stuff
(when (memq window-system '(mac ns))
  (setq insert-directory-program "gls")
  (req-package exec-path-from-shell
	     :init
	     (exec-path-from-shell-initialize))
  )



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
    (magit tide sane-term python company-jedi projectile org-bullets org lua-mode rainbow-delimiters fill-column-indicator column-enforce-mode highlight-parentheses smart-mode-line zenburn-theme smex idomenu flx-ido flycheck erc-hl-nicks autopair iedit sunrise-commander dired+ company-flx company load-dir req-package use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
