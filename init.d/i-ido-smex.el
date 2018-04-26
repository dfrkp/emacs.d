;;; i-ido-smex.el --- flexible fuzzy matching everywhere
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package ido
  :ensure t
  :config
  (ido-mode 1)
  (ido-everywhere 1))

(req-package flx
  :ensure t)

(req-package flx-ido
  :ensure t
  :require flx ido
  :config
  (flx-ido-mode 1)
  (setq ido-enable-flex-matching t)
  ;; disable ido faces to see flx highlights.
  (setq ido-use-faces nil))

(req-package idomenu
  :ensure t
  :bind (("C-c i" . idomenu))
  :config
  (autoload 'idomenu "idomenu" nil t))

(req-package smex
  :ensure t
  :config
  (global-set-key [(meta x)] (lambda ()
			       (interactive)
			       (or (boundp 'smex-cache)
				   (smex-initialize))
			       (global-set-key [(meta x)] 'smex)
			       (smex)))

  (global-set-key [(shift meta x)] (lambda ()
				     (interactive)
				     (or (boundp 'smex-cache)
					 (smex-initialize))
				     (global-set-key [(shift meta x)] 'smex-major-mode-commands)
				     (smex-major-mode-commands))))

(provide 'i-ido-smex)
;;; i-ido-smex.el ends here
