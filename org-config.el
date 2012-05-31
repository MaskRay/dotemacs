(setq org-agenda-files '("~/org/todo.org"))
(global-set-key (kbd "C-c m r") 'org-remember)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

;; Make Org play well with yasnippet
(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
(add-hook 'org-mode-hook
	  (lambda ()
	    (make-variable-buffer-local 'yas/trigger-key)
	    (setq yas/trigger-key [tab])
	    (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
	    (define-key yas/keymap [tab] 'yas/next-field)))

;; Response to external programs
(when (require 'org-protocol nil 'noerror)
  (defun cofi/capture-frame ()
    (modify-frame-parameters nil
			     '( (name . "Capture Frame")
				(width . 80)
				(height . 15)
				(vertical-scroll-bars . nil)
				(menu-bar-lines . nil)
				(tool-bar-lines . nil)))
    (if (fboundp 'x-focus-frame)
	(x-focus-frame nil))
    (org-capture)
    (linum-mode -1)
    (delete-other-windows))

  (defun cofi/agenda-frame ()
    (modify-frame-parameters nil
			     '( (name . "Agenda Frame")
				(width . 80)
				(height . 15)
				(vertical-scroll-bars . nil)
				(menu-bar-lines . nil)
				(tool-bar-lines . nil)))
    (if (fboundp 'x-focus-frame)
	(x-focus-frame nil))
    (let ((org-agenda-window-setup 'current-window))
      (org-agenda-list)))
  )

(setq org-default-notes-file (concat org-directory "/capture.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file (format "%s/todo.org" org-directory))
         "* TODO %?\n  %i\n  %a")
        ("x" "Note with Clipboard" entry (file (format "%s/notes.org" org-directory))
         "* %?\n  %i\n  %x")
        ("n" "Note" entry (file (format "%s/notes.org" org-directory))
         "* %?\n  %i\n  %a")
        ("l" "Literature" entry (file (format "%s/literature.org" org-directory))
         "* %?\n  %i\n  %a")
        ;; dedicated templates
        ("s" "Save link for reading" entry (file+headline
                                            (format "%s/links.org" org-directory)
                                            "Unsorted")
         "* %:description\n  %:link\n  %U"
         )
        ("c" "Contacts" entry (file (format "%s/contacts.org" org-directory))
         "* %(org-contacts-template-name)
:PROPERTIES:
:EMAIL: %(org-contacts-template-email)
:END:")
        ))

(setq
  appt-message-warning-time 15
  appt-display-format 'window
  appt-disp-window-function 'djcb-appt-display)
(appt-activate 1)
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)




(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  )
(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(require 'org-xelatex)

(provide 'org-config)
