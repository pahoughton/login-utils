;;
;;  File:	customize-21.4.el
;;  Project:	Login 
;;  Desc:
;;
;;	Emacs Lisp source
;;  
;;  Notes:
;;    
;;  Author(s):   Paul Houghton <<paul.houghton@wcom.com>>
;;  Created:     05/16/2003 04:20
;;  
;;  Revision History: (See end of file for Revision Log)
;;  
;;	$Author$
;;	$Date$
;;	$Name$
;;	$Revision$
;;	$State$
;;
;;  $Id$
;;

;;
;; Customization variables
;;
(custom-set-variables
 '(recent-files-menu-path (quote ("File")))
 '(dired-verify-modtimes nil)
 '(cvs-edit-confirm (quote changed))
 '(explicit-bash-args (quote ("-li")))
 '(recent-files-non-permanent-submenu nil)
 '(recent-files-add-menu-before "Open...")
 '(mode-compile-make-options "")
 '(shell-file-name "/bin/bash")
 '(ediff-window-setup-function (quote ediff-setup-windows-plain)))
;; (custom-set-faces
;; '(default ((t (:size "8pt" :family "Courier New"))) t))
