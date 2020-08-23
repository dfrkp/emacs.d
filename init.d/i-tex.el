;;; i-tex.el --- tex
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package tex
  :ensure auctex
  :config
  (TeX-global-PDF-mode t))

(provide 'i-tex)
;;; i-tex.el ends here

