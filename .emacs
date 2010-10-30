(progn (cd "~/.emacs.d") (normal-top-level-add-subdirs-to-load-path) (cd "~"))
(add-to-list 'load-path "~/.emacs.d")
(server-start)
(prefer-coding-system 'utf-8)

(when (not (eq (window-system) nil))
  (defun en-zh-font-existsp (font)  
    (if (null (x-list-fonts font))  
	nil t))
  (defvar font-list '("文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
  (require 'cl) ;; find-if is in common list package
  (find-if #'en-zh-font-existsp font-list)
  (defun en-zh-make-font-string (font-name font-size)
    (if (and (stringp font-size)
	     (equal ":" (string (elt font-size 0))))
	(format "%s%s" font-name font-size)
      (format "%s %s" font-name font-size)))
  (defun en-zh-set-font (english-fonts
			 english-font-size
			 chinese-fonts
			 &optional chinese-font-size)
    "english-font-size could be set to a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
    (require 'cl)                         ; for find if
    (let ((en-font (en-zh-make-font-string
		    (find-if #'en-zh-font-existsp english-fonts)
		    english-font-size))
	  (zh-font (font-spec :family (find-if #'en-zh-font-existsp chinese-fonts)
			      :size chinese-font-size)))
      ;; Set the default English font
      ;;
      ;; The following 2 method cannot make the font settig work in new frames.
      ;; (set-default-font "Consolas:pixelsize=16")
      ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=16"))
      ;; We have to use set-face-attribute
      (message "Set English Font to %s" en-font)
      (set-face-attribute 'default nil :font en-font)

      ;; Set Chinese font
      ;; Do not use 'unicode charset, it will cause the english font setting invalid
      (message "Set Chinese Font to %s" zh-font)
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
	(set-fontset-font (frame-parameter nil 'font)
			  charset
			  zh-font))))
  (en-zh-set-font
   '("Envy Code R VS" "Consolas" "DejaVu Sans Mono" "Monospace" "Courier New") ":pixelsize=22"
   '("DejaVu Sans YuanTi Mono" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
  (global-set-key (kbd "<C-mouse-4>") (lambda () (interactive) (text-scale-decrease 1)))
  (global-set-key (kbd "<C-mouse-5>") (lambda () (interactive) (text-scale-increase 1)))

  )

;;;; safe-load
(defvar safe-load-error-list ""
  "*List of files that reported errors when loaded via safe-load")
(defun safe-load (file &optional noerror nomessage nosuffix)
  "Load a file.  If error when loading, report back, wait for
   a key stroke then continue on"
  (interactive "f")
  (condition-case nil (load file noerror nomessage nosuffix)
    (error
     (progn
       (setq safe-load-error-list  (concat safe-load-error-list  " " file))
       (message "****** [Return to continue] Error loading %s" safe-load-error-list )
       (sleep-for 1)
       nil))))

;;;; goto-char
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
(define-key global-map (kbd "C-c f") 'wy-go-to-char)


(require 'ido) (ido-mode 1)
(require 'bookmark+)
(show-paren-mode 1) (setq show-paren-style 'parenthesis)
(require 'autopair) (autopair-global-mode 1) (add-hook 'sldb-mode-hook #' (lambda () (setq autopair-dont-activate t)))
(require 'pinbar) (global-set-key (kbd "M-=") 'pinbar-add) (pinbar-mode 1)
(setq elscreen-prefix-key (kbd "C-l")) (require 'elscreen)
(require 'cursor-chg) (change-cursor-mode 1) (toggle-cursor-type-when-idle 1) (setq curchg-default-cursor-color "white")
(require 'color-moccur) (require 'moccur-edit) (defalias 'occur 'occur-by-moccur)
(require 'lazy-search) (define-key isearch-mode-map (kbd "M-l") 'isearch-to-lazy-search)
(require 'auto-install) (setq auto-install-directory "~/.emacs.d/")
(require 'follow-mouse) (turn-on-follow-mouse)
(require 'one-key) (require 'one-key-default) (one-key-default-setup-keys)

;;;; highlight-parentheses
(require 'highlight-parentheses)
(define-globalized-minor-mode real-global-highlight-parentheses-mode
  highlight-parentheses-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
			   (highlight-parentheses-mode 1))
                       ))
(real-global-highlight-parentheses-mode 1)

;;;; highlight-symbol
(require 'highlight-symbol)
(global-set-key (kbd "C-c h") 'highlight-symbol-at-point)
(global-set-key (kbd "C-c p") 'highlight-symbol-prev)
(global-set-key (kbd "C-c n") 'highlight-symbol-next)
(global-set-key (kbd "C-c M-r") 'highlight-symbol-remove-all)
(global-set-key (kbd "C-c r") 'highlight-symbol-query-replace)

;;;; miscellaneous
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

(defun open-current-file-as-admin ()
  "Open the current buffer as unix root.
This command works on unixes only."
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
           buffer-file-name))))
(global-set-key (kbd "C-c C-r") 'open-current-file-as-admin)

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))
(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)))
(defun scroll-down-half ()         
  (interactive)                    
  (scroll-down (window-half-height)))
(global-set-key (kbd "M-n") 'scroll-up-half)
(global-set-key (kbd "M-p") 'scroll-down-half)

;;;; key bindings
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-4") 'kill-this-buffer)
(global-set-key (kbd "C-3") 'split-window-horizontally)
(global-set-key (kbd "C-2") 'split-window-vertically)
(global-set-key (kbd "C-1") 'delete-other-windows)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-s") 'other-window)
(add-hook 'eshell-mode-hook
	  '(lambda ()
	     (define-key eshell-mode-map (kbd "M-s") 'other-window)))
(global-set-key (kbd "M-`") 'ido-switch-buffer)

(setq-default kill-whole-line t)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)

(require 'whole-line-or-region)
(whole-line-or-region-mode 1)



;;;; hippie-expand
(setq hippie-expand-try-functions-list '(try-expand-line))
(global-set-key (kbd "M-/") 'hippie-expand)

;;;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(define-key ac-complete-mode-map "\M-n" 'ac-next)
(define-key ac-complete-mode-map "\M-p" 'ac-previous)
(setq ac-auto-show-menu 0.3)
(setq ac-delay 0.1)
(setq ac-quick-help-delay 0.3)
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
			   (auto-complete-mode 1))
                       ))
(real-global-auto-complete-mode 1)

;;;; semantic
(require 'cedet)
(require 'semantic)
(mapc (lambda (dir)
 	(semantic-add-system-include dir 'c++-mode)
 	(semantic-add-system-include dir 'c-mode))
      '("/usr/include/gtk-2.0" "/usr/include/gtk-2.0/gtk")
      )

;;;; gccsense
;; (require 'gccsense)

;;;; yasnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippet/snippets")



;;;; erc
(safe-load "~/.ercrc.el")
(require 'paste2)

;;;; jabber
(autoload 'jabber-connect "jabber"
  "connect to the jabber server and start a jabber xml stream" t)
(safe-load "~/.jabber.el")

;;;; twittering-mode
(autoload 'twittering-mode "twittering-mode" nil t)
(safe-load "~/.twitter.el")

;;;; newsticker
(safe-load "~/.newsticker.el")

;;;; org
(setq org-agenda-files '("~/org/home.org" "~/org/work.org"))
(global-set-key (kbd "C-c m r") 'org-remember)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(require 'remember)
(setq org-default-notes-file "~/org/todo.org")
(org-remember-insinuate)
(setq org-remember-templates (quote (("todo" ?t "* TODO %?\nCREATED: %U" nil nil nil))))

;;;; ispell
(setq ispell-local-dictionary "american")

;;;; sdcv
(require 'sdcv-mode)
(global-set-key (kbd "C-c d") 'sdcv-search)

;;;; dired
;(require 'dired+)
(setq dired-dwim-target t)
(setq dired-recursive-copies 'always)
(setq dired-isearch-filenames t)
(setq dired-recursive-deletes 'top)
(add-hook 'dired-mode-hook
	  (lambda ()
	    (define-key dired-mode-map (kbd "<return>")
	      'dired-find-alternate-file) ; was dired-advertised-find-file
	    (define-key dired-mode-map (kbd "^")
	      (lambda () (interactive) (find-alternate-file "..")))
					; was dired-up-directory
	    ))
; C-j open the directory of current buffer
(global-set-key (kbd "C-c C-j")
                (lambda ()
                  (interactive)
                  (if (buffer-file-name)
                      (dired default-directory))))

;;;; auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook
	  (lambda()
	    (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
	    (setq TeX-command-default "XeLaTeX")
	    (setq TeX-save-query nil)
	    (setq TeX-show-compilation t)
	    ))
(add-hook 'LaTeX-mode-hook 'flyspell-mode)

;;;; gud
(setq gdb-many-windows t)
(gud-tooltip-mode 1)

;;;; ibuffer
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

;;;; w3m
(require 'w3m-load)
(setq w3m-default-display-inline-images t)

;;;; mew
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

;;;; imaxima
(autoload 'imaxima "imaxima" "Image support for Maxima." t)
(autoload 'maxima "maxima" "Maxima interactive" t)
(setq imaxima-fnt-size "huge")
(setq imaxima-max-scale 0.75)
(setq imaxima-pt-size 12)

;;;; doxymacs
(autoload 'doxymacs-mode "doxymacs"
  "Minor mode for using/creating Doxygen documentation." t)
(autoload 'doxymacs-font-lock "doxymacs"
  "Turn on font-lock for Doxygen keywords." t)
(add-hook 'c-mode-common-hook 'doxymacs-mode)

;;;; lisp
(add-hook 'lisp-interaction-mode-hook '(lambda () (eldoc-mode 1) (auto-complete-mode 1)))
(add-hook 'emacs-lisp-mode-hook '(lambda () (eldoc-mode 1) (auto-complete-mode 1)))
(add-hook 'slime-mode '(lambda() (eldoc-mode 1) (auto-complete-mode 1)))
(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'ee 'eval-expression)
(defalias 'elm 'emacs-lisp-mode)
(defalias 'lim 'lisp-interaction-mode)
(defalias 'eis 'elisp-index-search)
(setq inferior-lisp-program "/usr/bin/sbcl")
(require 'slime-autoloads)
(slime-setup)

;;;; python
(add-hook 'python-mode-hook '(lambda() (eldoc-mode 1)))
;; (ac-ropemacs-initialize)
;; (pymacs-load "ropemacs" "rope-")
;; (add-hook 'python-mode-hook
;; 	  '(lambda ()
;; 	     (add-to-list 'ac-sources 'ac-source-ropemacs)))

;;;; perl
(defalias 'perl-mode 'cperl-mode)
(autoload 'run-perl "inf-perl" "Start perl interactive shell" t)
(defun my-cperl-mode-common-hook ()
  (cperl-set-style "PerlStyle")
  ;; (setq cperl-auto-newline t)
  (setq cperl-electric-paren t)
  (setq cperl-electric-keywords t)
)
(add-hook 'cperl-mode-hook 'my-cperl-mode-common-hook)

;;;; cc
(defun my-c-mode-common-hook ()
  (c-set-style "k&r")
  (setq tab-width 4 indent-tabs-mode nil c-basic-offset 4)
  (c-toggle-auto-hungry-state 1)
  (c-toggle-electric-state -1)
  (add-to-list 'c-cleanup-list 'brace-else-brace)
  (add-to-list 'c-cleanup-list 'brace-elseif-brace)
  (add-to-list 'c-cleanup-list 'brace-catch-brace)
  (add-to-list 'c-cleanup-list 'defun-close-semi)
  (add-to-list 'c-cleanup-list 'one-liner-defun)
  (define-key c-mode-base-map [f5] 'compile)
  (define-key c-mode-base-map "\C-m" 'c-context-line-break)
  (define-key c-mode-base-map (kbd "M-/") 'semantic-ia-complete-symbol-menu)
  (define-key c-mode-base-map [f12] 'semantic-ia-fast-jump)

  (semantic-load-enable-code-helpers)
  (semantic-load-enable-semantic-debugging-helpers)
  (add-to-list 'ac-omni-completion-sources
	       (cons "\\." '(ac-source-semantic)))
  (add-to-list 'ac-omni-completion-sources
	       (cons "->" '(ac-source-semantic)))
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;;; cscope
(autoload 'xcscope "xcscope" nil t)
(setq cscope-do-not-update-database t)

;;;; color-theme (ir-black)
(require 'color-theme)
(color-theme-initialize)

;; IR_Black Color Theme for Emacs.
;;
;; David Zhou
;;
;; The IR_Black theme is originally from:
;;
;; http://blog.infinitered.com/entries/show/8
;;
;; This theme needs color-theme.
;;
;; To use, put this in your init files:
;;
;; (require 'color-theme)
;; (color-theme-initialize)
;; (load-file "path/to/color-theme-irblack.el")
;; (color-theme-irblack)


(defun color-theme-irblack ()
(interactive)
(color-theme-install
'(color-theme-irblack
((background-color . "#000000")
(background-mode . dark)
(border-color . "#454545")
(cursor-color . "#888888")
(foreground-color . "#F6F3E8")
(mouse-color . "#660000"))
(default ((t (:background "#000000" :foreground "#F6F3E8"))))
(vertical-border ((t (:background "#666666"))))
(blue ((t (:foreground "blue"))))
(border-glyph ((t (nil))))
(buffers-tab ((t (:background "#141414" :foreground "#CACACA"))))
(font-lock-comment-face ((t (:foreground "#7C7C7C"))))
(font-lock-constant-face ((t (:foreground "#99CC99"))))
(font-lock-doc-string-face ((t (:foreground "#A8FF60"))))
(font-lock-function-name-face ((t (:foreground "#FFD2A7"))))
(font-lock-builtin-face ((t (:foreground "#96CBFE"))))
(font-lock-keyword-face ((t (:foreground "#96CBFE"))))
(font-lock-preprocessor-face ((t (:foreground "#96CBFE"))))
(font-lock-reference-face ((t (:foreground "#C6C5FE"))))

(font-lock-regexp-grouping-backslash ((t (:foreground "#E9C062"))))
(font-lock-regexp-grouping-construct ((t (:foreground "red"))))

(linum ((t (:background "#000000" :foreground "#666666"))))

(minibuffer-prompt ((t (:foreground "#888888"))))
(ido-subdir ((t (:foreground "#CF6A4C"))))
(ido-first-match ((t (:foreground "#8F9D6A"))))
(ido-only-match ((t (:foreground "#8F9D6A"))))
(mumamo-background-chunk-submode ((t (:background "#222222"))))

(font-lock-string-face ((t (:foreground "#A8FF60"))))
(font-lock-type-face ((t (:foreground "#FFFFB6"))))
(font-lock-variable-name-face ((t (:foreground "#C6C5FE"))))
(font-lock-warning-face ((t (:background "#CC1503" :foreground "#FFFFFF"))))
(gui-element ((t (:background "#D4D0C8" :foreground "black"))))
(region ((t (:background "#660000"))))
(mode-line ((t (:background "grey75" :foreground "black"))))
(highlight ((t (:background "#111111"))))
(highline-face ((t (:background "SeaGreen"))))
(left-margin ((t (nil))))
(text-cursor ((t (:background "yellow" :foreground "black"))))
(toolbar ((t (nil))))
(show-paren-mismatch ((t (:background "#FF1100"))))
(underline ((nil (:underline nil))))

;; mumamo
(mumamo-background-chunk-major ((t (:background "#000000"))))
(mumamo-background-chunk-submode1 ((t (:background "#0A0A0A"))))
(mumamo-background-chunk-submode2 ((t (:background "#0A0A0A"))))
(mumamo-background-chunk-submode3 ((t (:background "#0A0A0A"))))
(mumamo-background-chunk-submode4 ((t (:background "#0A0A0A"))))

;; diff-mode
(diff-added ((t (:background "#253B22" :foreground "#F8F8F8"))))
(diff-removed ((t (:background "#420E09" :foreground "#F8F8F8"))))
(diff-content ((t nil)))
(diff-header ((t (:background "#0E2231" :foreground "#F8F8F8"))))


;; nxml
(nxml-delimiter ((t (:foreground "#96CBFE"))))
(nxml-name ((t (:foreground "#96CBFE"))))
(nxml-element-local-name ((t (:foreground "#96CBFE"))))
(nxml-attribute-local-name ((t (:foreground "#FFD7B1"))))

)))

(color-theme-irblack)
(put 'scroll-left 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default-buffer-file-coding-system 'utf-8)
 '(system-time-locale "C")
 '(scroll-margin 5)
 '(backup-directory-alist '(("" . "/var/tmp/")))
 '(default-directory "~")
 '(ring-bell-function 'ignore)
 '(enable-recursive-minibuffers t)
 '(default-major-mode 'text-mode)
 '(inhibit-startup-message t)
 '(initial-scratch-message "")
 '(x-select-enable-clipboard t)
 '(x-select-enable-primary nil)
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ac-selection-face ((t (:background "blue" :foreground "white")))))
