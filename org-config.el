(setq org-agenda-files '("~/org/home.org" "~/org/work.org"))
(global-set-key (kbd "C-c m r") 'org-remember)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(require 'remember)
(setq org-default-notes-file "~/org/todo.org")
(org-remember-insinuate)
(setq org-remember-templates (quote (("todo" ?t "* TODO %?\nCREATED: %U" nil nil nil))))

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
