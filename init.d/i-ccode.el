;;; i-ccode.el --- company
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package company-irony
  :require company irony
  :config
  (add-to-list 'company-backends 'company-irony))

(req-package flycheck-irony
  :require flycheck irony
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(req-package irony
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(req-package irony-eldoc
  :require irony
  :config
  (add-hook 'irony-mode-hook #'irony-eldoc))

(provide 'i-ccode)
;;; i-ccode.el ends here

