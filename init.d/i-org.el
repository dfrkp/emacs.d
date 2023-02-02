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
  (setq org-directory (concat sync-directory "org/"))
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
	  ;; Tasks
	  ("t" "Tasks")
	  ("tw" "Work Task" entry (file+headline "work.org" "Tasks")
	   "* TODO %?
  SCHEDULED: %t
  :LOGBOOK:
  - State \"TODO\"       from \"\"           %U
  :END:" :empty-lines 1)
	  ("tg" "Gruene Task" entry (file+headline "gruene.org" "Aufgaben")
	   "* TODO %?
  SCHEDULED: %t
  :LOGBOOK:
  - State \"TODO\"       from \"\"           %U
  :END:" :empty-lines 1)
	  ("tp" "Personal Todo" entry (file+headline "personal.org" "Tasks")
	   "* TODO %?
  SCHEDULED: %t
  :LOGBOOK:
  - State \"TODO\"       from \"\"           %U
  :END:" :empty-lines 1)
	  ("ta" "Algea Todo" entry (file+headline "algea.org" "Tasks")
	   "* TODO %?
  SCHEDULED: %t
  :LOGBOOK:
  - State \"TODO\"       from \"\"           %U
  :END:" :empty-lines 1)
	  ("tu" "Ultivue Todo" entry (file+headline "ultivue.org" "Tasks")
	   "* TODO %?
  SCHEDULED: %t
  :LOGBOOK:
  - State \"TODO\"       from \"\"           %U
  :END:" :empty-lines 1)
	  ;; Meetings
	  ("m" "Meetings")
	  ("mw" "Work Meeting Notes" entry (file+headline "work.org" "Meetings")
	   "* %^{subject} %^{meeting date}U

   Participants: %^{meeting with}

   %?" :immediate-finish t :jump-to-captured t :empty-lines 1)

	  ("ma" "Algea Meeting Notes" entry (file+headline "algea.org" "Meetings")
	   "* %^{subject} %^{meeting date}U

   Participants: %^{meeting with}

   %?" :immediate-finish t :jump-to-captured t :empty-lines 1)

	  ("mu" "Ultivue Meeting Notes" entry (file+headline "ultivue.org" "Meetings")
	   "* %^{subject} %^{meeting date}U

   Participants: %^{meeting with}

   %?" :immediate-finish t :jump-to-captured t :empty-lines 1)

	  ("mt" "Tech Interivew" entry (file+headline "algea.org" "Meetings")
	   "* Tech Interview %^{candidate} %^{meeting date}U
** Intro (if no intro call before)
   - Motivation
     - Where are you now and where do you want to go?
   - Have you used next.js before?
** Look around and run
   : (-) negative observation
   : (+) positive observation

** Registration Form
   - TASK: Open the registration form. A product owner got a data
     privacy request to delete all personal data we have on a
     particular user. Now he's asking you to give her a list of
     systems she has to check out. Please use the code and the
     environment you have here to find out.

** Patient List
   - TASK: Our patient engagement team wants to know the patients
     that are in a given stage of our process. Please use the
     mock_data.json as a database to create an endpoint in the
     backend and then put a page in the frontend that allows our team
     to select the stage and then shows a list of patients for that
     stage.

** Summary
   - How would rate your own performance and how does it compare to
     your usual work?
     - 
   - What skills and strengths of yours were you not able to show due
     today?
     - 
     
** Verdict
" :immediate-finish t :jump-to-captured t :empty-lines 1)

	  ("mf" "Full-Stack Intro" entry (file+headline "algea.org" "Meetings")
	   "* [Intro|Full-Stack] %^{candidate} %^{meeting date}U
** Candidate intro
   -
** Tech quiz:
   : Perfect answer (*), Answered correctly (+)
   : didn't know or wrong answer (-), close, but not quite (~)
 
   - *( )* Can you use React without JSX?
     - *( )* How?
   - *( )* What does useState return?
   - *( )* When would you use useContext?
   - *( )* What's docker-compose good for?
   - *( )* Explain the difference between a merge and a rebase in git?
   - *( )* What does REST stand for?
   - *( )* How is a REST API different from a GraphQL API?
     - *( )* Can you think of a possible disadvantage of GraphQL?
   - *( )* Do you know the SOLID principles?
     - *( )* Could you explain one of OLID?
   - *( )* What is AWS RDS used for?
   - *( )* What's the responsibility of a scrum master?

** Work environment / your questions?
   - What are you looking for in a new team other than the tech stack?
** What other questions do you have for us?
   -
** Other notes:
   - Salary:
   - Availability:
** Overall
   -
" :immediate-finish t :jump-to-captured t :empty-lines 1)

	  ("ms" "SDET Intro" entry (file+headline "algea.org" "Meetings")
	   "* [Intro|SDET] %^{candidate} %^{meeting date}U
** Candidate intro
   -

** Tech quiz
   : Please provide one sentence answers, it's okay to no know many
   : questions, this is intentionally broad
     
   : Perfect answer (*), Answered correctly (+), didn't know or wrong answer (-),
   : close, but not quite (~)

   - How do you select or locate an element in the DOM?

   - *( )* In HTML, what is the difference between IDs and Classes?
     : IDs are unique, classes not
     : Each element can have only one ID, but multiple classes
     : Each page can have only one element with that ID, but multiple classes on the same element
     : IDs are useful to find any single element, classes for any number of elements
       
   - *( )* What is the virtual DOM concept good for?
     : preventing expensive re-rendering of the actual dom by comparing
     : virtual DOM and actual DOM
   - *( )* What's docker-compose good for?
     : starting multiple containers / services / bringing up a whole environment
   - *( )* Explain the difference between a merge and a rebase in
     git?
     : merge combines changes in a new commit that now has 2 parents;
     : rebase moves changes to a new parent and achieves a linear history
   - *( )* How is a REST API different from a GraphQL API?
     : REST uses the HTTP methods to access resources (multiple endpoints);
     : GraphQL uses POST to send a query to the server which responds with
     : the exact data that was requested (prevents over-fetching)
     - *( )* Can you think of a possible disadvantage of GraphQL?
       : It breaks fundamental concepts of the WEB that we rely on for caching
       : and hence belongs to the same group as web sockets (great advantages,
       : but no longer compatible with all the basic ideas of the web)
       : Example: Universities often use proxy servers that cache pages that
       : students are accessing, so that not every student has to fetch the
       : page again (not possible with GraphQL
   - *( )* What is the difference between statement and branch
     coverage?
     : Statement coverage is the number of lines / statements executed vs
     : the total number of lines / statement; branch coverage also takes into
     : account conditionals (every condition has to be covered to achieve 100%)
     - *( )* Bonus: How is path coverage different?
       : Path coverage goes beyond branch coverage by considering all possible
       : combinations of the conditionals

** Elaborate questions
   : There is no right answer here, but we would like to understand how you
   : are thinking about these issues
     
   - When would you use which e2e technology? (Selenium vs Cypress
     vs TestCafe vs Puppeteer vs Playwrigth)
   - What strategies would you recommend to prevent flaky tests?
   - What approach do you consider most effective to test
     performance and reliability?
   - When would you use Cucumber / BDD?
   - What's the role of a SDET in scrum?
       
** Work environment / your questions?
   - What are you looking for in a new team other than the tech stack?
** What other questions do you have for us?
   -
** Other notes:
   - Salary:
   - Availability:
** Overall
   -
" :immediate-finish t :jump-to-captured t :empty-lines 1)


	  ("md" "DevOps Intro" entry (file+headline "algea.org" "Meetings")
	   "* [Intro|DevOps] %^{candidate} %^{meeting date}U

*** Candidate intro
    - 
*** Tech quiz:
    : Perfect answer (*), Answered correctly (+)
    : didn't know or wrong answer (-), close, but not quite (~)
 

    - Kubernetes
      - *( )* What is the difference between a DeamonSet and a
        StatefulSet?
      - *( )* When to use different clusters vs different namespaces?
      - *( )* K8s updates; How to prepare for it, what to watch out
        for? 
	- What was the worst thing that happened to you when upgrading
          K8s? 
    - Terraform
      - *( )* Best practices for structuring terraform code. When to
        use a module?
      - *( )* What would you recommend to manage the state?
	- *( )* Why not Terraform Cloud?
    - *( )* Which CI/CD solutions you have worked with and what's your
      favorite, and why? 
      - *( )* Have you used GitHub Actions?

*** What other questions do you have for us?
    - 
*** Other notes:
    - Salary: 
    - Availability: 
*** Overall
    - 
" :immediate-finish t :jump-to-captured t :empty-lines 1)

 ("ml" "Leader Intro" entry (file+headline "algea.org" "Meetings")
	   "* [Intro|Lead] %^{candidate} %^{meeting date}U

*** Candidate intro
    - 

** Tech quiz:
   : Perfect answer (*), Answered correctly (+)
   : didn't know or wrong answer (-), close, but not quite (~)
 
   - *( )* How do Angular and React differ in their approach to rendering the DOM?
   - *( )* How's docker-compose different than Kubernetes?
   - *( )* How is a REST API different from a GraphQL API?

*** Questions:

   - Tell me about a direct report who was able to take on a new role
     thanks to your coaching and leadership?
   - What was the biggest organizational change you had to deal with
     so far?
   - Can you think of a difficult decision to let someone go?
   - How do you make a technical decision if you do not have
     experience with one of the options?
*** What other questions do you have for us?
    - 
*** Other notes:
    - Salary: 
    - Availability: 
*** Overall
    - 
" :immediate-finish t :jump-to-captured t :empty-lines 1)


	))



  (setq org-log-into-drawer t)
  (setq org-export-docbook-xslt-proc-command "xsltproc --output %o %s %i")
  (setq org-export-docbook-xsl-fo-proc-command "fop %i %o")

  (setq org-agenda-files (list org-directory ))

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


(provide 'i-org)
;;; i-org.el ends here

