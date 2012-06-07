(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-selection-face ((t (:background "blue" :foreground "white"))))
 '(diredp-dir-priv ((t (:foreground "DarkSeaGreen2"))) t)
 '(diredp-exec-priv ((t nil)) t)
 '(diredp-file-name ((t (:foreground "White"))) t)
 '(diredp-file-suffix ((t (:foreground "Magenta"))) t)
 '(diredp-flag-mark-line ((t (:background "#5f5f5f"))) t)
 '(diredp-ignored-file-name ((t (:foreground "Chocolate3"))) t)
 '(diredp-no-priv ((t nil)) t)
 '(diredp-number ((t (:foreground "LightBlue"))) t)
 '(diredp-other-priv ((t nil)) t)
 '(diredp-rare-priv ((t (:foreground "Orchid"))) t)
 '(diredp-read-priv ((t nil)) t)
 '(diredp-write-priv ((t nil)) t))

(put 'dired-find-alternate-file 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmark")
 '(custom-safe-themes (quote ("501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c" "c745073c7479e42cc043cba7ec56bebcdfbc53dadda2fcecce6a195383794fb8" default)))
 '(nxhtml-menu-mode t)
 '(org-agenda-files (quote ("~/org/todo.org")))
 '(safe-local-variable-values (quote ((org-export-latex-preamble . "\\documentclass[ngerman]{article}
\\usepackage[T1]{fontenc}
\\usepackage[utf8]{inputenc}
\\usepackage{verbatim}
%% No necesito \\url porque uso hyperref (\\href)
%% \\IfFileExists{url.sty}{\\usepackage{url}}
%%                       {\\newcommand{\\url}{\\texttt}}
\\usepackage[authoryear]{natbib}
\\usepackage{ae}

\\makeatletter
\\providecommand{\\LyX}{L\\kern-.1667em\\lower.25em\\hbox{Y}\\kern-.125emX\\@}

\\usepackage{bibgerm}

\\usepackage{babel}
\\makeatother

\\usepackage[breaklinks=true]{hyperref}
\\usepackage{breakurl}
\\usepackage{array}
") (eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook" (add-hook (quote write-contents-functions) (lambda nil (delete-trailing-whitespace) nil)) (require (quote whitespace)) "Sometimes the mode needs to be toggled off and on." (whitespace-mode 0) (whitespace-mode 1)) (whitespace-line-column . 80) (whitespace-style face trailing lines-tail) (require-final-newline . t)))))
