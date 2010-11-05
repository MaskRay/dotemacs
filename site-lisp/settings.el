(setq-default truncate-partial-width-windows 15)
(recentf-mode 1)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-linum-mode 1)
(column-number-mode 1)
(blink-cursor-mode -1)
(mouse-avoidance-mode 'animate)
(global-font-lock-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(auto-image-file-mode 1)

(setq major-mode 'text-mode
      enable-recursive-minibuffers t
      scroll-margin 5
      x-select-enable-clipboard t
      x-select-enable-primary nil
      system-time-locale "C"
      inhibit-startup-screen t
      initial-scratch-message ""
      ring-bell-function 'ignore
      backup-directory-alist '(("" . "/var/tmp"))
      buffer-file-coding-system 'utf-8
      )

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ac-selection-face ((t (:background "blue" :foreground "white")))))


(provide 'settings)
