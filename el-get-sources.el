(add-to-list 'el-get-recipe-path (expand-file-name "recipes" dotfiles-dir))

(setq el-get-sources
      '(
	auctex
	auto-complete
	autopair
	bookmark+
	cursor-chg
	dired+
	drag-stuff
	expand-region
	fastnav
	follow-mouse
	helm
	highlight-symbol
	kill-ring-search
	multi-term
	org-mode
	paredit
	popup
	second-sel
	smex
	twittering-mode
	;; whole-line-or-region
	window-number
	workgroups
	yari
	yasnippet
	)
      )
; (el-get 'sync)

(let ((default-directory (expand-file-name "el-get" dotfiles-dir)))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path)
  )

(provide 'el-get-sources)
