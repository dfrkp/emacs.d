;;; i-php.el --- php-mode
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package php-mode
  :ensure t)

(req-package company-php
  :ensure t
  :require company)

(provide 'i-php)
;;; i-php.el ends here

