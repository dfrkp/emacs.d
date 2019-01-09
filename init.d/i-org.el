;;; i-org.el --- iedit, WindMove
;;; Commentary:

;;; Code:
(require 'req-package)

(req-package org
  :ensure t
  :bind (("C-c l" . org-store-link)
	 ("C-c c" . org-capture)
	 ("C-c a" . org-agenda)
	 ("C-c b" . org-iswitchb))
  :config
  (setq org-directory (concat dropbox-directory "org/"))
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))
  (add-hook 'org-mode-hook 'turn-on-font-lock)
  (add-hook 'org-mode-hook
	    (lambda ()
	      (local-set-key (kbd "C-x ,") 'org-priority)
	      (local-set-key (kbd "<C-up>") 'outline-move-subtree-up)
	      (local-set-key (kbd "<C-down>") 'outline-move-subtree-down)
	      )
	    )
  (setq org-return-follows-link t)
  (setq org-catch-invisible-edits "smart")
  (setq org-default-notes-file (concat org-directory "work.org"))
  (setq org-capture-templates
	'(
	  ("t" "Todo" entry (file+headline "~/Dropbox/org/work.org" "TODO-List")
	   "* TODO %?\n  SCHEDULED: %t")
	  ("p" "Personal Todo" entry (file+headline "~/Dropbox/org/personal.org" "TODO-List")
	   "* TODO %?\n  SCHEDULED: %t")
	  )
	)

  (setq org-log-into-drawer t)
  (setq org-export-docbook-xslt-proc-command "xsltproc --output %o %s %i")
  (setq org-export-docbook-xsl-fo-proc-command "fop %i %o")

  (setq org-agenda-files (list (concat org-directory "work.org")))

  (setq org-refile-targets '((nil :maxlevel . 9)
			     (org-agenda-files :maxlevel . 9)))
  (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
  (setq org-refile-use-outline-path t)                  ; Show full paths for refiling
  (setq initial-major-mode 'org-mode)
  (setq bookmark-default-file (concat org-directory "bookmarks.bmk"))
  (setq org-export-backends
    '(ascii beamer html latex md odt confluence koma-letter)))

(req-package org-bullets
  :ensure t
  :require org
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode))

(req-package plantuml-mode
  :ensure t
  :config
  (add-to-list
   'org-src-lang-modes '("plantuml" . plantuml)))

(req-package htmlize
  :ensure t)

(provide 'i-org)
;;; i-org.el ends here

