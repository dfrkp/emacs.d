;;; i-editing.el --- iedit, WindMove
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package iedit
	     :bind (("C-;" . iedit-mode)))

;; WindMove
(windmove-default-keybindings)
(global-set-key (kbd "C-S-B") 'windmove-left)
(global-set-key (kbd "C-S-F") 'windmove-right)
(global-set-key (kbd "C-S-P") 'windmove-up)
(global-set-key (kbd "C-S-N") 'windmove-down)

(req-package autopair
	     :config
	     (autopair-global-mode))

(provide 'i-editing)
;;; i-editing.el ends here

