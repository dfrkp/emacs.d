;;; i-flycheck.el --- autoindent, iedit
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package flycheck
  :ensure t
  :config
  (global-flycheck-mode 1)
  (setq flycheck-terraform-tflint-executable "tflint -f junit")
  (setq flycheck-highlighting-mode 'symbols)
  (add-hook 'cc-mode-hook 'flycheck-mode)
  (eval-after-load 'flycheck-mode
    (put 'python-flake8 :flycheck-next-checkers '(python-pylint)))
  (defun my/use-eslint-from-node-modules ()
    (let* ((root (locate-dominating-file
		  (or (buffer-file-name) default-directory)
		  "node_modules"))
	   (eslint (and root
			(expand-file-name "node_modules/eslint/bin/eslint.js"
					  root))))
      (when (and eslint (file-executable-p eslint))
	(setq-local flycheck-javascript-eslint-executable eslint))))
  (add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
  )
(provide 'i-flycheck)
;;; i-flycheck.el ends here

