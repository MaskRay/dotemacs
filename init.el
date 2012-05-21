(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))
(setq prelude-vendor-dir dotfiles-dir)
(add-to-list 'load-path dotfiles-dir)

(require 'package)
(require 'el-get-init)
(require 'el-get-sources)
(add-to-list 'load-path (expand-file-name "site-lisp" dotfiles-dir))

(mapc (lambda (feature) (require feature nil t)) '(evil-config prelude-core settings utils plugins registers bindings modes completion org-config erc-config))
(put 'autopair-newline 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)
