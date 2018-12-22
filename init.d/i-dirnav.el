;;; i-dirnav.el --- iedit, WindMove
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package sunrise-commander
  :el-get t
  :bind (("C-x s" . sunrise-cd))
  )

(setq dired-listing-switches "-alXGh --group-directories-first")

(req-package w32-browser)

(provide 'i-dirnav)
;;; i-dirnav.el ends here

