;;; i-python.el --- elpy
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  (setq elpy-rpc-python-command "python3"))

(req-package python
  :ensure t
  :config
  (setq python-indent-offset 4)
  )

(req-package python-black
  :ensure t
  :after python
  :hook (python-mode . python-black-on-save-mode-enable-dwim))

(req-package code-cells
  :ensure t
  :after python
  :hook (python-mode . code-cells-mode-maybe))

(provide 'i-python)
;;; i-python.el ends here

