;;; i-dirnav.el --- iedit, WindMove
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package dired+
	     :config
	     (setq dired-listing-switches "-alXGh --group-directories-first")
	     (setq dired-omit-files
		   (concat dired-omit-files "\\|^\\..+$")))

(req-package sunrise-commander
	     :config
	     (setq sr-autoload-extensions nil)
	     (setq sr-show-file-attributes nil)
	     (setq sr-confirm-kill-viewer nil)
	     (setq sr-show-hidden-files nil)
	     (setq sr-listing-switches "-alXGh --group-directories-first")
	     )


(provide 'i-dirnav)
;;; i-dirnav.el ends here

