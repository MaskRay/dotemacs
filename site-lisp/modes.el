;; yasnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippet/snippets")


;; semantic
(require 'cedet)
(require 'semantic)
(mapc (lambda (dir)
 	(semantic-add-system-include dir 'c++-mode)
 	(semantic-add-system-include dir 'c-mode))
      '("/usr/include/gtk-2.0" "/usr/include/gtk-2.0/gtk")
      )


;; hippie-expand
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


;; perl
(defalias 'perl-mode 'cperl-mode)
(autoload 'run-perl "inf-perl" "Start perl interactive shell" t)
(defun my-cperl-mode-common-hook ()
  (cperl-set-style "PerlStyle")
  (setq cperl-electric-paren t)
  (setq cperl-electric-keywords t)
)
(add-hook 'cperl-mode-hook 'my-cperl-mode-common-hook)


;; cc
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

;; doxymacs
(autoload 'doxymacs-mode "doxymacs"
  "Minor mode for using/creating Doxygen documentation." t)
(autoload 'doxymacs-font-lock "doxymacs"
  "Turn on font-lock for Doxygen keywords." t)
(add-hook 'c-mode-common-hook 'doxymacs-mode)

;; cscope
(autoload 'xcscope "xcscope" nil t)
(setq cscope-do-not-update-database t)


;; python
(add-hook 'python-mode-hook '(lambda() (eldoc-mode 1)))


;; lisp
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


;; auctex
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


(provide 'modes)