;;; i-term.el --- sane-term
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package sane-term
  :ensure t
  :bind (("C-x t" . sane-term)
	 ("C-x T" . sane-term-create))
  :config
  (defun my-terminal-visible-bell ()
    "A friendlier visual bell effect."
    (invert-face 'mode-line)
    (run-with-timer 0.1 nil 'invert-face 'mode-line))

  (setq visible-bell nil
	ring-bell-function 'my-terminal-visible-bell)

  (add-hook 'term-mode-hook (lambda()
			      (setq yas-dont-activate t))))

(provide 'i-term)
;;; i-term.el ends here

