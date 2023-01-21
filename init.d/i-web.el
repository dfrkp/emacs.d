;;; i-web.el --- react, typescript, json, docker, terraform
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package rjsx-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.js.*$" . rjsx-mode))
  (add-to-list 'auto-mode-alist '("\\.json$" . json-mode)))

(req-package tide
  :ensure t
  :require rjsx-mode company flycheck
  :config
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    (company-mode +1)
    (set (make-local-variable 'company-backends)
         '((company-tide company-files :with company-yasnippet)
           (company-dabbrev-code company-dabbrev))))
  ;; formats the buffer before saving - we use prettier-js though
  ;; (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode)
  (add-hook 'js-mode-hook #'setup-tide-mode)
  (add-hook 'rjsx-mode-hook #'setup-tide-mode)
  (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
)

(req-package web-mode
  :ensure t
  :require tide company
  :config
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
  (flycheck-add-mode 'typescript-tslint 'web-mode)
  (flycheck-add-next-checker 'typescript-tslint 'jsx-tide 'append)
  (add-hook 'web-mode-hook 'company-mode)
  (add-hook 'web-mode-hook #'turn-on-smartparens-mode t)
  (setq web-mode-enable-auto-quoting nil)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-attr-indent-offset 2)
  (setq web-mode-attr-value-indent-offset 2))

(req-package prettier-js
  :ensure t
  :require tide
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
  (add-hook 'tide-mode-hook #'my/use-prettier-from-node-modules)
  (add-hook 'tide-mode-hook 'prettier-js-mode))

(req-package kubernetes
  :ensure t)

(req-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

(req-package earthfile-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("Earthfile\\'" . earthfile-mode)))

(req-package dockerfile-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(req-package terraform-mode
  :ensure t
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))

(req-package company-terraform
  :ensure t
  :require terraform-mode company
  :config
  (company-terraform-init))

(req-package docker
  :ensure t)

(req-package graphql-mode
  :ensure t)

(provide 'i-web)
;;; i-web.el ends here

