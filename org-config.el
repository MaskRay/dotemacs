(setq org-agenda-files '("~/org/home.org" "~/org/work.org"))
(global-set-key (kbd "C-c m r") 'org-remember)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(require 'org-protocol)

(setq org-default-notes-file (concat org-directory "capture.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file (format "%s/todo.org" org-directory))
         "* TODO %?\n  %i\n  %a")
        ("x" "Note with Clipboard" entry (file (format "%s/notes.org" org-directory))
         "* %?\n  %i\n  %x")
        ("n" "Note" entry (file (format "%s/notes.org" org-directory))
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

(provide 'org-config)
