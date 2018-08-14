;;; i-projects.el --- detect and use projects
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package projectile
  :ensure t
  
  :config
  (setq projectile-mode-line
	'(:eval (format " Projectile[%s]"
                        (projectile-project-name))))
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(provide 'i-projects)
;;; i-projects.el ends here
