;;; i-markdown.el --- markdown-mode
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(provide 'i-markdown)
;;; i-markdown.el ends here

