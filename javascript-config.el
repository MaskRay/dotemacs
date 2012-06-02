;; js2-mode
;;
;; This mode does not yet work with "multi-mode" modes such as mmm-mode
;; and mumamo, although it could possibly be made to do so with some effort.
;; This means that js2-mode is currently only useful for editing JavaScript
;; files, and not for editing JavaScript within <script> tags or templates.
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq-default js2-basic-offset 2)

;; js-mode
(setq js-indent-level 2)

(provide 'javascript-config)
