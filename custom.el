(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-selection-face ((t (:background "blue" :foreground "white"))))
 '(diredp-dir-priv ((t (:foreground "DarkSeaGreen2"))) t)
 '(diredp-exec-priv ((t nil)) t)
 '(diredp-file-name ((t (:foreground "White"))) t)
 '(diredp-file-suffix ((t (:foreground "Magenta"))) t)
 '(diredp-flag-mark-line ((t (:background "#5f5f5f"))) t)
 '(diredp-ignored-file-name ((t (:foreground "Chocolate3"))) t)
 '(diredp-no-priv ((t nil)) t)
 '(diredp-number ((t (:foreground "LightBlue"))) t)
 '(diredp-other-priv ((t nil)) t)
 '(diredp-rare-priv ((t (:foreground "Orchid"))) t)
 '(diredp-read-priv ((t nil)) t)
 '(diredp-write-priv ((t nil)) t))

(put 'dired-find-alternate-file 'disabled nil)
(put 'set-goal-column 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-semantic-decoration-mode t nil (semantic-decorate-mode))
 '(global-semantic-highlight-edits-mode nil nil (semantic-util-modes))
 '(global-semantic-highlight-func-mode nil nil (semantic-util-modes))
 '(global-semantic-idle-scheduler-mode t nil (semantic-idle))
 '(global-semantic-mru-bookmark-mode t nil (semantic-util-modes))
 '(global-semantic-show-parser-state-mode t nil (semantic-util-modes))
 '(global-semantic-show-unmatched-syntax-mode nil nil (semantic-util-modes))
 '(global-semantic-stickyfunc-mode nil nil (semantic-util-modes))
 '(global-senator-minor-mode t nil (senator))
 '(safe-local-variable-values (quote ((eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook" (add-hook (quote write-contents-functions) (lambda nil (delete-trailing-whitespace) nil)) (require (quote whitespace)) "Sometimes the mode needs to be toggled off and on." (whitespace-mode 0) (whitespace-mode 1)) (whitespace-line-column . 80) (whitespace-style face trailing lines-tail) (require-final-newline . t))))
 '(semanticdb-global-mode t nil (semanticdb))
 '(which-function-mode nil))
