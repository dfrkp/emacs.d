;;; i-ruby.el --- enhanced ruby mode and more
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package enh-ruby-mode
  :ensure t
  :mode ("\\(?:\\.rb\\|ru\\|rake\\|thor\\|gemspec\\)\\'" . enh-ruby-mode))

(req-package inf-ruby
  :ensure t
  :hook (enh-ruby-mode-hook . inf-ruby-minor-mode))


(provide 'i-ruby)
;;; i-ruby.el ends here
