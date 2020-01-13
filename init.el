;;; init.el --- ensure basic emacs features are available and set base parameter
;;; Commentary:

;;; Code:
					; (package-initialize)
(require 'package)
;; Read init file before loading packages
(setq package-enable-at-startup nil)

;; global config
(defconst dropbox-directory "~/Dropbox/")
(defconst my-init-dir "~/.emacs.d/init.d")
(setq bookmark-default-file (concat dropbox-directory "org/bookmarks.bmk"))

;; Windows special treatment
(if (string-equal system-type "windows-nt")
    (progn ;; true => Windows
      ;; Prevent issues with the Windows null device (NUL)
      ;; when using cygwin find with rgrep.
      (defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
	"Use cygwin's /dev/null as the null-device."
	(let ((null-device "/dev/null"))
	  ad-do-it))
      (ad-activate 'grep-compute-defaults)
      ;; setup cygwin environment
      (setq w32-get-true-file-attributes nil)
      (when (boundp 'w32-pipe-read-delay)
	(setq w32-pipe-read-delay 0))
      ;; Set the buffer size to 64K on Windows (from the original 4K)
      (when (boundp 'w32-pipe-buffer-size)
	(setq irony-server-w32-pipe-buffer-size (* 64 1024)))
      )
  (progn ;; false => MacOS
    (setq select-enable-clipboard t)
    (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
    )
  )

;; start emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Package Manager
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

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

(require-package 'req-package)
(require 'req-package)
(req-package--log-set-level 'trace)

;; init.d
(dolist (i-file '(
		  "i-ido-smex.el"
		  "i-completion.el"
		  "i-look-and-feel.el"
		  "i-auto-update.el"
		  "i-android.el"
		  "i-ccode.el"
		  "i-dirnav.el"
		  "i-editing.el"
		  "i-erc.el"
		  "i-fix-mark-command.el"
		  "i-flycheck.el"
		  "i-insert-file-name-in-buffer.el"
		  "i-lua.el"
		  "i-markdown.el"
		  "i-org.el"
		  "i-osx.el"
		  "i-projects.el"
		  "i-python.el"
		  "i-ruby.el"
		  "i-term.el"
		  "i-tex.el"
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

(provide 'init)
;;; init.el ends here
