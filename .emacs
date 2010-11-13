(progn (cd "~/.emacs.d") (normal-top-level-add-subdirs-to-load-path) (cd "~"))
(add-to-list 'load-path "~/.emacs.d")
(mapc 'require '(color-theme-irblack utils modes settings plugins keybindings org-mode-settings erc-settings))
