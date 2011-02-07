(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path dotfiles-dir)

(require 'package)
(require 'el-get-init)
(add-to-list 'load-path vendor-dir)

(mapc (lambda (feature) (require feature nil t)) '(settings utils plugins registers bindings modes eim-config org-config erc-config))
