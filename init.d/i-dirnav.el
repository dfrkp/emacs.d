;;; i-dirnav.el --- iedit, WindMove
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package sunrise-commander
  :el-get t
  :config
  (setq sr-autoload-extensions nil)
  (setq sr-show-file-attributes nil)
  (setq sr-confirm-kill-viewer nil)
  (setq sr-show-hidden-files nil)
  (setq sr-listing-switches "-alXGh --group-directories-first")
  )

(setq dired-listing-switches "-alXGh --group-directories-first")

(provide 'i-dirnav)
;;; i-dirnav.el ends here

