;;; i-projects.el --- detect and use projects
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package projectile
	     :config
	     (projectile-global-mode))

(provide 'i-projects)
;;; i-projects.el ends here
