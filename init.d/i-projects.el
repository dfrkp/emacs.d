;;; i-projects.el --- detect and use projects
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package projectile
  :config
  (setq projectile-mode-line
	'(:eval (format " Projectile[%s]"
                        (projectile-project-name))))
  (projectile-global-mode))

(provide 'i-projects)
;;; i-projects.el ends here
