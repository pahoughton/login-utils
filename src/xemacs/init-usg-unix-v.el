;;
;;  File:	init-usg-unix-v.el
;;  Project:	XEmacs 
;;  Desc:
;;
;;	Emacs Lisp source
;;  
;;  Notes:
;;    
;;  Author(s):   Paul Houghton 719-527-7834 <<paul.houghton@wcom.com>>
;;  Created:     04/19/2003 16:58
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

(defvar system-short-name (system-name))

(setq system-cc-search-directories
      (list "/opt/SUNWspro/WS6U2/include/CC/*"
	    "/opt/SUNWspro/WS6U2/include/cc/*"
	    "/usr/include/*" ))
