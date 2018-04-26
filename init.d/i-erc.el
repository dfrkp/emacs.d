;;; i-erc.el --- TBD
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package erc-hl-nicks
  :ensure t
  :require erc
  :config
  (setq erc-hide-list (quote ("JOIN" "PART" "QUIT")))
  (setq erc-nick "dfrkp")
  (add-to-list 'erc-modules 'hl-nicks)
  (add-to-list 'erc-modules 'scrolltobottom)
  (add-to-list 'erc-modules 'move-to-prompt)
  (add-to-list 'erc-modules 'ring)
  :init
  (erc-update-modules)
  )

(provide 'i-erc)
;;; i-erc.el ends here

