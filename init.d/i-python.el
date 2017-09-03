;;; i-python.el --- iedit, WindMove
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package company-jedi
	     :require company
	     :config
	     (defun company/python-mode-hook ()
	       (add-to-list 'company-backends 'company-jedi))
	     (add-hook 'python-mode-hook 'company/python-mode-hook)
	     (add-to-list 'company-backends 'company-files)
	     (add-hook 'python-mode-hook 'jedi:setup)
	     (defun jedi-config:setup-server-args ()
	       (setq jedi:server-args (list "--sys-path" (projectile-project-root))))
	     (add-hook 'python-mode-hook
		       'jedi-config:setup-server-args)
	     (setq jedi:use-shortcuts 1)
	     )

(req-package python
	     :config
	     (setq python-indent-offset 4)
	     (setq python-check-command "epylint")
	     (setq python-pylint-command "epylint"))

(provide 'i-python)
;;; i-python.el ends here

