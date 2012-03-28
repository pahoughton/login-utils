;;
;;  File:	template-insert.el
;;  Project:	EmacsTemplates
;;  Desc:
;;
;;	Insert a template into the current buffer.
;;  
;;  Notes:
;;    
;;  Author(s):   Paul Houghton <pahoughton@users.sourceforge.net>
;;  Created:     08/17/2001 13:20
;;  
;;  Revision History: (See ChangeLog for Details)
;;  
;;	$Author$
;;	$Name$
;;	$Date$
;;	$Revision$
;;	$State$
;;
;;  $Id$
;;

;;
;; We need to load custom before initialization
;;
(setq custom-file (concat (getenv "HOME")
              "/.xemacs/customize-"
              (number-to-string emacs-major-version)
              "."
              (number-to-string emacs-minor-version)
	      ".el"))

(let ((real-custom-file custom-file))
  (setq custom-file "nonsense")
  (load real-custom-file)
  (add-hook 'after-init-hook
	    `(lambda () (setq custom-file ,real-custom-file)))
  )

(load (concat (getenv "HOME")
              "/.xemacs/init-" (format "%s" system-type)))


(require 'dired)
(require 'font-lock)
(mwheel-install)

; Frame & Icon title
(setq-default frame-title-format (concat "XEmacs: %b@" (system-name)))
(setq-default frame-icon-title-format (concat "XEmacs: %b@" (system-name)))

; My Email Address
(setq user-mail-address (or (getenv "REPLYTO")
			    "paul.houghton@mci.com"))


;; load minibuffer history
;(savehist-load)

;;
;; func-menu Auto loads
;;
(autoload 'fume-add-menubar-entry			"func-menu"
  "Add `Function' menu to the menu bar" )
(autoload 'mouse-function-menu				"func-menu"
  "Popup function menu" t)
(autoload 'fume-mouse-function-goto			"func-menu"
  "Goto function clicked on or prompt in minibuffer" t )
(autoload 'fume-prompt-function-goto			"func-menu"
  "Goto function prompted for in minibuffer" t )

;;
;; Misc auto loads
;;
(autoload 'insert-classname				"insert-classname"
  "Insert current classname" t )
(autoload 'insert-classname-inline			"insert-classname"
  "Insert inline funct for class" t)
(autoload 'insert-classname-template			"insert-classname"
  "Insert template funct for class" t )

(autoload 'find-header					"find-header"
  "find header file" t)

(autoload 'goto-matching-paren				"goto-matching-paren"
  "Goto the matching paren" )

; find other file

;(autoload 'ff-find-other-file				"find-file"
;  "find other file .C - .hh or include file" t )
;(autoload 'ff-mouse-find-other-file			"find-file"
;  "Visit the file you click on." t )

(setq-default cc-search-directories
	      (append (list "."
			    "../lib*/"
			    (concat
			     (getenv (concat (getenv "PROJECT")
					     "_PRJ_TOPDIR"))
			     "/include")
			    (concat (getenv "TOOL_DIR") "/include/*"))
		      system-cc-search-directories))

; recent files
(require 'recent-files)
(recent-files-initialize)

; turn on auto fill for text mode
(setq text-mode-hook 'turn-on-auto-fill)

; tab stops
(setq tab-stop-list '(  4   8  12  16  20  24  28  32  36  40 
		       44  48  52  56  60  64  68  72  76  80
		       84  88  92  96 100 104 108 112 116 120
		      124 128 132 136 140 144 148 152 156 160 ) )

; show me what time it is
(display-time)

;;
;; Keyboard customizations
;;
(define-key global-map '(return)    	'newline-and-indent)
(define-key global-map 'f10		'compile)
(define-key global-map 'f1		'info)
(define-key global-map '(meta f5)	'template-insert)
(define-key global-map 'f12		'find-header)
(define-key global-map '(meta c)	'kill-ring-save)
(define-key global-map '(meta v)	'yank)
(global-unset-key '(control z))

;;
;; C, C++ & ObjC Customizations
;;


(require 'cc-mode)
(defun site-c-mode-common-hook () 
  (font-lock-mode)
  (setq c-basic-offset 2)
  (c-set-offset 'arglist-intro '+ )
  
  (local-set-key    'f8			'fume-add-menubar-entry )
  (local-set-key    '(shift f8)		'fume-prompt-function-goto )
  
  (local-set-key    '[(control c) (o)]  'ff-find-other-file)
  (local-set-key    '(control button3)	'ff-mouse-find-other-file )
  
;;  (local-set-key    '(%)		'goto-matching-paren)
  )

(add-hook 'c-mode-common-hook 'site-c-mode-common-hook)

(defun site-c++-mode-hook ()
  (local-set-key 'f2 	    	'insert-classname)
  (local-set-key '(shift f2)   	'insert-classname-inline)
  (local-set-key '(control f2) 	'insert-classname-template)
  )
 
(add-hook 'c++-mode-hook 'site-c++-mode-hook)


;;
;; CPerl
;;

(defun my-cperl-hook ()
  (local-set-key    '[(control h) (f)]	'cperl-perldoc-at-point )
  
  (local-set-key    'f8			'fume-add-menubar-entry )
  (local-set-key    '(shift f8)		'fume-prompt-function-goto )
  
  (local-set-key    '(%)		'goto-matching-paren)
  )

;;
;; Dired
;;

(defun site-dired-load-hook () 
  ;; (require 'dired-x)
  (require 'crypt)
  )

(defun site-dired-mode-hook ()
  (setq dired-omit-files-p t)
  (setq truncate-lines t)
  )

(add-hook 'dired-mode-hook 'site-dired-mode-hook)
(setq dired-load-hook 'site-dired-load-hook)

(defun query-really-exit ()
  "ask the user if they really want to exit XEmacs"
  (y-or-n-p "Really exit XEmacs? ")
  )

(add-hook 'kill-emacs-query-functions 'query-really-exit)

;
; Psgml
;
(setq-default sgml-indent-data t)

;;
;; ksh-mode
;;
(setq ksh-mode-hook
      (function (lambda ()
		  (setq ksh-case-indent 2)
		  )))


; Auto-mode-alist - The mode to use for specific file names

(setq auto-mode-alist
      (append
       (list
	'("\\.ii$"	. c++-mode)
	'("\\.mk$"	. makefile-mode)
	'("\\.mak$"	. makefile-mode)
	'("^make\\.cfg" . makefile-mode)
	'("\\.sql$"	. sql-mode)
	'("\\.ddl$"	. sql-mode)
	'("\\.xml$"	. xml-mode)
;	'("status" . text-mode)
;	'("^log" . text-mode)
;	'("\\.dcl$" . dtd-mode)
;	'("\\.dec$" . dtd-mode)
;	'("\\.dtd$" . dtd-mode)
;	'("\\.ele$" . dtd-mode)
;	'("\\.ent$" . dtd-mode)
;	'("\\.mod$" . dtd-mode)
;	'("\\.php$" . php-mode)
	'("configure.ac" . autoconf-mode)
	)
       auto-mode-alist))

