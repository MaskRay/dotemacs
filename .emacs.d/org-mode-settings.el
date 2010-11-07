(setq org-agenda-files '("~/org/home.org" "~/org/work.org"))
(global-set-key (kbd "C-c m r") 'org-remember)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(require 'remember)
(setq org-default-notes-file "~/org/todo.org")
(org-remember-insinuate)
(setq org-remember-templates (quote (("todo" ?t "* TODO %?\nCREATED: %U" nil nil nil))))


(provide 'org-mode-settings)