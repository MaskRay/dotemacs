(autoload 'ruby-mode "ruby-mode" "Major mode to edit ruby files." t)

(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))
(add-to-list 'interpreter-mode-alist  '("ruby" . ruby-mode))

(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process" t)
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")

(require 'ruby-electric)
(require 'yari)
(add-hook 'ruby-mode-hook 'inf-ruby-keys)
(add-hook 'ruby-mode-hook (lambda ()
			    (local-set-key "\r" 'newline-and-indent)
			    (ruby-electric-mode t)
			    (local-set-key (kbd "C-h r") 'yari)
			    ))

(provide 'ruby-config)
