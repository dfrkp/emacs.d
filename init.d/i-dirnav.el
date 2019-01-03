;;; i-dirnav.el --- directory navigation
;;; Commentary:

;;; Code:
(require 'req-package)

(setq dired-listing-switches "-ABhlD --group-directories-first")

(if (string-equal system-type "windows-nt")
    (progn
      (setq ls-lisp-use-insert-directory-program t)      ;; use external ls
      (setq insert-directory-program "c:/cygwin64/bin/ls.exe") ;; ls program name
      (req-package w32-browser
	:config
	(setq dired-load-hook
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

(provide 'i-dirnav)
;;; i-dirnav.el ends here

