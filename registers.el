(dolist (r `((?i (file . ,(expand-file-name "init.el" dotfiles-dir)))
	     (?m (file . "~/main.cpp"))
	     (?r (file . ,(expand-file-name "registers.el" dotfiles-dir)))
	     ))
  (set-register (car r) (cadr r))
  )

(provide 'registers)
