;;; erc-nick-notify.el --- Notify popup for ERC

;; Filename: erc-nick-notify.el
;; Description: Notify popup for ERC
;; Author: Andy Stewart lazycat.manatee@gmail.com
;; Maintainer: Andy Stewart lazycat.manatee@gmail.com
;; Copyright (C) 2008, 2009, Andy Stewart, all rights reserved.
;; Created: 2008-12-04 12:47:28
;; Version: 0.2.1
;; Last-Updated: 2009-01-31 10:47:32
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/erc-nick-notify.el
;; Keywords: erc, notify
;; Compatibility: GNU Emacs 23.0.60.1
;;
;; Features that might be required by this library:
;;
;; `erc'
;;

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; Notify popup for ERC
;;
;; This extension use `notify-send' for notify.
;; So make you have install `notify-send' in your system.
;;

;;; Installation:
;;
;; Put erc-nick-notify.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'erc-nick-notify)
;;
;; No need more.

;;; Customize:
;;
;; `erc-nick-notify-delay'
;; The delay time that between two messages.
;; `erc-nick-notify-cmd'
;; The command that use for notify.
;; `erc-nick-notify-icon'
;; The file name of icon display.
;; `erc-nick-notify-timeout'
;; The timeout in milliseconds at which to expire the notification.
;; `erc-nick-notify-urgency'
;; The urgency level.
;; `erc-nick-notify-category'
;; The notification category.
;;
;; All of the above can be customize by:
;;      M-x customize-group RET erc-nick-notify RET
;;

;;; Change log:
;;
;; 2009/01/31
;;      Fix doc.
;;
;; 2008/12/21
;;      Fix `void-variable' bug.
;;
;; 2008/12/08
;;      Add customize support.
;;
;; 2008/12/04
;;      First released.
;;

;;; Acknowledgements:
;;
;;
;;

;;; TODO
;;
;;
;;

;;; Require
(require 'erc)

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Customize ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defgroup erc-nick-notify nil
  "Notify popup for ERC."
  :group 'erc)

(defcustom erc-nick-notify-delay '(0 5 0)
  "The delay time that between two message.
Default is 5 minutes."
  :type 'list
  :group 'erc-nick-notify)

(defcustom erc-nick-notify-cmd "notify-send"
  "The command that use for notify."
  :type 'string
  :group 'erc-nick-notify)

(defcustom erc-nick-notify-icon "/usr/share/pixmaps/pidgin/protocols/22/google-talk.png"
  "Specifies an icon filename or stock icon to display."
  :type 'string
  :group 'erc-nick-notify)

(defcustom erc-nick-notify-timeout 15000
  "Specifies the timeout in milliseconds at which to expire the notification."
  :type 'number
  :group 'erc-nick-notify)

(defcustom erc-nick-notify-urgency "normal"
  "Specifies the urgency level (low, normal, critical)."
  :type 'string
  :group 'erc-nick-notify)

(defcustom erc-nick-notify-category "im.received"
  "Specifies the notification category: im, im.errors, im.received"
  :type 'string
  :group 'erc-nick-notify)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Variable ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar erc-nick-notify-last '(0 0 0)
  "The last time that receive message.")

(defvar erc-privmsg-notify-last '(0 0 0)
  "The last time that receive message.")

(defvar erc-nick-notify-buffer nil
  "The buffer name of last notify me.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Interactive Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun erc-nick-notify-jump-last-channel ()
  "Jump to last channel that notify me."
  (interactive)
  (if erc-nick-notify-buffer
      (switch-to-buffer erc-nick-notify-buffer)
    (message "Nobody notify you in IRC.")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Utilities Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun erc-nick-notify ()
  "Notify me when my nick show up.
This function should be in the insert-post-hook."
  (let ((now (current-time)))
    (when (time-less-p erc-nick-notify-delay
                       (time-since erc-nick-notify-last))
      (setq erc-nick-notify-last now)
      (goto-char (point-min))
      (when (re-search-forward
             (concat "\\("
                     "\\(<\\([^>]*\\)>\\)" ; <someone> "<nickname>"
                     "\\|" ;; 匹配只以《一个》*开头加一空格再接任意个非空字母开头(nick) 可能有bug "* nickname"
		     "\\([^\\*]\\* \\([^\\(" (regexp-quote (erc-current-nick))"\\)][^ ]*\\)\\)"
		     ;; todo 不匹配自己说的话 或者 /me 正则表达式不行?
		     ;;	"\\|"
		     ;; "\\(\\* " (regexp-quote (erc-current-nick)) "\\)"	
		     "\\|"
		     "\\(-\\([^-]*\\)-\\)" ;匹配 notice 信息中本昵称 "-nickname-"
                     "\\)" ;; 此()匹配各种类发消息的nickname 
                     "\\(.*" (regexp-quote (erc-current-nick)) ".*\\)")
             nil t)
        (let ((msg (concat
                    (when (> (length (match-string-no-properties 3)) 0) ;channel信息中send nick
                      (concat "<b>&lt;" (match-string-no-properties 3)
                              "&gt;</b> "))
                    (when (> (length (match-string-no-properties 5)) 0) ; /me 信息包含的send nick
		      (concat "<b>&lt;\*" (match-string-no-properties 5)
                              "&gt;</b> "))
                    (when (> (length (match-string-no-properties 6)) 0) ; /notice 信息包含的send nick
		      (concat "<b>" (match-string-no-properties 6)
                              "</b> "))
                    ;;(match-string-no-properties 8))))
		    (replace-regexp-in-string "<" "&lt;"
					      (replace-regexp-in-string "&" "&amp;"	      									(match-string-no-properties 8)))))) ;; 替换包括<和 &的语句。 >显示正常。 NOTE:必须先替换 & 再替换 <，否则 &lt;里的&会被替换成&amp; 不能正常显示
          (setq erc-nick-notify-buffer (buffer-name))
	  (start-process-shell-command "nicknotify" nil 
				       (concat erc-nick-notify-cmd
					       " -h " "int:x:1233"
					       " -h " "int:y:788"	  
					       " -i " erc-nick-notify-icon
					       " -t " (int-to-string
						       erc-nick-notify-timeout)
					       " -u " erc-nick-notify-urgency
					       " -c " erc-nick-notify-category
					       " -- "
					       " \"" erc-nick-notify-buffer "\""
					       ;; " \""
					       ;; (if (boundp 'msg)
					       ;; 	   msg "")
					       ;; "\"")))))))
					       " \"<span color='RoyalBlue'>"
					       (if (boundp 'msg)
					       	   msg "") 
					       "</span>\"")))))))

;; Add `erc-nick-notify' to `erc-insert-post-hook'
(add-hook 'erc-insert-post-hook 'erc-nick-notify)

;; PRIVMSG Messages Pop up
(defun my-erc-page-me-PRIVMSG (proc parsed)
  (let ((now (current-time))
	(nick (erc-extract-nick (erc-response.sender parsed)))
        (target (car (erc-response.command-args parsed)))
        (msg  (replace-regexp-in-string "<" "&lt;" 
					(replace-regexp-in-string "&" "&amp;"
								  (erc-response.contents parsed)))))
    (when (and (erc-current-nick-p target)
               (not (erc-is-message-ctcp-and-not-action-p msg))
	       (time-less-p erc-nick-notify-delay
                       (time-since erc-privmsg-notify-last))
					;               (my-erc-page-allowed nick)
	       )
      (setq erc-privmsg-notify-last now)
      (start-process-shell-command "privnotify" nil
				   (concat erc-nick-notify-cmd
					   " -h " "int:x:1233"
					   " -h " "int:y:788"	  
					   " -i " erc-nick-notify-icon
					   " -t " (int-to-string
						   erc-nick-notify-timeout)
					   " -u " erc-nick-notify-urgency
					   " -c " erc-nick-notify-category
					   " -- "
					   " \"" nick " says to you:" "\""
					   " \"<span color='red'>"
					   (if (boundp 'msg)
					       msg "")
					   "</span>\""))
      nil)))
(add-hook 'erc-server-PRIVMSG-functions 'my-erc-page-me-PRIVMSG)


(provide 'erc-nick-notify)

;;; erc-nick-notify.el ends here
;;; LocalWords:  erc cmd im msg lt
