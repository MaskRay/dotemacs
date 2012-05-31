;; hippie-expand
(setq hippie-expand-try-functions-list '(try-expand-line))
(global-set-key (kbd "M-/") 'hippie-expand)

;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(define-key ac-complete-mode-map "\M-n" 'ac-next)
(define-key ac-complete-mode-map "\M-p" 'ac-previous)
(setq ac-auto-show-menu 0.3)
(setq ac-delay 0.1)
(setq-default ac-auto-start 2)
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
		       (if (not (minibufferp (current-buffer)))
			   (auto-complete-mode 1))
		       ))
(real-global-auto-complete-mode 1)

(provide 'completion)
