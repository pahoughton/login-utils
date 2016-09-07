#
# File:		acinclude.m4
# Project:	LoginUtils
# Desc:
#
#   Project specific m4 macros
#
# Notes:
#
# Author(s):   Paul Houghton <paul4hough@gmail.com>
# Created:     06/05/2003 19:23
#
#

AC_DEFUN([PAH_EMAIL_ADDR],
[ AC_ARG_WITH( email,
  AC_HELP_STRING([--with-email],[your email address]),
  [ email="$withval"
    AC_MSG_RESULT([$email])],
  [ if test x${email+set} != xset; then
      AC_CACHE_CHECK([your email address], [pah_cv_email],
      [
      if test -n "$REPLYTO" ; then
        pah_cv_email="$REPLYTO";
      else
        # try to snach it from /etc/passwd
	pah_cv_email=`$AWK  -F : "/$LOGNAME/ { print tolower(\$5) }" < /etc/passwd | sed -e 's/\([A-Za-z ]*[A-Za-z]\).*/\1/' | tr ' ' '.'`
	if test -z "$pah_cv_email" ; then
	  pah_cv_email="FIXME.UNKNOWN@unknown.com"
        else
	  pah_cv_email="${pah_cv_email}"
	fi
      fi
      ])
      email="$pah_cv_email"
    fi
  ])
  AC_SUBST(email)
])

AC_DEFUN([PAH_USERNAME],
[ AC_ARG_WITH( username,
  AC_HELP_STRING([--with-username],[your full name]),
  [ username="$withval"
    AC_MSG_RESULT([$username])],
  [ if test x${username+set} != xset; then
      AC_CACHE_CHECK([your full name], [pah_cv_username],
      [
      pah_cv_username=`grep "^$USER" /etc/passwd | cut -d : -f 5`
      ])
      username="$pah_cv_username"
    fi
  ])
  AC_SUBST(username)
])

AC_DEFUN([PAH_HOSTNAME],
[ AC_ARG_WITH( hostname,
  AC_HELP_STRING([--with-hostname],[this systems hostname]),
  [ hostname="$withval"
    AC_MSG_RESULT([$hostname])],
  [ if test x${hostname+set} != xset; then
      AC_CACHE_CHECK([this systems hostname], [pah_cv_hostname],
      [pah_cv_hostname=`hostname -s || uname -n`])
      hostname=$pah_cv_hostname
    fi
  ])
  AC_SUBST(hostname)
])

AC_DEFUN([PAH_OSNAME],
[ AC_ARG_WITH( osname,
  AC_HELP_STRING([--with-osname],[this systems os name (Linux,Darwin...]),
  [ osname="$withval"
    AC_MSG_RESULT([$osname])],
  [ if test x${osname+set} != xset; then
      AC_CACHE_CHECK([this systems osname], [pah_cv_osname],
      [pah_cv_osname=`uname -s`])
      osname=$pah_cv_osname
    fi
  ])
  AC_SUBST(osname)
])

AC_DEFUN([PAH_CVSROOT],
[ AC_ARG_WITH( cvsroot,
  AC_HELP_STRING([--with-cvsroot],[value for CVSROOT env var]),
  [ cvsroot="$withval"
    AC_MSG_RESULT([$cvsroot])],
  [ if test x${cvsroot+xset} != xset; then
      AC_CACHE_CHECK([value for CVSROOT env var], [pah_cv_cvsroot],
      [
      if test x${CVSROOT+set} == xset ; then
	pah_cv_cvsroot=$CVSROOT
      fi
      ])
      cvsroot="$pah_cv_cvsroot"
    fi
  ])
  AC_SUBST(cvsroot)
])

AC_DEFUN([PAH_HTTP_PROXY],
[ AC_ARG_WITH( http_proxy,
  AC_HELP_STRING([--with-http-proxy],[value for http_proxy env var]),
  [ http_proxy="$withval"
    AC_MSG_RESULT([$http_proxy])],
  [ if test x${http_proxy+xset} != xset; then
      AC_CACHE_CHECK([value for http_proxy env var], [pah_cv_http_proxy],
      [
      if test x${http_proxy+set} == xset ; then
	pah_cv_http_proxy=$http_proxy
      fi
      ])
      http_proxy="$pah_cv_http_proxy"
    fi
  ])
  AC_SUBST(http_proxy)
])

AC_DEFUN([PAH_HTTPS_PROXY],
[ AC_ARG_WITH( https_proxy,
  AC_HELP_STRING([--with-https-proxy],[value for https_proxy env var]),
  [ https_proxy="$withval"
    AC_MSG_RESULT([$https_proxy])],
  [ if test x${https_proxy+xset} != xset; then
      AC_CACHE_CHECK([value for https_proxy env var], [pah_cv_https_proxy],
      [
      if test x${https_proxy+set} == xset ; then
	pah_cv_https_proxy=$https_proxy
      fi
      ])
      https_proxy="$pah_cv_https_proxy"
    fi
  ])
  AC_SUBST(https_proxy)
])
