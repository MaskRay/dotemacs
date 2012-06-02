(when (load "nxhtml-loaddefs" 'noerror)
  (fset 'html-mode 'nxhtml-mode))

(when (require 'zencoding-mode nil 'noerror)
  (add-hook 'sgml-mode-hook 'zencoding-mode)
  (add-hook 'html-mode-hook 'zencoding-mode)
  (define-key zencoding-mode-keymap (kbd "<C-Return>") 'zencoding-expand-yas))

(provide 'html-config)
