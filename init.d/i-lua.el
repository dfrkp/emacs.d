;;; i-lua.el --- TBD
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package lua-mode
  :ensure t
  
  :config
  (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
  (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
  (add-hook 'lua-mode-hook 'turn-on-font-lock)
  )

(provide 'i-lua)
;;; i-lua.el ends here

