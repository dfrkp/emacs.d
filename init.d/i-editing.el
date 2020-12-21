;;; i-editing.el --- iedit, WindMove
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package iedit
  :ensure t
  :bind (("C-;" . iedit-mode)))

;; WindMove
(windmove-default-keybindings)
(global-set-key (kbd "C-S-B") 'windmove-left)
(global-set-key (kbd "C-S-F") 'windmove-right)
(global-set-key (kbd "C-S-P") 'windmove-up)
(global-set-key (kbd "C-S-N") 'windmove-down)

(req-package autopair
  :ensure t
  :config
  (autopair-global-mode))

(req-package move-text
  :ensure t
  :config
  (move-text-default-bindings))

;; Buffers are edited in `text-mode' by default; to use a different
;; major mode, change `edit-server-default-major-mode' or customize
;; `edit-server-url-major-mode-alist' to specify major modes based
;; on the remote URL:

;;   (setq edit-server-url-major-mode-alist
;;         '(("github\\.com" . markdown-mode)))

;; Alternatively, set the mode in `edit-server-start-hook'.  For
;; example:

;; (add-hook 'edit-server-start-hook
;;           (lambda ()
;;             (when (string-match "github.com" (buffer-name))
;;               (markdown-mode))))
(req-package edit-server
  :ensure t
  :config
  (setq edit-server-new-frame nil)
  (edit-server-start))

(req-package outshine
  :ensure t)

(provide 'i-editing)
;;; i-editing.el ends here

