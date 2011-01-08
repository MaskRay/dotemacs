;; safe-load
(defvar safe-load-error-list ""
  "*List of files that reported errors when loaded via safe-load")
(defun safe-load (file &optional noerror nomessage nosuffix)
  "Load a file.  If error when loading, report back, wait for
   a key stroke then continue on"
  (interactive "f")
  (condition-case nil (load file noerror nomessage nosuffix)
    (error
     (progn
       (setq safe-load-error-list  (concat safe-load-error-list  " " file))
       (message "****** [Return to continue] Error loading %s" safe-load-error-list )
       (sleep-for 1)
       nil))))

;; goto-char
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

(defun open-current-file-as-admin ()
  "Open the current buffer as unix root.
This command works on unixes only."
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
           buffer-file-name))))

(defun kill-orphan-buffers ()
  (interactive)
  (dolist (buffer (buffer-list))
    (let ((fname (buffer-file-name buffer)))
      (when (and fname (not (file-exists-p fname)) (not (buffer-modified-p buffer)))
        (message (concat "Killing " fname))
        (kill-buffer buffer)))))

(defun revert-unmodified-buffers ()
  (interactive)
  (dolist (buffer (buffer-list))
    (let ((fname (buffer-file-name buffer)))
      (when (and fname (file-exists-p fname) (not (buffer-modified-p buffer))
                 (not (verify-visited-file-modtime buffer)))
        (message (concat "Reverting " fname))
        (with-current-buffer buffer
          (revert-buffer t t))))))

(provide 'utils)
