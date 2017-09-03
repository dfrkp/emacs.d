;;; i-flycheck.el --- autoindent, iedit
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package flycheck
	     :config
	     (global-flycheck-mode 1)
	     (setq flycheck-highlighting-mode 'symbols)
	     (add-hook 'cc-mode-hook 'flycheck-mode)
	     (eval-after-load 'flycheck-mode
	       (put 'python-flake8 :flycheck-next-checkers '(python-pylint))))
(provide 'i-flycheck)
;;; i-flycheck.el ends here

