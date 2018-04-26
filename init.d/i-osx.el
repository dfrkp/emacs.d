;;; i-osx.el --- get path from shell
;;; Commentary:

;;; Code:
(require 'req-package)

;; Mac
(if (string-equal system-type "darwin")
    (progn
      (setq ns-command-modifier 'meta)
      (defun copy-from-osx ()
	(shell-command-to-string "pbpaste"))

      (defun paste-to-osx (text &optional push)
	(let ((process-connection-type nil))
	  (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
	    (process-send-string proc text)
	    (process-send-eof proc))))
      (setq interprogram-cut-function 'paste-to-osx)
      (setq interprogram-paste-function 'copy-from-osx)
      )
  )

;; OSX path stuff
(when (memq window-system '(mac ns))
  (setq insert-directory-program "gls")
  (req-package exec-path-from-shell
    :ensure t
    :init
    (exec-path-from-shell-initialize))
  )

(provide 'i-osx)
;;; i-osx.el ends here

