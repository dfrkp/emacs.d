;;; i-look-and-feel.el --- theming, modeline and more
;;; Commentary:

;;; Code:
(require 'req-package)

;; Basics
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)
(setq visible-bell 1)

;; Backups
(setq make-backup-files t)
;; Save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Cycle through this set of themes
(req-package zenburn-theme
  :ensure t
  :require leuven-theme
  :init
  (defvar my-themes '(zenburn leuven))
  (defvar my-cur-theme nil)
  (defun cycle-my-theme ()
    "Cycle through a list of themes, my-themes."
    (interactive)
    (when my-cur-theme
      (disable-theme my-cur-theme)
      (setq my-themes (append my-themes (list my-cur-theme))))
    (setq my-cur-theme (pop my-themes))
    (message (format "Switching to theme %s..." my-cur-theme))
    (load-theme my-cur-theme t))
  (cycle-my-theme)
  (cycle-my-theme)
  (cycle-my-theme) ;; apparently this helps to ensure the faces are
		   ;; reset properly after loading leuven
  :bind (("C-=" . cycle-my-theme))
  )

(req-package leuven-theme
  :ensure t)

;; Mode-line
(req-package smart-mode-line
  :ensure t
  
  :config
  (display-battery-mode 1)
  (display-time-mode 1)
  (setq sml/no-confirm-load-theme t)
  (add-hook 'after-init-hook 'sml/setup))


;; highlight matching parantheses
(req-package highlight-parentheses
  :ensure t
  
  :config
  (add-hook 'prog-mode-hook #'highlight-parentheses-mode))

;; Highlight the current line where the cursor is
(add-hook 'prog-mode-hook #'hl-line-mode)

;; Highlight too wide text
(req-package column-enforce-mode
  :ensure t
  
  :config
  (progn
    (setq column-enforce-column 80)
    (add-hook 'prog-mode-hook 'column-enforce-mode)))

(req-package fill-column-indicator
  :ensure t
  
  :config
  (progn
    (setq fci-rule-column 80)
    (setq fci-rule-width 1)
    (setq fci-rule-color "#1e2320")
    (add-hook 'prog-mode-hook 'fci-mode)))

;; Highlight parantheses based on their level
(req-package rainbow-delimiters
  :ensure t
  
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(set-frame-font "Inconsolata-14")

(req-package emojify
  :ensure t
  :bind (("C-M-SPC" . emojify-insert-emoji))
  :config
  (emojify-set-emoji-styles '(unicode))
  :hook (after-init . global-emojify-mode))

(provide 'i-look-and-feel)
;;; i-look-and-feel.el ends here
