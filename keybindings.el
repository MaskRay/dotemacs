(global-set-key (kbd "<C-mouse-4>") (lambda () (interactive) (text-scale-decrease 1)))
(global-set-key (kbd "<C-mouse-5>") (lambda () (interactive) (text-scale-increase 1)))

(global-set-key (kbd "C-c f") 'wy-go-to-char)
(global-set-key (kbd "C-c C-r") 'open-current-file-as-admin)

(global-set-key (kbd "C-c h") 'highlight-symbol-at-point)
(global-set-key (kbd "C-c p") 'highlight-symbol-prev)
(global-set-key (kbd "C-c n") 'highlight-symbol-next)
(global-set-key (kbd "C-c M-r") 'highlight-symbol-remove-all)
(global-set-key (kbd "C-c r") 'highlight-symbol-query-replace)

(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-4") 'kill-this-buffer)
(global-set-key (kbd "C-3") 'split-window-horizontally)
(global-set-key (kbd "C-2") 'split-window-vertically)
(global-set-key (kbd "M-s") 'other-window)
(add-hook 'eshell-mode-hook
	  '(lambda ()
	     (define-key eshell-mode-map (kbd "M-s") 'other-window)))
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)

(global-set-key (kbd "C-M-y") 'secondary-dwim)

(global-set-key (kbd "C-c k") 'kill-ring-search)

(provide 'keybindings)