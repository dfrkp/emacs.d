;;; i-dirnav.el --- directory navigation
;;; Commentary:

;;; Code:
(require 'req-package)

(setq dired-listing-switches "-ABhlD --group-directories-first")
(setq dired-dwim-target t) ;; copy to other window

(require 'dired-x)
(setq-default dired-omit-files-p t) ; Buffer-local variable
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$\\|^Icon.$"))

(add-hook 'dired-mode-hook
      (lambda ()
        (dired-hide-details-mode)))

(if (string-equal system-type "windows-nt")
    (progn
      (setq ls-lisp-use-insert-directory-program t)      ;; use external ls
      (setq insert-directory-program "c:/cygwin64/bin/ls.exe") ;; ls program name
      (req-package w32-browser
	:config
	(add-hook dired-load-hook
	      (lambda
		(&rest ignore)
		(define-key
		  dired-mode-map "z" 'dired-w32-browser)
		(define-key
		  dired-mode-map [mouse-2] 'dired-w32-browser)
		)
	      )
	)
      )
  )

(req-package dired-toggle
  :ensure t
  :defer t
  :bind (("C-x s" . #'dired-toggle)
         :map dired-mode-map
         ("q" . #'dired-toggle-quit)
         ([remap dired-find-file] . #'dired-toggle-find-file)
         ([remap dired-up-directory] . #'dired-toggle-up-directory)
         ("C-c C-u" . #'dired-toggle-up-directory))
  :config
  (setq dired-toggle-window-size 32)
  (setq dired-toggle-window-side 'left)

  ;; Optional, enable =visual-line-mode= for our narrow dired buffer:
  (add-hook 'dired-toggle-mode-hook
            (lambda () (interactive)
              (visual-line-mode 1)
              (setq-local visual-line-fringe-indicators '(nil right-curly-arrow))
              (setq-local word-wrap nil))))

(req-package crux
  :ensure t
  :bind (("C-c o" . #'crux-open-with))
)


(provide 'i-dirnav)
;;; i-dirnav.el ends here

