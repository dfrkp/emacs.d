;;; i-tex.el --- iedit, WindMove
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package tex
	     :config
	     (TeX-global-PDF-mode t))

(provide 'i-tex)
;;; i-tex.el ends here

