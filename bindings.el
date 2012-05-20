(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-set-key (kbd "<C-mouse-4>") (lambda () (interactive) (text-scale-decrease 1)))
(global-set-key (kbd "<C-mouse-5>") (lambda () (interactive) (text-scale-increase 1)))

(global-set-key (kbd "C-c f") 'wy-go-to-char)
(global-set-key (kbd "C-c C-r") 'open-current-file-as-admin)

(global-set-key (kbd "C-c N") 'highlight-symbol-prev)
(global-set-key (kbd "C-c n") 'highlight-symbol-next)
(global-set-key (kbd "C-c r") 'highlight-symbol-query-replace)

(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x K") 'kill-buffer)
(global-set-key (kbd "C-4") 'kill-this-buffer)
(global-set-key (kbd "C-3") 'split-window-horizontally)
(global-set-key (kbd "C-2") 'split-window-vertically)

(global-set-key (kbd "C-M-y") 'secondary-dwim)
(global-set-key (kbd "C-c k") 'kill-ring-search)
(global-set-key (kbd "C-x C-p") 'ffap)
;; (global-set-key (kbd "C-c c") (lambda () (interactive) (other-window 1) (eshell)))
(global-set-key (kbd "C-c c") 'multi-term-dedicated-toggle)

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

(global-set-key (kbd "C-c n") 'prelude-cleanup-buffer)
(global-set-key (kbd "C-c f")  'prelude-recentf-ido-find-file)
(global-set-key (kbd "C-c i") 'prelude-ido-goto-symbol)
(global-set-key (kbd "C-M-\\") 'prelude-indent-region-or-buffer)
(global-set-key (kbd "C-c u") 'prelude-view-url)
(global-set-key (kbd "C-c e") 'prelude-eval-and-replace)
(global-set-key (kbd "C-c s") 'prelude-swap-windows)
(global-set-key (kbd "C-c d") 'prelude-duplicate-current-line-or-region)
(global-set-key (kbd "C-c r") 'prelude-rename-file-and-buffer)
(global-set-key (kbd "C-c t") 'prelude-visit-term-buffer)


(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)

(provide 'bindings)
