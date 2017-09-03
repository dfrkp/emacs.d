;;; i-fix-mark-command.el --- Use M-o to jump through mark ring
;;; Commentary:

;;; Code:

(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))
(global-set-key (kbd "M-o") 'jump-to-mark)

(provide 'i-fix-mark-command)

;;; i-fix-mark-command.el ends here
