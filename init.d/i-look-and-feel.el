;;; i-look-and-feel.el --- theming, modeline and more
;;; Commentary:

;;; Code:
(require 'req-package)

;; Cycle through this set of themes

(req-package zenburn-theme
	     :init
	     (defvar my-themes '(zenburn tsdh-light))
	     (defvar my-cur-theme nil)
	     (defun cycle-my-theme ()
	       "Cycle through a list of themes, my-themes."
	       (interactive)
	       (when my-cur-theme
		 (disable-theme my-cur-theme)
		 (setq my-themes (append my-themes (list my-cur-theme))))
	       (setq my-cur-theme (pop my-themes))
	       (load-theme my-cur-theme t))
	     (cycle-my-theme)
	     :bind (("C-=" . cycle-my-theme))
	     )



;; Mode-line
(req-package smart-mode-line
	     :config
	     (setq sml/no-confirm-load-theme t)
	     (add-hook 'after-init-hook 'sml/setup))

;; highlight matching parantheses
(req-package highlight-parentheses
	     :config
	     (add-hook 'prog-mode-hook #'highlight-parentheses-mode))

;; Highlight the current line where the cursor is
(add-hook 'prog-mode-hook #'hl-line-mode)

;; Highlight too wide text
(req-package column-enforce-mode
	     :config
	     (progn
	       (setq column-enforce-column 80)
	       (add-hook 'prog-mode-hook 'column-enforce-mode)))

(req-package fill-column-indicator
	     :config
	     (progn
	       (setq fci-rule-column 80)
	       (setq fci-rule-width 1)
	       (setq fci-rule-color "#1e2320")
	       (add-hook 'prog-mode-hook 'fci-mode)))

;; Highlight parantheses based on their level
(req-package rainbow-delimiters
	     :config
	     (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))


(provide 'i-look-and-feel)
;;; i-look-and-feel.el ends here
