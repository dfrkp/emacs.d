;;; i-auto-update.el --- automatically update packages on startup
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(provide 'i-android)
;;; i-auto-update.el ends here

