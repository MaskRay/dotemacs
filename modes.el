;; eshell
(defun eshell/clear ()
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))


;; yasnippet
(require 'yasnippet)
(yas/initialize)
(setq yas/snippet-dirs (expand-file-name "snippets" dotfiles-dir))
(yas/load-directory yas/snippet-dirs)


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
(defun smart-compile()
  "比较智能的C/C++编译命令
如果当前目录有makefile则用make -k编译，否则，如果是
处于c-mode，就用gcc -Wall编译，如果是c++-mode就用
g++ -Wall编译"
  (interactive)
  ;; 查找 Makefile
  (let ((candidate-make-file-name '("makefile" "Makefile" "GNUmakefile"))
	(command nil))
    (if (not (null
	      (find t candidate-make-file-name :key
		    '(lambda (f) (file-readable-p f)))))
	(setq command "make -k ")
	;; 没有找到 Makefile ，查看当前 mode 是否是已知的可编译的模式
	(if (null (buffer-file-name (current-buffer)))
	    (message "Buffer not attached to a file, won't compile!")
	    (if (eq major-mode 'c-mode)
		(setq command
		      (concat "gcc -Wall -o "
			      (file-name-sans-extension
			       (file-name-nondirectory buffer-file-name))
			      " "
			      (file-name-nondirectory buffer-file-name)
			      " -g -lm "))
	      (if (eq major-mode 'c++-mode)
		  (setq command
			(concat "g++ -Wall -o "
				(file-name-sans-extension
				 (file-name-nondirectory buffer-file-name))
				" "
				(file-name-nondirectory buffer-file-name)
				" -g -lm "))
		(message "Unknow mode, won't compile!")))))
    (if (not (null command))
	(let ((command (read-from-minibuffer "Compile command: " command)))
	  (compile command)))))

(require 'cc-mode)
(defun my-c-mode-common-hook ()
  (c-set-style "k&r")
  (setq tab-width 4 indent-tabs-mode nil c-basic-offset 4)
  (c-toggle-auto-hungry-state 1)
  (c-toggle-auto-state -1)
  (c-toggle-electric-state 1)
  (add-to-list 'c-cleanup-list 'brace-else-brace)
  (add-to-list 'c-cleanup-list 'brace-elseif-brace)
  (add-to-list 'c-cleanup-list 'brace-catch-brace)
  (add-to-list 'c-cleanup-list 'defun-close-semi)
  (add-to-list 'c-cleanup-list 'one-liner-defun)
  (define-key c-mode-base-map [f5] 'smart-compile)
  (define-key c-mode-base-map "\C-m" 'reindent-then-newline-and-indent)
  ;; (define-key c-mode-base-map (kbd "M-/") 'semantic-ia-complete-symbol-menu)
  ;; (define-key c-mode-base-map [f12] 'semantic-ia-fast-jump)
  (global-set-key [S-f12]
		  (lambda ()
		    (interactive)
		    (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
			(error "Semantic Bookmark ring is currently empty"))
		    (let* ((ring (oref semantic-mru-bookmark-ring ring))
			   (alist (semantic-mrub-ring-to-assoc-list ring))
			   (first (cdr (car alist))))
		      (if (semantic-equivalent-tag-p (oref first tag)
						     (semantic-current-tag))
			  (setq first (cdr (car (cdr alist)))))
		      (semantic-mrub-switch-tags first))))

  ;; (semantic-load-enable-code-helpers)
  ;; (semantic-load-enable-semantic-debugging-helpers)
  ;; (define-key semantic-tag-folding-mode-map (kbd "C-c , -") 'semantic-tag-folding-fold-block)
  ;; (define-key semantic-tag-folding-mode-map (kbd "C-c , +") 'semantic-tag-folding-show-block)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; cscope
(autoload 'xcscope "xcscope" nil t)
(setq cscope-do-not-update-database t)


;; python
(add-hook 'python-mode-hook '(lambda() (eldoc-mode 1)))


;; lisp
(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'ee 'eval-expression)
(defalias 'elm 'emacs-lisp-mode)
(defalias 'lim 'lisp-interaction-mode)
(defalias 'eis 'elisp-index-search)
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq scheme-program-name "guile")
;; (require 'slime-autoloads)
;; (add-hook 'lisp-mode-hook (lambda () (slime-setup)))

(defun my-lisp-mode-hook ()
  (setq autopair-dont-activate t)
  (enable-paredit-mode)
  (turn-on-eldoc-mode)
  (eldoc-add-command
   'paredit-backward-delete
   'paredit-close-round)
  (local-set-key "\C-m" 'reindent-then-newline-and-indent)
  )

(add-hook 'lisp-mode-hook 'my-lisp-mode-hook)
(add-hook 'scheme-mode-hook 'my-lisp-mode-hook)
(add-hook 'lisp-interaction-mode-hook 'my-lisp-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-hook)
;; (add-hook 'slime-mode 'my-lisp-mode-hook)


(defun esk-remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
	    (lambda ()
	      (if (file-exists-p (concat buffer-file-name "c"))
		  (delete-file (concat buffer-file-name "c"))))))

(add-hook 'emacs-lisp-mode-hook 'esk-remove-elc-on-save)


;; ediff
(setq ediff-split-window-function 'split-window-horizontally)


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


(add-hook 'after-save-hook
	  'executable-make-buffer-file-executable-if-script-p)


(provide 'modes)
