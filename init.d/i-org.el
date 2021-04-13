;;; i-org.el --- org-mode
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
  (add-hook 'org-agenda-mode-hook (lambda () (hl-line-mode 1)))
  (add-hook 'org-mode-hook 'turn-on-font-lock)
  (add-hook 'org-mode-hook
	    (lambda ()
	      (local-set-key (kbd "C-x ,") 'org-priority)
	      (local-set-key (kbd "<C-up>") 'outline-move-subtree-up)
	      (local-set-key (kbd "<C-down>") 'outline-move-subtree-down)
	      )
	    )
  (add-hook 'org-mode-hook 'auto-save-mode)
  (add-hook 'org-agenda-mode-hook
          (lambda ()
            (add-hook 'auto-save-hook 'org-save-all-org-buffers nil t)
            (auto-save-mode)))
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
  ;;; support koma report (scrreprt)
  (with-eval-after-load 'ox-latex
    (add-to-list 'org-latex-classes
                 '("scrreprt"
                   "\\documentclass{scrreprt}
                    \\usepackage[utf8]{inputenc}
                    [PACKAGES]
                    [EXTRA]"
		   ("\\chapter{%s}" . "\\chapter*{%s}")
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
  ;;;                     [NO-DEFAULT-PACKAGES]
  (add-hook 'org-mode-hook 'auto-fill-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)
  (setq initial-buffer-choice (lambda ()
				(org-agenda-list 1)
				(delete-other-windows)
				(get-buffer "*Org Agenda*")))
  (setq org-export-backends
	'(ascii reveal html latex md))
  )

(req-package org-ref
  :ensure t
  :require org
)

(req-package ox-reveal
  :ensure t
  :require org
  :config
  (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"))

(req-package org-bullets
  :ensure t
  :require org
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode))

(req-package plantuml-mode
  :ensure t
  :require org
  :config
  (add-to-list
   'org-src-lang-modes '("plantuml" . plantuml))
  (plantuml-set-exec-mode 'executable)
  )

(req-package htmlize
  :ensure t)

(req-package org-trello
  :ensure t
  :require org
  :config
  (custom-set-variables '(org-trello-files '("castle-no9.org")))
  (add-hook 'org-trello-mode
	    (lambda ()
	      (add-hook 'after-save-hook 'org-trello-sync-buffer nil)
	      ))
)

(provide 'i-org)
;;; i-org.el ends here

