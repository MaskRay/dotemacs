(setq org-agenda-files '("~/org/home.org" "~/org/work.org"))
(global-set-key (kbd "C-c m r") 'org-remember)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(require 'remember)
(setq org-default-notes-file "~/org/todo.org")
(org-remember-insinuate)
(setq org-remember-templates (quote (("todo" ?t "* TODO %?\nCREATED: %U" nil nil nil))))


(require 'appt)
(defun djcb-popup (title msg &optional icon sound)
  "Show a popup if we're on X, or echo it otherwise; TITLE is the title
of the message, MSG is the context. Optionally, you can provide an ICON and
a sound to be played"
  (interactive)
  (when sound (shell-command
                (concat "mplayer -really-quiet " sound " 2> /dev/null")))
  (if (eq window-system 'x)
    (shell-command (concat "notify-send "
                     (if icon (concat "-i " icon) "")
                     " '" title "' '" msg "'"))
    (message (concat title ": " msg))))

(defun djcb-appt-display (min-to-app new-time msg)
  (djcb-popup (format "Appointment in %s minute(s)" min-to-app) msg 
	      "/usr/share/icons/gnome/48x48/status/appointment-soon.png"
	      "/usr/share/sounds/ubuntu/stereo/phone-incoming-call.ogg"))

(setq
  appt-message-warning-time 15
  appt-display-format 'window
  appt-disp-window-function 'djcb-appt-display)
(appt-activate 1)
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)

(provide 'org-mode-settings)
