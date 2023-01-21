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
  (add-to-list 'projectile-globally-ignored-directories "node_modules")
  (add-to-list 'projectile-globally-ignored-directories ".external_modules")
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(req-package ag
  :ensure t)

(provide 'i-projects)
;;; i-projects.el ends here
