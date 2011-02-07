(require '.loaddefs)
;; (mapc (lambda (feature) (require feature nil t)) '(dired+ workgroups elscreen window-number paredit bookmark+ autopair cursor-chg color-moccur moccur-edit auto-install second-sel paste2 highlight-symbol w3m-load whole-line-or-region browse-kill-ring+ kill-ring-search menu-bar+ rainbow-delimiters))
(mapc (lambda (feature) (require feature nil t)) '(browse-kill-ring+ paredit paste2 window-number workgroups))
(require 'loaddefs)

(setq wg-prefix-key (kbd "C-l"))
(workgroups-mode 1)

(setq show-paren-style 'parenthesis)
(show-paren-mode 1)

(smex-initialize)

(window-number-meta-mode 1)

(whole-line-or-region-mode 1)

(ido-mode 1)

(autopair-global-mode 1)
(add-hook 'sldb-mode-hook #' (lambda () (setq autopair-dont-activate t)))

;; (global-set-key (kbd "M-=") 'pinbar-add)
;; (pinbar-mode 1)

(toggle-cursor-type-when-idle 1)
(setq curchg-default-cursor-color "green")

(defalias 'occur 'occur-by-moccur)

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


(provide 'plugins)
