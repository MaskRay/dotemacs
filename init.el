(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path dotfiles-dir)

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
  (let ((default-directory (expand-file-name dir dotfiles-dir)))
    (normal-top-level-add-subdirs-to-load-path)))

(mapc (lambda (feature) (require feature nil t)) '(evil-config settings utils plugins registers bindings modes completion org-config))

(mapc (lambda (lang) (require lang nil t)) '(haskell-config ruby-config))
