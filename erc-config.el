(setq erc-default-coding-system '(utf-8 . utf-8))
(setq erc-nick "MaskRay"
      erc-user-full-name "MaskRay"
      erc-email-userid "ray")

(setq erc-track-exclude-server-buffer t)
(setq erc-track-exclude-types '("NICK" "333" "353" "JOIN" "PART" "QUIT"))


(load "~/.erc.el" 'noerror)

;;; erc-nick-notify
(require 'erc-nick-notify)


;;; paste2
(require 'paste2)


(defun erc-init ()
  (interactive)
  (when (not pwfreenode)
      (setq pwfreenode (read-passwd "freenode password: "))
      (setq pwoftc pwfreenode)
      (setq pwbitlbee (read-passwd "bitlbee password: ")))
  (erc :server "localhost" :port 6667 :nick "MaskRay" :password pwbitlbee)
  (erc :server "irc.oftc.net" :port 6667 :nick "MaskRay" :password "")
  (erc :server "irc.freenode.net" :port 6667 :nick "MaskRay" :password pwfreenode)
  )
(require 'erc-join)
(erc-autojoin-mode -1)
(add-hook 'erc-after-connect
    	  '(lambda (SERVER NICK)
	     (erc-toggle-ctcp-autoresponse 1)
    	     (cond
    	      ((string-match "freenode\\.net" SERVER)
    	       (erc-message "PRIVMSG" (concat "NickServ identify " pwfreenode)))
	      ((string-match "oftc\\.net" SERVER)
	       (erc-message "PRIVMSG" (concat "NickServ identify " pwoftc)))
	      ((string-match "ray" SERVER)
	       (erc-message "PRIVMSG" (concat "NickServ identify " pwbitlbee)))
	      )))


(erc-autojoin-mode 1)
(setq erc-autojoin-channels-alist
      '(
	("freenode.net" "#gentoo-cn" "#emacs" "#haskell" "#ubuntu-cn-ot" "#ubuntu-cn")
	("oftc.net" "#emacs-cn")
	))


;;; remove trailing newlines
(defun erc-remove-trailing-newlines (msg)
  (setq str (replace-regexp-in-string "\n+$" "" msg))
  )
(add-hook 'erc-send-pre-hook 'erc-remove-trailing-newlines)


;;; highlight nicknames
(and
 (require 'erc-highlight-nicknames)
 (add-to-list 'erc-modules 'highlight-nicknames)
 (erc-update-modules))


(provide 'erc-config)
