(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-set-key (kbd "<C-mouse-4>") (lambda () (interactive) (text-scale-decrease 1)))
(global-set-key (kbd "<C-mouse-5>") (lambda () (interactive) (text-scale-increase 1)))

(global-set-key (kbd "C-c C-r") 'open-current-file-as-admin)


(global-set-key (kbd "C-x k") 'kill-buffer-and-window)
(global-set-key (kbd "C-x K") (cmd (kill-buffer (current-buffer))))
(global-set-key (kbd "C-4") 'kill-buffer-and-window)
(global-set-key (kbd "C-3") 'split-window-horizontally)
(global-set-key (kbd "C-2") 'split-window-vertically)
(global-set-key (kbd "C-1") 'delete-other-windows)

(global-set-key (kbd "C-M-y") 'secondary-dwim)
(global-set-key (kbd "C-x C-p") 'ffap)
;; (global-set-key (kbd "C-c c") (lambda () (interactive) (other-window 1) (eshell)))

;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

;; Font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Window switching. (C-x o goes to the next window)
(global-set-key (kbd "C-x O") (lambda ()
				(interactive)
				(other-window -1)))

(global-set-key (kbd "C-c o") 'occur)
;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp
		 isearch-string
	       (regexp-quote isearch-string))))))

(require 'fastnav)
(global-set-key (kbd "M-j") 'fastnav-jump-to-char-forward)
(global-set-key (kbd "M-k") 'fastnav-jump-to-char-backward)
(global-set-key (kbd "M-m") 'fastnav-mark-to-char-forward)

(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-c w") (make-repeatable-command 'er/expand-region))

(require 'cofi-func)
(require 'cofi-util)
(defkeymap ray-minor-mode-map
  "f"  'auto-fill-mode
  "h"  'hs-minor-mode
  "p"  'auto-pair-mode
  "w"  'whitespace-mode
  )
(defkeymap ray-quick-map
  "a" 'align-regexp
  "d" 'deft
  "g" 'magit-status
  "s" 'sort-lines
  "e" 'eshell
  "w" 'count-words-region)

(defkeymap ray-insert-map
  "b" 'insert-buffer
  "f" 'insert-file
  )

(defkeymap ray-org-mode-map
  "a" 'org-agenda-list
  "t" (lambda () (interactive) (org-todo-list 0))
  "c" 'org-capture
  "l" 'org-store-link
  )

(fill-keymap 'global
	     ;; files
	     "C-x i" ray-insert-map
	     "C-x m" ray-minor-mode-map
	     "C-c q" ray-quick-map
	     "C-c o" ray-org-mode-map
	     "C-x C-b" 'ibuffer-other-window
	     "C-x f" 'recentf-ido-find-file
	     "C-x M-f" 'ido-find-file-other-window
	     "C-x M-b" 'ido-switch-buffer-other-window
	     "C-x M-d" 'dired-other-window

	     ;; search
	     "C-r"     'isearch-backward-regexp
	     "C-s"     'isearch-forward-regexp
	     "M-r"     'query-replace-regexp
	     "M-R"     'query-replace-regexp

	     ;; home-end
	     "<home>" 'home-end-home
	     "<end>"  'home-end-end
	     )

;;; quick exit for some modes
(add-to-hooks (gen-local-fill-keymap-hook
	       "q" 'quit-window
	       "Q" 'kill-buffer-and-window)
	      '(diff-mode-hook
		compilation-mode-hook))

(require 'helm-config)
(require 'helm-ring)
(global-set-key (kbd "C-c h") 'helm-mini)

(provide 'bindings)
