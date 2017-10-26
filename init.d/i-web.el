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
  (setq js2-basic-offset 2))

(provide 'i-web)
;;; i-web.el ends here

