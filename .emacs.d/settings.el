(defun frame-setting ()
  (blink-cursor-mode -1)
  (mouse-avoidance-mode 'animate)
  (global-linum-mode 1)
  (column-number-mode 1)
  (global-font-lock-mode t)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (show-paren-mode 1)
  (scroll-bar-mode -1)
  (auto-image-file-mode 1)
  (require 'fonts)
  (window-system-font-setting)
  )
(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions
	      (lambda (frame)
		(with-selected-frame frame
		  (frame-setting))))
  (frame-setting)) 

(defalias 'yes-or-no-p 'y-or-n-p)
(setq user-full-name "MaskRay"
      user-mail-address "emacsray@gmail.com"
      next-screen-context-lines 5
      enable-recursive-minibuffers t
      scroll-margin 0
      x-select-enable-clipboard t
      x-select-enable-primary nil
      system-time-locale "C"
      default-input-method "TeX"
      inhibit-startup-screen t
      initial-scratch-message ""
      ring-bell-function 'ignore
      backup-directory-alist '(("" . "/var/tmp"))
      buffer-file-coding-system 'utf-8
      )
(setq-default major-mode 'text-mode
	      kill-whole-line t
	      truncate-partial-width-windows 15)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-selection-face ((t (:background "blue" :foreground "white")))))


(require 'color-theme)
(require 'color-theme-zenburn)
(color-theme-initialize)
(setq zenburn-bg "#000000")
(color-theme-zenburn)

(when (not (setq browse-url-generic-program (executable-find "firefox3")))
  (setq browse-url-generic-program (executable-find "firefox"))
  )
(setq browse-url-browser-function 'browse-url-generic)


(provide 'settings)
