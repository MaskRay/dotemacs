(require 'undo-tree)
(require 'evil)
(require 'evil-numbers)
(setq evil-find-skip-newlines t
      evil-move-cursor-back nil
      evil-cross-lines t)
(setq evil-previous-state-alist '())
(setq evil-default-cursor #'cofi/evil-cursor)
(setq evil-leader/leader ","
      evil-leader/in-all-states t)
(require 'cofi-util)
(require 'cofi-func)

(setq evil-normal-state-tag (propertize "n" 'face '((:background "green" :foreground "black")))
      evil-emacs-state-tag (propertize "e" 'face '((:background "orange" :foreground "black")))
      evil-insert-state-tag (propertize "i" 'face '((:background "red")))
      evil-motion-state-tag (propertize "m" 'face '((:background "blue")))
      evil-operator-state-tag (propertize "o" 'face '((:background "purple"))))

;;; evil-surround
(require 'surround)
(setq-default surround-pairs-alist '((?\( . ("(" . ")"))
				     (?\[ . ("[" . "]"))
				     (?\{ . ("{" . "}"))

				     (?\) . ("( " . " )"))
				     (?\] . ("[ " . " ]"))
				     (?\} . ("{ " . " }"))
				     (?> . ("< " . " >"))

				     (?# . ("#{" . "}"))
				     (?p . ("(" . ")"))
				     (?b . ("[" . "]"))
				     (?B . ("{" . "}"))
				     (?< . ("<" . ">"))
				     (?t . surround-read-tag)))

(defun cofi/surround-add-pair (trigger begin-or-fun &optional end)
  "Add a surround pair.
If `end' is nil `begin-or-fun' will be treated as a fun."
  (push (cons (if (stringp trigger)
		  (string-to-char trigger)
		trigger)
	      (if end
		  (cons begin-or-fun end)
		begin-or-fun))
	surround-pairs-alist))

(global-surround-mode 1)
(add-to-hooks (lambda ()
		(cofi/surround-add-pair "`" "`" "'"))
	      '(emacs-lisp-mode-hook lisp-mode-hook))
(add-to-hooks (lambda ()
		(cofi/surround-add-pair "~" "``" "``"))
	      '(markdown-mode-hook rst-mode-hook python-mode-hook))
(add-hook 'latex-mode (lambda ()
			(cofi/surround-add-pair "~" "\\texttt{" "}")
			(cofi/surround-add-pair "=" "\\verb=" "}")
			(cofi/surround-add-pair "/" "\\emph=" "}")))
(add-to-hooks (lambda ()
		(cofi/surround-add-pair "c" ":class:`" "`")
		(cofi/surround-add-pair "f" ":func:`" "`")
		(cofi/surround-add-pair "m" ":meth:`" "`")
		(cofi/surround-add-pair "a" ":attr:`" "`")
		(cofi/surround-add-pair "e" ":exc:`" "`"))
	      '(rst-mode-hook python-mode-hook))

(evil-set-toggle-key "<pause>")
(evil-mode 1)

(loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
			      (pylookup-mode . emacs)
			      (comint-mode . emacs)
			      (shell-mode . emacs)
			      (term-mode . emacs)
			      (bc-menu-mode . emacs)
			      (magit-branch-manager-mode-map . emacs)
			      (rdictcc-buffer-mode . emacs))
      do (evil-set-initial-state mode state))

(require 'ace-jump-mode)
(fill-keymap evil-normal-state-map
	     "Y" (kbd "y$")
	     "+" 'evil-numbers/inc-at-pt
	     "-" 'evil-numbers/dec-at-pt
	     "SPC" 'ace-jump-char-mode
	     "S-SPC" 'ace-jump-word-mode
	     "C-SPC" 'ace-jump-line-mode
	     "C-z"   'evil-emacs-state
	     )

(defun cofi/surround-add-pair (trigger begin-or-fun &optional end)
  "Add a surround pair.
If `end' is nil `begin-or-fun' will be treated as a fun."
  (push (cons (if (stringp trigger)
		  (string-to-char trigger)
		trigger)
	      (if end
		  (cons begin-or-fun end)
		begin-or-fun))
	surround-pairs-alist))

(global-surround-mode 1)
(add-to-hooks (lambda ()
		(cofi/surround-add-pair "`" "`" "'"))
	      '(emacs-lisp-mode-hook lisp-mode-hook))
(add-to-hooks (lambda ()
		(cofi/surround-add-pair "~" "``" "``"))
	      '(markdown-mode-hook rst-mode-hook python-mode-hook))
(add-hook 'latex-mode (lambda ()
			(cofi/surround-add-pair "~" "\\texttt{" "}")
			(cofi/surround-add-pair "=" "\\verb=" "}")
			(cofi/surround-add-pair "/" "\\emph=" "}")))
(add-to-hooks (lambda ()
		(cofi/surround-add-pair "c" ":class:`" "`")
		(cofi/surround-add-pair "f" ":func:`" "`")
		(cofi/surround-add-pair "m" ":meth:`" "`")
		(cofi/surround-add-pair "a" ":attr:`" "`")
		(cofi/surround-add-pair "e" ":exc:`" "`"))
	      '(rst-mode-hook python-mode-hook))

(evil-set-toggle-key "<pause>")
(evil-mode 1)

(loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
			      (pylookup-mode . emacs)
			      (comint-mode . emacs)
			      (shell-mode . emacs)
			      (term-mode . emacs)
			      (bc-menu-mode . emacs)
			      (magit-branch-manager-mode-map . emacs)
			      (rdictcc-buffer-mode . emacs))
      do (evil-set-initial-state mode state))

(require 'ace-jump-mode)
(fill-keymap evil-normal-state-map
	     "+" 'evil-numbers/inc-at-pt
	     "-" 'evil-numbers/dec-at-pt
	     "SPC" 'ace-jump-char-mode
	     "S-SPC" 'ace-jump-word-mode
	     "C-SPC" 'ace-jump-line-mode
	     "C-z"   'evil-emacs-state
	     "C-n"   (lambda () (interactive) (evil-next-buffer))
	     "C-p"   (lambda () (interactive) (evil-prev-buffer))
	     )

(fill-keymap evil-motion-state-map
	     "L" 'end-of-line
	     "H" 'evil-first-non-blank)

(fill-keymap evil-insert-state-map
	     "TAB" 'yas/expand
	     ;; "C-h" 'backward-delete-char
	     "C-y" 'yank
	     "C-z" 'evil-emacs-state
	     "C-a" 'evil-first-non-blank
	     "C-e" 'end-of-line)

(fill-keymap evil-emacs-state-map
	     "C-["   'evil-normal-state
	     "C-z"   'evil-normal-state
	     )

(fill-keymap evil-operator-state-map
	     ;; works like `t'
	     "SPC" 'ace-jump-char-mode
	     ;; works like `f'
	     "C-SPC" 'cofi/ace-jump-char-direct-mode
	     "S-SPC" 'ace-jump-word-mode)

(evil-define-key 'normal org-mode-map
  (kbd "RET") 'org-open-at-point
  "o" (lambda ()
	(interactive)
	(end-of-line)
	(if (not (org-in-item-p))
	    (insert "\n- ")
	  (org-insert-item))
	(evil-append nil)
	)
  "O" (lambda ()
	(interactive)
	(end-of-line)
	(org-insert-heading)
	(evil-append nil)
	)
  "za" 'org-cycle
  "zA" 'org-shifttab
  "zm" 'hide-body
  "zr" 'show-all
  "zo" 'show-subtree
  "zO" 'show-all
  "zc" 'hide-subtree
  "zC" 'hide-all
  (kbd "H" 'org-shiftleft)
  (kbd "J" 'org-shiftdown)
  (kbd "K" 'org-shiftup)
  (kbd "L" 'org-shiftright)
  (kbd "M-h" 'org-metaleft)
  (kbd "M-j") 'org-metadown
  (kbd "M-k") 'org-metaup
  (kbd "M-l" 'org-metaright)
  (kbd "M-H") 'org-shiftmetaleft
  (kbd "M-J") 'org-shiftmetadown
  (kbd "M-K") 'org-shiftmetaup
  (kbd "M-L") 'org-shiftmetaright)

(evil-define-key 'normal rdictcc-permanent-translation-mode
  "j" 'rdictcc-next-line
  "k" 'rdictcc-previous-line
  "h" 'rdictcc-backward-char
  "l" 'rdictcc-forward-char
  "b" 'rdictcc-backward-word
  "w" 'rdictcc-forward-word)

(defadvice evil-goto-definition (around evil-clever-goto-def activate)
  "Make use of emacs', slime's and etags possibilities for finding definitions."
  (case major-mode
    (lisp-mode (if slime-mode
		   (or (slime-find-definitions (symbol-name (symbol-at-point)))
		       ad-do-it)
		 ad-do-it))
    (emacs-lisp-mode (condition-case nil
			 (find-function (symbol-at-point))
		       (error (condition-case nil
				  (find-variable (symbol-at-point))
				(error ad-do-it)))))
    (otherwise
     (let ((tag (symbol-name (symbol-at-point))))
       (if (find-tag-noselect tag)
	   (find-tag tag)
	 ad-do-it)))))

(defun cofi/clear-empty-lines ()
  (let ((line (buffer-substring (point-at-bol) (point-at-eol))))
    (when (string-match "^ +$" line)
      (delete-region (point-at-bol) (point-at-eol)))))
(add-hook 'evil-insert-state-exit-hook #'cofi/clear-empty-lines)

(require 'evil-leader)
(evil-leader/set-key
  "e" 'ido-find-file
  "E" 'ido-find-file-other-window
  "b" 'ido-switch-buffer
  "w" 'save-buffer
  "W" 'save-some-buffers
  "k" 'kill-buffer-and-window
  "K" (cmd (kill-buffer (current-buffer)))
  "<" 'cofi-cd-alias
  "d" 'dired-jump
  "D" 'cofi-dired-alias

  "m" 'compile

  "c" 'delete-window
  "N" 'make-frame-command
  "C" 'delete-frame

  "g" 'magit-status

  "." 'evil-ex)

(defun cofi/evil-cursor ()
  "Change cursor color according to evil-state."
  (let ((default "OliveDrab4")
	(cursor-colors '((insert . "dark orange")
			 (emacs . "sienna")
			 (visual . "white"))))
    (setq cursor-type (if (eq evil-state 'visual)
			  'hollow
			'bar))
    (set-cursor-color (def-assoc evil-state cursor-colors default))))

(require 'cofi-windowing)
(global-set-key (kbd "C-z") (evil-mode 1))
;; allow C-w to be shadowed in emacs-state -- `evil-want-C-w-in-emacs-state' doesn't allow this
(global-set-key (kbd "C-w") evil-window-map)
;; alternative if shadowed
(global-set-key (kbd "C-c w") evil-window-map)
;; Windowing
(fill-keymap evil-window-map
    ;; Splitting
    "\\" 'split-window-vertically
    "|" 'split-window-horizontally
    "/" 'smart-split

    ;; Deleting
    "q" 'delete-window
    "o" 'delete-other-windows

    ;; Sizing
    "RET" 'enlarge-window
    "-" 'shrink-window-horizontally
    "+" 'enlarge-window-horizontally

    ;; Moving
    "<left>" 'evil-window-left
    "<down>" 'evil-window-down
    "<up>" 'evil-window-up
    "<right>" 'evil-window-right

    ;; Swapping
    "M-h" 'swap-with-left
    "M-j" 'swap-with-down
    "M-k" 'swap-with-up
    "M-l" 'swap-with-right
    "SPC" 'swap-window

    ;; winner-mode
    "u" 'winner-undo
    "C-r" 'winner-reod
    ;; shadow rotating in evil-window-map
    "C-R" 'winner-redo)

;; make ace jump look like a single command to evil
(defadvice ace-jump-word-mode (after evil activate)
  (recursive-edit))

(defadvice ace-jump-char-mode (after evil activate)
  (recursive-edit))

(defadvice ace-jump-line-mode (after evil activate)
  (recursive-edit))

(defadvice ace-jump-done (after evil activate)
  (exit-recursive-edit))

(defun cofi/ace-jump-char-direct-mode ()
  "Do a ace char-jump directly to the char."
  (interactive)
  (ace-jump-char-mode)
  (forward-char 1))

(evil-add-hjkl-bindings *bc-menu-mode-map* 'emacs)

(evil-add-hjkl-bindings magit-branch-manager-mode-map 'emacs
  "K" 'magit-discard-item
  "L" 'magit-key-mode-popup-logging)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard-item
  "l" 'magit-key-mode-popup-logging
  "h" 'magit-toggle-diff-refine-hunk)

(provide 'evil-config)
