;;; i-python.el --- elpy
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package elpy
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
  :custom
  (elpy-rpc-backend "jedi"))

(req-package python
  :ensure t
  :config
  (setq python-indent-offset 4)
  )

(provide 'i-python)
;;; i-python.el ends here

