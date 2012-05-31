(add-to-list 'load-path user-emacs-directory)

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(dolist (package '(
		   ace-jump-mode
		   auctex
		   auto-complete
		   bm
		   bookmark+
		   cdlatex
		   evil
		   evil-leader
		   evil-numbers
		   expand-region
		   fastnav
		   magit
		   paredit
		   projectile
		   rainbow-mode
		   smex
		   undo-tree
		   window-number
		   yasnippet

		   ;; haskell-mode
		   yari
		   ))
  (unless (package-installed-p package)
    (package-install package)))

(dolist (dir '("elpa" "vendor"))
  (let ((default-directory (expand-file-name dir user-emacs-directory)))
    (normal-top-level-add-subdirs-to-load-path)))

(mapc (lambda (feature) (require feature nil 'noerror)) '(evil-config settings utils plugins bindings modes completion org-config))

(mapc (lambda (lang) (require lang nil 'noerror)) '(haskell-config ruby-config))
