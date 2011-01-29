(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path dotfiles-dir)

(require 'package)
(require 'elpa)

(mapc 'require '(settings utils plugins registers bindings modes eim-config org-config erc-config))
