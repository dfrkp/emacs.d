;;; i-rust.el --- rust-mode
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package rust-mode
  :ensure t)

(req-package flycheck-rust
  :ensure t
  :require flycheck rust-mode
  )

(provide 'i-rust)
;;; i-rust.el ends here
