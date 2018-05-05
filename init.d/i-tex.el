;;; i-tex.el --- iedit, WindMove
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package auctex
  :ensure t
  :defer t
  :config
  (TeX-global-PDF-mode t))

(provide 'i-tex)
;;; i-tex.el ends here

