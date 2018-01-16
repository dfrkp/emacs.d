;;; i-web.el --- react
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package rjsx-mode
  :require flycheck
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx?$" . rjsx-mode))
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

(req-package json-mode)

(req-package js2-mode
  :config
  (setq js2-basic-offset 2)
  (setq js2-strict-trailing-comma-warning nil)

  (add-hook 'js2-mode-hook
	    (lambda () (progn
			 (set-variable 'indent-tabs-mode nil))))
  )

(req-package prettier-js
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

(req-package kubernetes)
(req-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

(req-package dockerfile-mode
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))
(provide 'i-web)
;;; i-web.el ends here

