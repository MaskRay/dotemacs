(add-to-list 'el-get-recipe-path (expand-file-name "recipes" dotfiles-dir))

(setq el-get-sources
      '(
	auctex
	autopair
	bookmark+
	cursor-chg
	dired+
	drag-stuff
	eim
	erc-highlight-nicknames
	expand-region
	follow-mouse
	highlight-symbol
	kill-ring-search
	magit
	multi-term
	org-mode
	paredit
	paste2
	second-sel
	smex
	twittering-mode
	whole-line-or-region
	window-number
	workgroups
	yasnippet
	)
      )
; (el-get 'sync)

(let ((default-directory (expand-file-name "el-get" dotfiles-dir)))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path)
  )

(provide 'el-get-sources)
