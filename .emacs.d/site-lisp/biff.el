;;; -*- Emacs-Lisp -*-
;;; (Hope to be) All-mighty biff program in Emacs-Lisp
;;; (c)2000, 2003 by HIROSE Yuuji [yuuji@gentei.org]
;;; $Id: biff.el,v 1.4 2003/11/14 15:56:28 yuuji Exp $
;;; Last modified Sat Nov 15 00:52:58 2003 on firestorm
;;; Update count: 224

;;[Commentary]
;;
;;	This  package provides  mail  arrival check,  so called  `biff',
;;	feature via POP3(and APOP),  IMAP, mbox, maildir.  Both one-time
;;	mode and repeat-in-background mode are available.
;;	
;;	mbox, maildir, POP3(APOP), IMAP4 $BA4BP1~$N(B `biff' $B%W%m%0%i%`!#(B
;;
;;[Requirements]
;;	
;;	This program uses Gareth Rees's  `md5.el' package if you want to
;;	use APOP, and Kyle E. Jones's `base64.el' package if you want to
;;	use  IMAP/AUTH.  Maybe  you  have already  gotten  it with  this
;;	package.  If  not yet, it can  be found in  w3-mode package.  Or
;;	you'll be find it in the following URL;
;;	
;;	http://www.gentei.org/~yuuji/software/biff-el.html
;;	
;;	APOP $B$G$N%A%'%C%/$r$9$k$K$O(B md5.el $B$,!"(BIMAP/AUTH$B$G$N%A%'%C%/$r$9(B
;;	$B$k$K$O(B base64.el $B$,$=$l$>$lI,MW$G$9!#8+IU$+$i$J$$>l9g$O>e5-$N(BURL
;;	$B$NJ,$+$k>l=j$KCV$$$H$-$^$9!#(B
;;	
;;[Installation]
;;
;;	Make sure  biff.el and  md5.el are in  a directory  which is
;;	contained in load-path.  Then  put the lisp expressions below in
;;	your ~/.emacs,  where `ACCOUNT' is a nickname  of associated POP
;;	account, `SERVER' is  its POP3 server host name,  `USER' is user
;;	name on  the server, `PROTO'  is protocol; 'pop or  'apop, which
;;	defaults to pop.
;;	
;;		(load "biff")
;;		(setq biff-account-alist
;;		  '(("ACCOUNT"
;;		       (server . "SERVER") (user . "USER") (proto . apop))
;;		    ("ACCOUNT2"
;;		       (server . "SERVER2") (user . "USER2") (proto . pop))))
;;		(biff-background-all) ;(if you want to check all server)
;;	
;;	biff.el, md5.el $B$r(B load-path $B$NDL$C$?%G%#%l%/%H%j$KCV$$$F>e(B
;;	$B5-$N(BEmacs-Lisp$B<0$r(B ~/.emacs $B$KDI2C$7$^$9!#(B
;;	
;;[Run]
;;
;;	The first time you use this, or to create a new mail account,
;;	type simply;
;;	
;;		M-x biff
;;	
;;	It asks you account name(any string) and some server
;;	information.  Once you answer to all the question, the account
;;	name will be choosable in the further `M-x biff' command.  You
;;	can register any number of accounts. You may want to save your
;;	account information in your ~/.emacs.  Then, type
;;	
;;		M-x biff-save-accounts
;;	
;;	to save all account information.
;;	The following commands are useful.
;;	
;;	* M-x biff-background
;;	  Check mail on one account
;;	* M-x biff-background-list
;;	  Check mail on specified(maybe multiple) accounts
;;	* M-x biff-background-all
;;	  Check mail on all accounts
;;	* M-x biff-cancel-background
;;	  Stop background-check
;;	
;;	$B$H$j$"$($:0lH/L\$O(B M-x biff $B$H$9$k$H!"%"%+%&%s%HL>$rJ9$$$FMh$k$N(B
;;	$B$GD4$Y$?$$%5!<%P$rI=$9E,Ev$JL>A0$rF~$l!"$=$N8e$KJ9$$$FMh$k%5!<%P(B
;;	$B>pJs$KEz$($^$9!#A4$F$KEz$($?$i<!2s$N(B M-x biff $B$GMxMQ$G$-$^$9!#%"(B
;;	$B%+%&%s%H$O2?8D$G$bEPO?$G$-!"$b$7$=$l$i$r(B ~/.emacs $B$K%;!<%V$7$?$$(B
;;	$B$H$-$O(B
;;
;;		M-x biff-save-accounts
;;
;;	$B$7$^$9!#$=$NB>NI$/MxMQ$7$=$&$J%3%^%s%I$O0J2<$NDL$j$G$9!#(B
;;
;;	* M-x biff-background
;;	  $B0l$D$N%"%+%&%s%H$r%P%C%/%0%i%&%s%I$G7+$jJV$7%A%'%C%/(B
;;	* M-x biff-background-list
;;	  $BG$0U8D$N%"%+%&%s%H$r%P%C%/%0%i%&%s%I$G7+$jJV$7%A%'%C%/(B
;;	* M-x biff-background-all
;;	  $BEPO?$7$F$"$kA4$F$N%"%+%&%s%H$r%P%C%/%0%i%&%s%I$G7+$jJV$7%A%'%C%/(B
;;	* M-x biff-cancel-background
;;	  $B%P%C%/%0%i%&%s%I$G$N%A%'%C%/$r%-%c%s%;%k(B
;;
;;[Configuration]
;;
;;	Here are the configuration variables.
;;
;;	[Variable]			[Default value / Meaning]
;;	biff-pop-port			110 / Port number of POP3 service
;;	biff-imap-port			143 / Port number of IMAP service
;;	biff-account-alist		nil / See above
;;	biff-check-interval		600 / Mail check interval in second
;;	biff-use-beep			t   / Beep when some mails arrived
;;	biff-use-beep-visible		nil / When use-beep, need visible-bell?
;;
;;	$B>e5-$NJQ?t$K$h$C$F%+%9%?%^%$%:2DG=$G$9!#(B
;;
;;[Bugs]
;;
;;	When  your mails are  arrived on  multiple servers,  because the
;;	arrival notifications except the last one immediately disappear,
;;	you cannot take your eyes off :)
;;
;;	And more...
;;
;;	$BJ#?t$N%"%+%&%s%H$K?7Ce%a%$%k$,$"$k$H$-$O:G8e$NDLCN0J30$O$9$0$K8+(B
;;	$B$($J$/$J$k$N$G$h$=8+$,$G$-$^$;$s!#(B
;;
;;	$B$=$NB>%P%0=P$7$O$^$@$^$@!D(B
;;
;;[Acknowledgements]
;;
;;	Thanks to the people who sent me patches and/or advices as bellow;
;;	
;;	* Daiji KANEMATSU <kanematu@sra.co.jp>
;;		Patch for ding
;;	* Jun'ichiro KITA <kita@coe.nttdata.co.jp>
;;		Patch for XEmacs (using itimer package)
;;	* MIHIRA Sanpei Yoshiro <sanpei@sanpei.org>
;;		Reported CR/CR/LF problem on Meadow
;;
;;[No Warranty]
;;
;;	This  program is  free  software and  comes  with absolutely  NO
;;	WARRANTY.   The  author  is  not responsible  for  any  possible
;;	defects  caused by this  software.  You  can freely  modify this
;;	program  for  your convenience.   But  if  you  want to  publish
;;	modified program,  please tell me before  announcement.  Take it
;;	easy to write me comments, bug-reports.
;;							yuuji@gentei.org
;;
;;	$B$3$N%W%m%0%i%`$O%U%j!<%=%U%H%&%'%"$H$7$FG[I[$7$^$9!#$3$N%W%m%0%i(B
;;	$B%`$NMxMQ$K$h$C$F@8$8$?$$$+$J$k7k2L$KBP$7$F$b:n<T$O@UG$$rIi$$$^$;(B
;;	$B$s!#%3%a%s%H$d%P%0%l%]!<%H$O$*$*$$$K4?7^$7$^$9$N$G8f5$7Z$K8fO"Mm(B
;;	$B$/$@$5$$!#$^$?%W%m%0%i%`$KBP$9$k8D?ME*$J=$@5$O<+M3$K$7$FD:$$$F9=(B
;;	$B$$$^$;$s$,!"$=$l$r8x3+$7$?$$>l9g$O;d$^$G8fO"Mm$/$@$5$$!#O"Mm$O0J(B
;;	$B2<$N%"%I%l%9$^$G$*4j$$$7$^$9(B(2003/11$B8=:_(B)$B!#(B
;;							yuuji@gentei.org

(if (featurep 'xemacs)
    (require 'itimer)
  (require 'timer))

(defvar biff-j (or (featurep 'mule) (boundp 'mule) (boundp 'nemacs))
  "Japanese")

(defvar biff-pop-port	110 "POP3$B$N%]!<%HHV9f(B")
(defvar biff-imap-port	143 "IMAP$B$N%]!<%HHV9f(B")
(defvar biff-account-alist nil "$B%"%+%&%s%H>pJs$r;}$C$?(Balist
'(($B%"%+%&%s%HL>(B (server . $B%5!<%P(B) (user . $B%f!<%6L>(B) (proto . $B%W%m%H%3%k(B))
   $B!D(B)
$B!V%W%m%H%3%k!W$O(B pop, apop, imap, imap/auth, mbox, maildir $B$N(B
$B$I$l$+(B($B$$$:$l$b%7%s%\%k(B)")
(defvar biff-check-interval 600
  "$B%P%C%/%0%i%&%s%I%b!<%I$N>l9g$N?7Ce%A%'%C%/$9$k4V3V(B")
(defvar biff-mbox-check-threshold 100000
  "mbox$B7A<0$N$H$-$NE~C#?t$r%A%'%C%/$9$k>e8B%P%$%H?t(B")
(defvar biff-autoraise t "$B%_%K%P%C%U%!$rI=$K=P$9$+(B")
(defvar biff-use-modeline t "$B%b!<%I%i%$%s$K=P$9$+(B")
(defvar biff-use-beep t "Beep$B2;$rLD$i$9$+(B")
(defvar biff-use-beep-visible nil "Beep$B2;$r;k3P%Y%k$K$9$k$+(B")

;;;
; Variables for Internal Work
(defvar biff-process nil "POP3$B@\B3$rJ];}$9$k%W%m%;%9(B")
(defvar biff-buffer " *biff*" "POP3$B@\B3$rJ];}$9$k%P%C%U%!(B")
(defvar biff-user nil "$B%f!<%6L>(B")
(defvar biff-pass1 nil "$B:#BG$C$?%Q%9%o!<%I(B")

(defvar biff-current-account nil "$B8=:_$N%"%+%&%s%HL>(B")
(defvar biff-current-user nil "$B8=:_$N@\B3$N%f!<%6L>(B")
(defvar biff-current-proto nil "$B8=:_$N@\B3$N%W%m%H%3%k(B")
(defvar biff-current-status nil "$B8=:_$N>uBV(B
'start	$B3+;OD>8e(B
'user	$B%f!<%6Aw?.A0(B
'pass	$B%Q%9%o!<%IAw?.A0(B
'cmd	$B%3%^%s%IF~NOBT$A(B
'stat	stat$B7k2LBT$A(B")
(defvar biff-check-queue nil "$B%-%e!<(B")
(defvar biff-modeline-string nil)
(defvar biff-modeline-arrival-list nil)
(defvar biff-debug nil)
(defvar biff-debug-buffer "*biff-debug*")

(if biff-use-modeline
    (progn
      (or global-mode-string (setq global-mode-string '("")))
      (or (memq 'biff-modeline-string global-mode-string)
	  (setq global-mode-string
		(append global-mode-string '(biff-modeline-string))))))

(defun biff-debug-output (string)
  (let ((cb (current-buffer)))
    (unwind-protect
	(progn
	  (set-buffer (get-buffer-create biff-debug-buffer))
	  (goto-char (point-max))
	  (insert
	   (format "%s.%06d %s\n"
		   (substring (current-time-string)  11 19)
		   (nth 2 (current-time)) string)))
      (set-buffer cb))))
   
(defun biff-send-command (mess)
  "POP3$B%5!<%P$K%3%^%s%I$rAw?.$9$k(B($B9TKv$r(BCRLF$B$G(B)"
  (if (eq (process-status biff-process) 'open) ;$B%=%1%C%H$,3+$$$F$$$k$J$i(B
      (let ((cr (if (memq system-type '(ms-dos windows-nt OS/2)) "" "\r")))
	(process-send-string biff-process (format "%s%s\n" cr mess))
	(if biff-debug (biff-debug-output (concat "SEND: " mess))))))

(defun biff-notify (num &optional size)
  (if (stringp num) (setq num (string-to-int num)))
  (if (stringp size) (setq size (string-to-int size)))
  (cond
   ((and window-system (fboundp 'make-frame) nil biff-use-frame)
    )
   (t
    (cond
     ((and (stringp (current-message))
	   (string-equal (current-message) (get 'biff-notify 'lastmsg)))
      ;;(message "$B$5$C$-$N%a%$%k$OFI$s$8$c$C$?$_$?$$(B")
      )
     ((> num 0)
      (if biff-use-modeline
	  (setq biff-modeline-arrival-list
		(cons (cons biff-current-account num)
		      biff-modeline-arrival-list)))
      (put 'biff-notify 'lastmsg
	   (format (cond
		    (biff-j "%s $B$K(B %d $BDL(B%s$B$N%a%$%k$,FO$$$F$$$^$9(B")
		    (t "%s: %d message(s) %s"))
		   biff-current-account
		   num
		   (if size (format " %d bytes" size) "")))
      (and biff-autoraise window-system (fboundp 'raise-frame)
	   (raise-frame (car (minibuffer-frame-list))))
      (biff-ding)
      (message (get 'biff-notify 'lastmsg))
      (if (featurep 'xemacs)
	  (sit-for 3 nil)
	(sit-for 3 nil t)))
     (t )))))

(defun biff-close-end ()
  "$B%a%C%;!<%8=PNO8e(B. $B@\B3$rJD$8$F=*N;(B"
  (if (and biff-process		;$B%=%1%C%H$,@8$-$F$$$k$3$H$N3NG'(B
	   (eq (process-status biff-process) 'open))
      (delete-process biff-process));close$B$O(B delete-process $B$K$F9T$&(B
  (setq biff-process nil		;$BJQ?t$r%/%j%"(B
	biff-current-status nil
	biff-current-account nil
	biff-current-proto nil)
  (if biff-check-queue
      (let ((next (car biff-check-queue)))
	(setq biff-check-queue (cdr biff-check-queue))
	(biff next))
    ;;the end of list
    (if biff-modeline-arrival-list
	(setq biff-modeline-string
	      (concat
	       "("
	       (mapconcat
		  (function
		   (lambda (s) (concat (car s) ":"
				       (int-to-string (cdr s)))))
		  biff-modeline-arrival-list
		  ",")
	       ")"))
      ;(setq biff-modeline-string "(NoMail)")
      )
    (set-buffer-modified-p (buffer-modified-p))
    (sit-for 0)
    (unwind-protect
	(sit-for (/ biff-check-interval 2))
      (setq biff-modeline-string nil
	    biff-modeline-arrival-list nil)
      ;(message (current-message))
      (sit-for 0))
    ))

(defun biff-ding ()
  "Beep$B2;$rLD$i$9(B"
  (if biff-use-beep
      (let ((visible-bell biff-use-beep-visible))
	(ding t))))

(defun biff-get-pass ()
  "$B%+%l%s%H%"%+%&%s%HMQ$N%Q%9%o!<%I<hF@(B"
  (or (get 'biff-get-pass 'ary)
      (put 'biff-get-pass 'ary (make-vector 127 nil)))
  (let*((ar (get 'biff-get-pass 'ary))
	(f (function (lambda (s)
		       (if (boundp (intern s ar))
			   (symbol-value (intern s ar)))))))
    (if (and biff-process (eq (process-status biff-process) 'open))
	(or (funcall f biff-current-account)
	    (read-passwd (format "Password(%s): " biff-current-account)))
      (read-passwd "Password: "))))

(defun biff-set-pass (str &optional account)
  "$B%+%l%s%H%"%+%&%s%HMQ$N%Q%9%o!<%I@_Dj(B"
  (or (get 'biff-get-pass 'ary)
      (put 'biff-get-pass 'ary (make-vector 127 nil)))
  (let ((ac (or account biff-current-account)) (i 0))
    (if (eq				;eq is correct
	 (and (boundp (intern ac (get 'biff-get-pass 'ary)))
	      (symbol-value (intern ac (get 'biff-get-pass 'ary))))
	 str) nil
      (set (intern ac (get 'biff-get-pass 'ary))
	   (copy-sequence str))
      (and str (stringp str) (string< "" str)
	   (while (< i (length str))
	     (aset str i ?.)
	     (setq i (1+ i)))))))

(defun biff-warn (mesg)
  "Put warning message"
  (message "%s%s"
	   mesg
	   (if biff-current-account (format "(%s)" biff-current-account) "")))

(defvar biff-fail-count 0)

(defun biff-fail ()
  "Count failure and stop background check at 3 times failure."
  (if (> (setq biff-fail-count (1+ biff-fail-count)) 2)
      (biff-cancel-background))
  (biff-close-end))

(defun biff-filter (proc message)
  "POP3$B%5!<%P$+$i$N%a%C%;!<%8$r<u$1<h$k(B"
  (let ((stat biff-current-status))
    (if biff-debug
	(biff-debug-output
	 (format "RECV(%s): %s" biff-current-account message)))
    (cond
     ((null stat)
      ;(biff-close-end "")
      (and biff-process (eq (process-status biff-process) 'open)
	   (progn
	     (delete-process biff-process)
	     (setq biff-process nil))))
     ((eq stat 'start)			;$B3+;OD>8e$J$i(B
      (if (string-match "OK" message)
	  (cond
	   ((eq biff-current-proto 'apop)
	    (if (string-match "<.+>" message)
		(let ((clg (substring message
				      (match-beginning 0) (match-end 0))))
		  (require 'md5)
		  (setq biff-pass1 (biff-get-pass))
		  (biff-send-command
		   (format "APOP %s %s"
			     biff-current-user
			     (md5 (concat clg biff-pass1))))
		  (setq biff-current-status 'cmd))
	      (biff-send-command "quit")
	      (biff-warn
	       (cond
		(biff-j "$B%5!<%P$O(BAPOP$B$KBP1~$7$F$$$^$;$s(B")
		(t "POP Server doesn't accept APOP")))
	      (biff-fail)))
	   ((eq biff-current-proto 'pop);;$BIaDL$N(BPOP
	    (biff-send-command (concat "user " biff-current-user))
	    (setq biff-current-status 'pass))
	   ((eq biff-current-proto 'imap)
	    (setq biff-pass1 (biff-get-pass))
	    (biff-send-command (format "biff.el LOGIN %s %s"
				       biff-current-user biff-pass1))
	    (setq biff-current-status 'cmd))
	   ((eq biff-current-proto 'imap/auth)
	    (require 'base64)
	    (biff-send-command "biff.el AUTHENTICATE LOGIN")
	    (setq biff-current-status 'user)
	   ))
	(biff-warn
	 (cond
	  (biff-j "$B%5!<%P$X$N@\B3$K<:GT$7$^$7$?(B")
	  (t "Could not establish connecton to server")))
	(biff-fail)))
     ((eq stat 'user)			;imap4/auth
      (if (and (string-match "^\\+ \\(\\S +\\)" message)
	       (string-match
		"User"
		(base64-decode
		 (substring message (match-beginning 1) (match-end 1)))))
	    (progn
	      (biff-send-command (base64-encode biff-current-user))
	      (setq biff-current-status 'pass))))
     ((eq stat 'pass)			;$B%Q%9%o!<%IBT$A$J$i(B
      (cond
       ((eq biff-current-proto 'imap/auth)
	(if (and (string-match "^\\+ \\(\\S +\\)" message)
		 (string-match
		  "Pass"
		  (base64-decode
		   (substring message (match-beginning 1) (match-end 1)))))
	    (progn
	      (setq biff-pass1 (biff-get-pass))
	      (biff-send-command (base64-encode biff-pass1))
	      (setq biff-current-status 'cmd))))
       (t
	(if (string-match "OK" message)
	    (progn
	      (setq biff-pass1 (biff-get-pass))
	      (biff-send-command
	       (concat "pass " biff-pass1))
	      (setq biff-current-status 'cmd))
	  (biff-warn (cond
		      (biff-j "$B%f!<%6L>$,0c$$$^$9(B")
		      (t "Invalid login name")))
	  (biff-fail)))))
     ((eq stat 'cmd)			;$B%3%^%s%IBT$A$J$i(B
      (cond
       ((memq biff-current-proto '(imap imap/auth))
	(if (string-match "OK" message)
	    (progn
	      (biff-send-command "biff.el SELECT inbox")
	      (setq biff-current-status 'stat))
	  (biff-warn (cond
		      (biff-j "$B%Q%9%o!<%I$,0c$$$^$9(B")
		      (t "Password incorrect")))
	  (biff-set-pass nil)
	  (biff-fail)))
       ((memq biff-current-proto '(pop apop))
	(if (string-match "^\\+OK" message)
	    (progn
	      (biff-send-command "stat")
	      (setq biff-current-status 'stat))
	  ;;else, some error occurs
	  (cond
	   ((string-match "lock" message)
	    (biff-warn
	     (cond (biff-j "$BB>$N(BPOP$B%/%i%$%"%s%H$K$h$C$F(Block$B$5$l$F$$$^$9(B")
		   (t "POP locked by other pop-client"))))
	   (t
	    (biff-warn (cond (biff-j "$B%Q%9%o!<%I$,0c$$$^$9(B")
			     (t "Password incorrect")))
	    (biff-set-pass nil)))
	  (biff-fail)))))
     ((eq stat 'stat)			;stat$B7k2LBT$A$J$i(B
      (set-process-filter biff-process nil) ;$B$b$&%U%#%k%?$OITMW(B
      (let*((unknown (cond (biff-j "$BITL@(B") (t "unknown")))
	    (m message) (n "$BITL@(B") (s ))
	(cond
	 ((memq biff-current-proto '(imap imap/auth))
	  (if (string-match "^\\* \\([0-9]+\\)\\s EXISTS" m)
	      (put 'biff-filter 'auth/exists
		   (string-to-int
		    (substring m (match-beginning 1) (match-end 1)))))
	  (if (string-match "^\\* \\([0-9]+\\)\\s RECENT" m)
	      (put 'biff-filter 'auth/recent
		   (string-to-int
		    (substring m (match-beginning 1) (match-end 1)))))
	  (if (and (get 'biff-filter 'auth/exists)
		   (get 'biff-filter 'auth/recent))
	      (progn
		(setq n (+ (get 'biff-filter 'auth/exists)
			   (get 'biff-filter 'auth/recent))
		      biff-current-status nil)
		(biff-send-command "biff.el LOGOUT")
		(biff-set-pass biff-pass1)
		(setq biff-pass1 nil)
		(biff-notify n)
		(put 'biff-filter 'auth/exists nil)
		(put 'biff-filter 'auth/recent nil)
		(biff-close-end)))
	  )
	 ((and (memq biff-current-proto '(pop apop))
	       (string-match "^\\+OK" m))
	  (cond
	   ((string-match "OK\\s \\([0-9]+\\) \\([0-9]+\\)" m);ipop3d
	    (setq n (substring m (match-beginning 1) (match-end 1))
		  s (substring m (match-beginning 2) (match-end 2))))
	   ((string-match "OK.*\\([0-9]+\\)\\s *message.*\\([0-9]+\\)" m)
	    ;;QPOP
	    (setq n (substring m (match-beginning 1) (match-end 1))
		  s (substring m (match-beginning 2) (match-end 2)))))
	  (biff-send-command "quit")
	  (setq biff-current-status nil)
	  (biff-set-pass biff-pass1)
	  (setq biff-pass1 nil)
	  (biff-notify n s)
	  (biff-close-end))
	 (t (biff-warn (cond (biff-j "STAT$B$G$-$^$;$s$G$7$?(B")
			     (t "Couldn't STAT")))
	    (biff-fail)))))
     (t
      (biff-warn (cond (biff-j "$BNI$/J,$+$i$J$$%(%i!<$,=P$^$7$?(B.")
		       (t "Unexpedted error occured")))
      (biff-fail)))))

(defvar biff-maildir (or (getenv "MAILDIR") "~/maildir"))

(defun biff-check-maildir (dir)
  (let ((flist (append (directory-files (concat dir "/cur") 'fullpath)
		       (directory-files (concat dir "/new") 'fullpath)))
	(n 0) (s 0))
    (while flist
      (if (file-regular-p (car flist))
	  (setq n (1+ n)
		s (nth 7 (file-attributes (car flist)))))
      (setq flist (cdr flist)))
    (if (> n 0)
	(biff-notify n s))
    (biff-close-end)))

(defun biff-check-mbox (file)
  (let ((tb (get-buffer-create " *bifftmp* "))
	(n 0) (s 0) (case-fold-search nil))
    (save-excursion
      (set-buffer tb)
      (erase-buffer)
      (setq s (nth 7 (file-attributes file)))
      (if (> s biff-mbox-check-threshold)
	  (setq n "$B$?$/$5$s(B")
	(unwind-protect
	    (progn
	      (insert-file-contents file)
	      (while (re-search-forward "^From " nil t)
		(setq n (1+ n))))
	  (kill-buffer tb)))
      (if (> s 0)
	  (biff-notify n s)))
    (biff-close-end)))

; (defun biff (host user)
;   "HOST $B$K(BPOP3$B@\B3$7$F(B USER $B08$N%a%$%k$,$"$k$+D4$Y$k(B"
;   (interactive "sPOP3 server: \nsUser: ")
;   (setq biff-user user)
;   ;;$B:G=i$O%f!<%6F~NOBT$A>uBV(B
;   (setq biff-current-status 'start)
;   ;;$B%=%1%C%H@\B3%W%m%;%9$N3+;O(B
;   (setq biff-process
; 	(open-network-stream "biff" biff-buffer host biff-port))
;   ;;$B@\B3(B
;   (set-process-filter biff-process 'biff-filter))
(defun biff (account)
  (interactive
   (list (completing-read "Account: " biff-account-alist)))
  (let* ((account-info (cdr-safe (assoc account biff-account-alist)))
	 (server (cdr-safe (assq 'server account-info)))
	 (user (cdr-safe (assq 'user account-info)))
	 (proto (cdr-safe (assq 'proto account-info))))
    (or proto (setq proto
		    (intern (completing-read
			     "Protocol: "
			     '(("pop") ("apop") ("imap") ("imap/auth")
			       ("maildir") ("mbox"))
			     nil t))))
    (or server
	(cond
	 ((eq proto 'maildir)
	  (while (not (file-directory-p
		       (setq server (read-file-name "Maildir: "))))))
	 ((eq proto 'mbox)
	  (setq server (read-file-name "Mbox: " "" nil t (getenv "MAIL"))))
	 (t
	  (setq server (read-string "Server Host Name: ")))))
    (or user
	(memq proto '(mbox maildir))
	(setq user (read-string "User Name: " (user-login-name))))
    (setq biff-account-alist
	  (delq (assoc account biff-account-alist) biff-account-alist)
	  biff-account-alist
	  (cons (cons account (list (cons 'server server)
				    (cons 'user user)
				    (cons 'proto proto)))
		biff-account-alist))
    (setq biff-current-account account
	  biff-current-status 'start
	  biff-current-user user
	  biff-current-proto proto)
    (cond
     ((memq proto '(pop apop imap imap/auth))
      (setq biff-process
	    (open-network-stream
	     "biff" biff-buffer server
	     (if (memq proto '(pop apop))
		       biff-pop-port
	       biff-imap-port)))
      (set-process-filter biff-process 'biff-filter))
     ((eq proto 'maildir)
      (biff-check-maildir server))
     ((eq proto 'mbox)
      (biff-check-mbox server)))))

(defun biff-do-list (account-list)
  "$BJ#?t$N%"%+%&%s%H$rO"B3E*$K%A%'%C%/$9$k(B"
  (setq biff-check-queue (cdr account-list))
  (biff (car account-list)))

(defun biff-all ()
  "$BA4It%A%'%C%/(B"
  (interactive)
  (biff-do-list (mapcar 'car biff-account-alist)))

(defun biff-background-all ()
  "$BA4$F$N%j%9%H$N%A%'%C%/(B"
  (interactive)
  (biff-cancel-background)
  (if (featurep 'itimer)
      (start-itimer "biff" 'biff-all 1 biff-check-interval)
    (run-with-timer 1 biff-check-interval 'biff-all)))

(defun biff-background (account)
  "$B0l2U=j$N%A%'%C%/(B"
  (interactive
   (list (completing-read "Account: " biff-account-alist)))
  (biff-cancel-background)
  (if (featurep 'itimer)
      (start-itimer "biff" 'biff 1 biff-check-interval nil t account)
    (run-with-timer 1 biff-check-interval 'biff account)))

(defun biff-background-list (list)
  "LIST$B$G;XDj$7$?2U=j$N%A%'%C%/(B"
  (interactive
   (let (l s)
     (while (string< "" (setq s (completing-read
				 "Account (RET Only to quit): "
				 biff-account-alist
				 (function
				  (lambda (s)
				    (not (member (car s) l))))
				 t)))
       (setq l (cons s l)))
     (list l)))
  (biff-cancel-background)
  (if (featurep 'itimer)
      (start-itimer "biff" 'biff-do-list 1 biff-check-interval nil t list)
    (run-with-timer 1 biff-check-interval 'biff-do-list list)))

(defun biff-cancel-background ()
  "$B%P%C%/%0%i%&%s%I%A%'%C%/$N%-%c%s%;%k(B"
  (interactive)
  (setq biff-fail-count 0)
  (cond ((featurep 'itimer)
	 (let ((timer (get-itimer "biff")))
	   (and timer
		(delete-itimer timer))))
	(t
	 (if (string< "19.34" emacs-version)
	     (progn
	       (cancel-function-timers 'biff)
	       (cancel-function-timers 'biff-do-list)
	       (cancel-function-timers 'biff-all))))))

(defun biff-change-interval (secs)
  (interactive "nCheck Interval: ")
  (setq biff-check-interval secs)
  (cond ((featurep 'itimer)
	 (let ((timer (get-itimer "biff")))
	   (and timer
		(set-itimer-restart timer biff-check-interval))))
	(t
	 (let ((list timer-list))		;timer-list is in the timer.el
	   (while list
	     (if (memq (aref (car list) 5) '(biff biff-do-list biff-all))
		 (progn
		   (timer-set-idle-time (car list) 1 biff-check-interval)
		   (message "Running %s's interval reset to %d"
			    (aref (car list) 5) biff-check-interval)
		   (sit-for 1)))
	     (setq list (cdr list)))))))

(defun biff-save-accounts (arg)
  "$B8=:_$N%"%+%&%s%H%j%9%H$r(B ~/.emacs $B$K=q$-=P$9(B.
Universal argument $B$r$D$1$k$HJL$N%U%!%$%k$K=P$9(B."
  (interactive "P")
  (let ((file (if arg (read-file-name "Account Output file: ") "~/.emacs"))
	(bal biff-account-alist))
    (find-file file)
    (goto-char (point-min))
    (if (search-forward "(setq biff-account-alist" nil t)
	(delete-region
	 (progn (goto-char (match-beginning 0)) (point))
	 (progn (forward-list 1) (point)))
      (goto-char (point-max))
      (or (= (current-column) 0) (insert ?\n)))
    (insert "(setq biff-account-alist\n  '(")
    (while bal
      (lisp-indent-line)
      (insert (format "%s\n" (prin1-to-string (car bal))))
      (setq bal (cdr bal)))
    (delete-backward-char 1)
    (insert "))\n")))

(eval-when-compile
  (load "md5" t)
  (load "base64" t)
  (if (featurep 'xemacs)
      (require 'itimer)
    (require 'timer)))

(provide 'biff)

; Local variables:
; fill-prefix: ";;	"
; paragraph-start: "^$\\|\\|;;$"
; paragraph-separate: "^$\\|\\|;;$"
; End:
