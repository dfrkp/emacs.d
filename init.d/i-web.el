;;; i-web.el --- react, typescript, json, docker, terraform
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package rjsx-mode
  :ensure t
  :require flycheck
  :config
  (add-to-list 'auto-mode-alist '("\\.\\(jsx?\\|tsx?\\)$" . rjsx-mode))
  (setq-default flycheck-disabled-checkers
  		(append flycheck-disabled-checkers
  			'(javascript-jshint)))
  (flycheck-add-mode 'javascript-eslint 'rjsx-mode)
  (defadvice js-jsx-indent-line (after js-jsx-indent-line-after-hack activate)
    "Workaround sgml-mode and follow airbnb component style."
    (save-excursion
      (beginning-of-line)
      (if (looking-at-p "^ +\/?> *$")
  	  (delete-char sgml-basic-offset))))
  )

(req-package json-mode
  :ensure t)

(req-package js2-mode
  :ensure t
  :config
  (setq js2-basic-offset 2)
  (setq js2-strict-trailing-comma-warning nil)
  (setq js2-strict-missing-semi-warning nil)

  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
  (add-hook 'js2-mode-hook
	    (lambda () (progn
			 (set-variable 'indent-tabs-mode nil))))
  )

(req-package prettier-js
  :ensure t
  :require js2-mode
  :config
  (defun my/use-prettier-from-node-modules ()
    (let* ((root (locate-dominating-file
		  (or (buffer-file-name) default-directory)
		  "node_modules"))
	   (prettier (and root
			  (expand-file-name "node_modules/prettier/bin-prettier.js"
					    root))))
      (when (and prettier (file-executable-p prettier))
	(setq-local prettier-js-command prettier))))
  (add-hook 'js2-mode-hook #'my/use-prettier-from-node-modules)
  (add-hook 'js2-mode-hook 'prettier-js-mode))

(req-package kubernetes
  :ensure t)

(req-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

(req-package dockerfile-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

;;; Terraform
(req-package terraform-mode
  :ensure t
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))

(req-package company-terraform
  :ensure t
  :require terraform-mode
  :config
  (company-terraform-init))

(req-package docker
  :ensure t)

(req-package tide
  :ensure t
  :require company js2-mode flycheck
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
  (add-hook 'js2-mode-hook #'setup-tide-mode)
  (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
  )

(req-package graphql-mode
  :ensure t)

(provide 'i-web)
;;; i-web.el ends here

