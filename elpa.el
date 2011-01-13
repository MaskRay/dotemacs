(setq package-user-dir (expand-file-name "elpa" dotfiles-dir))
(setq autoload-file (expand-file-name "loaddefs.el" dotfiles-dir))
(setq vendor-dir (expand-file-name "site-lisp" dotfiles-dir))

(add-to-list 'load-path vendor-dir)
(let ((default-directory vendor-dir))
  (normal-top-level-add-subdirs-to-load-path)
  )

(setq packages '(
                 auctex
                 magit
                 highlight-parentheses
                 highlight-symbol
                 kill-ring-search
                 newsticker
                 org
                 paredit))

(defun elpa-install ()
  "Install all starter-kit packages that aren't installed."
  (interactive)
  (package-refresh-contents)
  (dolist (package packages)
    (unless (or (member package package-activated-list)
(functionp package))
      (message "Installing %s" (symbol-name package))
      (package-install package))))

(defun regen-autoloads (&optional force-regen)
  "Regenerate the autoload definitions file if necessary and load it."
  (interactive "P")
  (let ((autoload-dir vendor-dir)
        (generated-autoload-file autoload-file))
    (when (or force-regen
              (not (file-exists-p autoload-file))
              (some (lambda (f) (file-newer-than-file-p f autoload-file))
                    (directory-files autoload-dir t "\\.el$")))
      (message "Updating autoloads...")
      (let (emacs-lisp-mode-hook)
        (update-directory-autoloads autoload-dir))))
  (load autoload-file))

(setq package-archives '(("elpa" . "http://tromey.com/elpa/")))
(package-initialize)
;; (elpa-install)
(regen-autoloads)
(provide 'elpa)
