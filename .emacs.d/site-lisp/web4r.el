; web4r.el
; 
; Copyright (c) Tomoyuki Matsumoto
; BSD license - http://www.opensource.org/licenses/bsd-license.php
; 
; Configurations:
;  1. Make sure web4r.el is in your load-path
;  2. Add following line to your .emacs file
;     (load "web4r")

; Note: this elisp affects entire lisp mode.

(add-to-list 'auto-mode-alist (cons "\\.sml$" 'lisp-mode))

(setf lisp-mode-syntax-table
  (let ((table (copy-syntax-table emacs-lisp-mode-syntax-table)))
    (modify-syntax-entry ?[ "(^" table)
    (modify-syntax-entry ?] ")$" table)
    table))

(defun web4r-face (symbol face)
  (let ((r (concat "\\([^']\\|^\\)(\\(" (symbol-name symbol) "\\)[ \n)]")))
    (font-lock-add-keywords 'lisp-mode (list (list r 2 face)))))

(defun web4r-func (symbol indent face)
  (put symbol 'lisp-indent-function indent)
  (web4r-face symbol face))

(put 'defpage 'lisp-indent-hook 'defun)
(web4r-face 'defpage 'font-lock-keyword-face)
(web4r-face 'define-validator 'font-lock-keyword-face)

(web4r-func 'when-let        1    'font-lock-keyword-face)
(web4r-func 'aif             0    'font-lock-keyword-face)
(web4r-func 'awhen           1    'font-lock-keyword-face)
(web4r-func 'aand            nil  'font-lock-keyword-face)
(web4r-func 'define-shtml    nil  'font-lock-keyword-face)
(web4r-func 'form-for/cont   1    'font-lock-function-name-face)
(web4r-func 'a/cont          1    'font-lock-function-name-face)
(web4r-func 'form/cont       1    'font-lock-function-name-face)
(web4r-func 'page-lambda     2    'font-lock-keyword-face)
(web4r-func 'defpclass       3    'font-lock-keyword-face)
(web4r-func 'with-new-cookie 0    'font-lock-keyword-face)
