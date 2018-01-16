;;; i-ccode.el --- company
;;; Commentary:

;;; Code:
(require 'req-package)

;; (req-package company-irony
;;   :require company irony
;;   :config
;;   (add-to-list 'company-backends 'company-irony))

;; (req-package flycheck-irony
;;   :require flycheck irony
;;   :config
;;   (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; (req-package irony
;;   :config
;;   (add-hook 'c++-mode-hook 'irony-mode)
;;   (add-hook 'c-mode-hook 'irony-mode)
;;   (add-hook 'objc-mode-hook 'irony-mode)
;;   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;; (req-package irony-eldoc
;;   :require irony
;;   :config
;;   (add-hook 'irony-mode-hook #'irony-eldoc))

;; (req-package dumb-jump
;;   :bind (("M-g o" . dumb-jump-go-other-window)
;;          ("M-g j" . dumb-jump-go)
;;          ("M-g i" . dumb-jump-go-prompt)
;;          ("M-g x" . dumb-jump-go-prefer-external)
;;          ("M-g z" . dumb-jump-go-prefer-external-other-window))
;;   :config
;;   (setq dumb-jump-selector 'ivy)
;;   )

(req-package ggtags
  :pin elpa
  :config
  (add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1)))))

(req-package cmake-mode
  :mode "CMakeLists\\.txt\\'")

(provide 'i-ccode)
;;; i-ccode.el ends here

