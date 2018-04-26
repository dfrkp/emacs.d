;;; i-completion.el --- company
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)
  )

(req-package company-flx
  :ensure t
  :require company
  :config
  (with-eval-after-load 'company
    (company-flx-mode +1)))

(provide 'i-completion)
;;; i-completion.el ends here

