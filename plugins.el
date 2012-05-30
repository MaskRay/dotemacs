;; (mapc (lambda (feature) (require feature nil t)) '(dired+ workgroups elscreen window-number paredit bookmark+ autopair cursor-chg color-moccur moccur-edit auto-install second-sel paste2 highlight-symbol w3m-load whole-line-or-region browse-kill-ring+ kill-ring-search menu-bar+ rainbow-delimiters))
(mapc (lambda (feature) (require feature nil t)) '(paredit))

(when (require 'deft nil 'noerror) 
  (setq
    deft-extension "org"
    deft-directory "~/org/deft/"
    deft-text-mode 'org-mode)
   )

(require 'full-ack nil 'noerror)
(require 'bookmark+ nil 'noerror)
(require 'dired+-autoloads nil 'noerror)
(require 'expand-region nil 'noerror)

(setq show-paren-style 'parenthesis)
(show-paren-mode 1)


(when (require 'smex nil 'noerror)
  (smex-initialize))

(when (require 'window-number nil 'noerror)
  (window-number-meta-mode 1))

(when (require 'whole-line-or-region nil 'noerror)
 (whole-line-or-region-mode 1))

(icomplete-mode 1)
(ido-mode 1)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10
      ido-default-file-method 'selected-window)

(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(autoload 'imaxima "imaxima" "Image support for Maxima." t)
(autoload 'maxima "maxima" "Maxima interactive" t)
(setq imaxima-fnt-size "huge")
(setq imaxima-max-scale 0.75)
(setq imaxima-pt-size 12)


(setq w3m-default-display-inline-images t)


(defalias 'list-buffers 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
	       ("emacs" (or
			 (name . "^\\*scratch\\*$")
			 (name . "^\\*Messages\\*$")))
	       ))))


(setq gdb-many-windows t)
(gud-tooltip-mode 1)


(setq dired-dwim-target t)
(setq dired-recursive-copies 'always)
(setq dired-isearch-filenames t)
(setq dired-recursive-deletes 'top)
(add-hook 'dired-mode-hook
	  (lambda ()
	    (define-key dired-mode-map (kbd "^")
	      (lambda () (interactive) (find-alternate-file "..")))
					; was dired-up-directory
	    ))


(setq bm-restore-repository-on-load t)
(when (require 'bm nil 'noerror)
  (setq-default bm-buffer-persistence t)
  (setq bm-cycle-all-buffers t)
  (setq bm-highlight-style
	(if (and window-system (> emacs-major-version 21))
	    'bm-highlight-only-fringe
	  'bm-highlight-only-line))
  ;; (add-hook' after-init-hook 'bm-repository-load)
  (add-hook 'find-file-hooks 'bm-buffer-restore)
  (add-hook 'kill-buffer-hook 'bm-buffer-save)
  (add-hook 'kill-emacs-hook '(lambda nil
				(bm-buffer-save-all)
				(bm-repository-save)))
  ;; (add-hook 'after-save-hook 'bm-buffer-save)
  ;; (add-hook 'after-revert-hook 'bm-buffer-restore)
  (global-set-key (kbd "<C-f2>") 'bm-toggle)
  (global-set-key [M-f2] 'bm-toggle)
  (global-set-key (kbd "ESC <f2>") 'bm-toggle) ; putty
  (global-set-key (kbd "<f2>")   'bm-next)
  (global-set-key (kbd "<S-f2>") 'bm-previous)
  (global-set-key (kbd "<C-S-f2>") 'bm-remove-all-current-buffer)
  (global-set-key [left-margin mouse-1] 'bm-toggle-mouse)
  (global-set-key [left-margin mouse-3] 'bm-next-mouse)
  )

(provide 'plugins)
