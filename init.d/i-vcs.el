;;; i-vcs.el --- magit
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package magit
  :bind (("C-x g" . magit-status))
  :config
  (setq magit-process-popup-time 2)
  (setq magit-last-seen-setup-instructions "1.4.0"))


(provide 'i-vcs)
;;; i-vcs.el ends here

