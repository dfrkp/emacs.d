;;; i-web.el --- react
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package web-mode)

(req-package rjsx-mode
  :require flycheck
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx?$" . rjsx-mode))
  (setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))
  (flycheck-add-mode 'javascript-eslint 'rjsx-mode)
  )

(req-package json-mode)

(req-package js2-mode)

(provide 'i-web)
;;; i-web.el ends here

