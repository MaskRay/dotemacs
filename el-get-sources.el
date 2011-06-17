(add-to-list 'el-get-recipe-path (expand-file-name "recipes" dotfiles-dir))

(setq el-get-sources
      '(
	auctex
	autopair
	bookmark+
	browse-kill-ring
	color-moccur
	cursor-chg
	dired+
	drag-stuff
	eim
	erc-highlight-nicknames
	follow-mouse
	highlight-symbol
	kill-ring-search
	magit
	moccur-edit
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
(el-get 'sync)

(let ((default-directory (expand-file-name "el-get" dotfiles-dir)))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path)
  )
