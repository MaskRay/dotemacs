(load-file "/usr/share/emacs/site-lisp/org-mode/org-latex.el")
(require 'org-latex)
(require 'org-special-blocks)
(setq org-export-latex-listings t)

;; Originally taken from Bruno Tavernier: http://thread.gmane.org/gmane.emacs.orgmode/31150/focus=31432
;; but adapted to use latexmk 4.20 or higher.
(defun my-auto-tex-cmd ()
  "When exporting from .org with latex, automatically run latex,
pdflatex, or xelatex as appropriate, using latexmk."
  (let ((texcmd)))
  ;; default command: oldstyle latex via dvi
  (setq texcmd "latexmk -dvi -pdfps %f")
  ;; pdflatex -> .pdf
  (if (string-match "LATEX_CMD: pdflatex" (buffer-string))
      (setq texcmd "latexmk -pdf %f"))
  ;; xelatex -> .pdf
  (if (string-match "LATEX_CMD: xelatex" (buffer-string))
      (setq texcmd "latexmk -pdflatex=xelatex -pdf %f"))
  ;; LaTeX compilation command
  (setq org-latex-to-pdf-process (list texcmd)))

(add-hook 'org-export-latex-after-initial-vars-hook 'my-auto-tex-cmd)


;; Default packages included in every tex file, pdflatex or xelatex
(setq org-export-latex-default-packages-alist
      '(("" "indentfirst" t)
	("" "fontspec" t)
	("" "amsmath" t)
	("" "hyperref" t)
	("" "graphicx" t)
	("" "longtable" t)
	("slantfont,boldfont" "xeCJK" t)
	)
      )

(defun my-auto-tex-parameters ()
  "Automatically select the tex packages to include."

  ;; Packages to include when xelatex is used
  ;; (see https://github.com/kjhealy/latex-custom-kjh for the
  ;; non-standard ones.)
  (if (string-match "LATEX_CMD: xelatex" (buffer-string))
      (setq org-export-latex-default-packages-alist
'(("" "fontspec" t)
("" "xltxtra" t)
("" "xunicode" t)
("slantfont,boldfont" "xeCJK" t)
("" "amsmath" t)
("" "hyperref" t)
("" "graphicx" t)
)))

  (if (string-match "LATEX_CMD: xelatex" (buffer-string))
      (setq org-export-latex-classes
(cons '("article"
"\\documentclass[12pt]{article}"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
org-export-latex-classes))))

(add-hook 'org-export-latex-after-initial-vars-hook 'my-auto-tex-parameters)

(provide 'org-xelatex)
