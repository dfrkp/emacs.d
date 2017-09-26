;;; i-web.el --- react
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package web-mode
  :require flycheck
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
  (setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (defadvice web-mode-highlight-part (around tweak-jsx activate)
    (if (equal web-mode-content-type "jsx")
	(let ((web-mode-enable-part-face nil))
	  ad-do-it)
      ad-do-it))
  )

(req-package json-mode)

(req-package js2-mode)

(provide 'i-web)
;;; i-web.el ends here

