(add-to-list 'el-get-recipe-path (expand-file-name "recipes" dotfiles-dir))

(setq el-get-sources
      '(
	auctex
	auto-complete
	bookmark+
	dired+
	expand-region
	fastnav
	helm
	highlight-symbol
	kill-ring-search
	multi-term
	paredit
	popup
	second-sel
	smex
	whole-line-or-region
	window-number
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
