;;; i-typescript.el --- iedit, WindMove
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package tide
	     :require company
	     :config
	     (defun setup-tide-mode ()
	       (interactive)
	       (tide-setup)
	       (flycheck-mode +1)
	       (setq flycheck-check-syntax-automatically '(save mode-enabled))
	       (eldoc-mode +1)
	       (tide-hl-identifier-mode +1)
	       ;; company is an optional dependency. You have to
	       ;; install it separately via package-install
	       ;; `M-x package-install [ret] company`
	       (company-mode +1))
	     ;; formats the buffer before saving
	     (add-hook 'before-save-hook 'tide-format-before-save)
	     (add-hook 'typescript-mode-hook #'setup-tide-mode)
	     )

(provide 'i-typescript)
;;; i-typescript.el ends here

