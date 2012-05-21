;; (require '.loaddefs nil t)
;; (mapc (lambda (feature) (require feature nil t)) '(dired+ workgroups elscreen window-number paredit bookmark+ autopair cursor-chg color-moccur moccur-edit auto-install second-sel paste2 highlight-symbol w3m-load whole-line-or-region browse-kill-ring+ kill-ring-search menu-bar+ rainbow-delimiters))
(mapc (lambda (feature) (require feature nil t)) '(paredit))
;; (require 'loaddefs nil t)

(require 'expand-region nil 'noerror)

(when (require 'drag-stuff nil 'noerror)
  (drag-stuff-global-mode 1))

(require 'multi-term)
(setq multi-term-program "/bin/zsh")

(when (require 'workgroups nil 'noerror)
  (setq wg-prefix-key (kbd "C-l")
	wg-morph-on nil)
  (workgroups-mode 1)
  (setq wg-file (expand-file-name "workgroups" dotfiles-dir)))

(setq show-paren-style 'parenthesis)
(show-paren-mode 1)

(setq highlight-symbol-idle-delay 0.5)

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

(when (require 'autopair nil 'noerror)
  ;; (autopair-global-mode 1)
  (add-hook 'sldb-mode-hook #' (lambda () (setq autopair-dont-activate t))))

;; (when (require 'cursor-chg nil 'noerror)
;;   (toggle-cursor-type-when-idle 1)
;;   (setq curchg-default-cursor-color "green")
;;   (change-cursor-mode 1))

(when (require 'color-moccur nil 'noerror)
  (defalias 'occur 'occur-by-moccur))

(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(autoload 'imaxima "imaxima" "Image support for Maxima." t)
(autoload 'maxima "maxima" "Maxima interactive" t)
(setq imaxima-fnt-size "huge")
(setq imaxima-max-scale 0.75)
(setq imaxima-pt-size 12)


(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
(if (boundp 'read-mail-command)
    (setq read-mail-command 'mew))
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
       'mew-user-agent
       'mew-user-agent-compose
       'mew-draft-send-message
       'mew-draft-kill
       'mew-send-hook))


(setq w3m-default-display-inline-images t)


(defalias 'list-buffers 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
	       ("perl" (mode . cperl-mode))
	       ("erc" (mode . erc-mode))
	       ("planner" (or
			   (name . "^\\*Calendar\\*$")
			   (name . "^diary$")
			   (mode . muse-mode)))
	       ("emacs" (or
			 (name . "^\\*scratch\\*$")
			 (name . "^\\*Messages\\*$")))
	       ("gnus" (or
			(mode . message-mode)
			(mode . bbdb-mode)
			(mode . mail-mode)
			(mode . gnus-group-mode)
			(mode . gnus-summary-mode)
			(mode . gnus-article-mode)
			(name . "^\\.bbdb$")
			(name . "^\\.newsrc-dribble")))))))
(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))


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


(setq term-unbind-key-list '("C-x" "C-l" "<ESC>"))

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
