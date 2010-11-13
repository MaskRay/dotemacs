(defun window-system-font-setting ()
  (when (not (eq (window-system) nil))
    (defun en-zh-font-existsp (font)  
      (if (null (x-list-fonts font))  
	  nil t))
    (defvar font-list '("文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
    (require 'cl) ;; find-if is in common list package
    (find-if #'en-zh-font-existsp font-list)
    (defun en-zh-make-font-string (font-name font-size)
      (if (and (stringp font-size)
	       (equal ":" (string (elt font-size 0))))
	  (format "%s%s" font-name font-size)
	(format "%s %s" font-name font-size)))
    (defun en-zh-set-font (english-fonts
			   english-font-size
			   chinese-fonts
			   &optional chinese-font-size)
      "english-font-size could be set to a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
      (require 'cl)                         ; for find if
      (let ((en-font (en-zh-make-font-string
		      (find-if #'en-zh-font-existsp english-fonts)
		      english-font-size))
	    (zh-font (font-spec :family (find-if #'en-zh-font-existsp chinese-fonts)
				:size chinese-font-size)))
	;; Set the default English font
	;;
	;; The following 2 method cannot make the font settig work in new frames.
	;; (set-default-font "Consolas:pixelsize=16")
	;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=16"))
	;; We have to use set-face-attribute
	(message "Set English Font to %s" en-font)
	(set-face-attribute 'default nil :font en-font)

	;; Set Chinese font
	;; Do not use 'unicode charset, it will cause the english font setting invalid
	(message "Set Chinese Font to %s" zh-font)
	(dolist (charset '(kana han symbol cjk-misc bopomofo))
	  (set-fontset-font (frame-parameter nil 'font)
			    charset
			    zh-font))))
    (en-zh-set-font
     '("Envy Code R VS" "Consolas" "DejaVu Sans Mono" "Monospace" "Courier New") ":pixelsize=22"
     '("DejaVu Sans YuanTi Mono" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
    (global-set-key (kbd "<C-mouse-4>") (lambda () (interactive) (text-scale-decrease 1)))
    (global-set-key (kbd "<C-mouse-5>") (lambda () (interactive) (text-scale-increase 1)))

    )
)

  (provide 'fonts)
