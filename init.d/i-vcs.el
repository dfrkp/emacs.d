;;; i-vcs.el --- magit
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :config
  (setq magit-process-popup-time 2)
  (setq magit-last-seen-setup-instructions "1.4.0"))


(provide 'i-vcs)
;;; i-vcs.el ends here

