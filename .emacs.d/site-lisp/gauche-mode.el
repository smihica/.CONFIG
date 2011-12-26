;;;
;;; Copyright (c) 2007-2008 OOHASHI Daichi <leque@katch.ne.jp>,
;;; All rights reserved.
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions
;;; are met:
;;;
;;; 1. Redistributions of source code must retain the above copyright
;;;    notice, this list of conditions and the following disclaimer.
;;;
;;; 2. Redistributions in binary form must reproduce the above copyright
;;;    notice, this list of conditions and the following disclaimer in the
;;;    documentation and/or other materials provided with the distribution.
;;;
;;; 3. Neither the name of the authors nor the names of its contributors
;;;    may be used to endorse or promote products derived from this
;;;    software without specific prior written permission.
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;;; A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;;; OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;;; SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
;;; TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
;;; PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
;;; LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
;;; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;;; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;;;

(eval-when-compile
  (require 'cl))

(require 'scheme)
(require 'info-look)

(setq gauche-mode-font-lock-keywords
  (append
   `((,(format "(%s\\>"
               (regexp-opt
		'(
		  "define-reader-ctor"
		  "define-values"
		  "define-constant"
		  "define-in-module"
		  "and-let*"
		  "begin0"
		  "call-with-builder"
		  "call-with-cgi-script"
		  "call-with-client-socket"
		  "call-with-current-continuation"
		  "call-with-ftp-connection"
		  "call-with-input-conversion"
		  "call-with-input-file"
		  "call-with-input-process"
		  "call-with-input-string"
		  "call-with-iterator"
		  "call-with-iterators"
		  "call-with-output-conversion"
		  "call-with-output-file"
		  "call-with-output-process"
		  "call-with-output-string"
		  "call-with-process-io"
		  "call-with-string-io"
		  "call-with-values"
		  "case-lambda"
		  "cond-expand"
		  "cond-list"
		  "cut"
		  "cute"
		  "delay"
		  "dolist"
		  "dotimes"
		  "eager"
		  "guard"
		  "hash-table-for-each"
		  "if-match"
		  "lazy"
		  "let*-values"
		  "let-args"
		  "let-keywords"
		  "let-keywords*"
		  "let-match"
		  "let-optionals*"
		  "let-syntax"
		  "let-values"
		  "let1"
		  "let/cc"
		  "letrec-syntax"
		  "make"
		  "multiple-value-bind"
		  "parameterize"
		  "parse-options"
		  "receive"
		  "rxmatch-case"
		  "rxmatch-cond"
		  "rxmatch-if"
		  "rxmatch-let"
		  "syntax-rules"
		  "unless"
		  "until"
		  "when"
		  "while"
		  "with-builder"
		  "with-error-handler"
		  "with-exception-handler"
		  "with-error-to-port"
		  "with-input-conversion"
		  "with-input-from-file"
		  "with-input-from-port"
		  "with-input-from-process"
		  "with-input-from-string"
		  "with-iterator"
		  "with-locking-mutex"
		  "with-module"
		  "with-output-conversion"
		  "with-output-to-file"
		  "with-output-to-port"
		  "with-output-to-process"
		  "with-port-locking"
		  "with-ports"
		  "with-signal-handlers"
		  "with-string-io"
		  "with-time-counter"
		  )
		t))
      1 font-lock-keyword-face)
     (,(format "(%s\\>"
               (regexp-opt
                '("error" "errorf" "syntax-error" "syntax-errorf") t))
      1 font-lock-warning-face)
     (,(format "\\<%s\\>"
	       (regexp-opt
		'("<>" "<...>") t))
      0 font-lock-builtin-face t)
     ("\\`#!.*"
      0 font-lock-preprocessor-face t)
     ("\\(#\\?=\\|#[0-9]+#\\|#[0-9]+=\\)"
      0 font-lock-preprocessor-face)
     )
   scheme-font-lock-keywords-1
   scheme-font-lock-keywords-2))

(mapc '(lambda (s)
	 (put (car s) 'scheme-indent-function (cdr s)))
      '( ;; From "Gauche:EditingWithEmacs" in WiLiKi
	(and-let* . 1)
	(begin0 . 0)
	(call-with-builder . 1)
	(call-with-cgi-script . 1)
	(call-with-client-socket . 1)
	(call-with-ftp-connection . 1)
	(call-with-input-conversion . 1)
	(call-with-input-file . 1)
	(call-with-input-process . 1)
	(call-with-input-string . 1)
	(call-with-iterator . 1)
	(call-with-iterators . 1)
	(call-with-output-conversion . 1)
	(call-with-output-file . 1)
	(call-with-output-process . 1)
	(call-with-output-string . 0)
	(call-with-process-io . 1)
	(call-with-string-io . 1)
	(call-with-temporary-file . 1)
	(call-with-values . 1)
	(dolist . 1)
	(dotimes . 1)
	(guard . 1)
	(hash-table-for-each . 1)
	(if-match . 2)
	(let*-values . 1)
	(let-args . 2)
	(let-keywords . 2)
	(let-keywords* . 2)
	(let-match . 2)
	(let-optionals* . 2)
	(let-syntax . 1)
	(let-values . 1)
	(let1 . 2)
	(let/cc . 1)
	(letrec-syntax . 1)
	(make . 1)
	(make-parameter . 1)
	(match . 1)
	(multiple-value-bind . 2)
	(parameterize . 1)
	(parse-options . 1)
	(pre-pose-order . 1)
	(receive . 2)
	(rxmatch-case . 1)
	(rxmatch-cond . 0)
	(rxmatch-if  . 4)
	(rxmatch-let . 2)
	(syntax-rules . 1)
	(unless . 1)
	(until . 1)
	(when . 1)
	(while . 1)
	(with-builder . 1)
	(with-error-handler . 1)
	(with-exception-handler . 1)
	(with-error-to-port . 1)
	(with-input-conversion . 1)
	(with-input-from-port . 1)
	(with-input-from-file . 1)
	(with-input-from-process . 1)
	(with-input-from-string . 1)
	(with-iterator . 1)
	(with-locking-mutex . 1)
	(with-module . 1)
	(with-output-conversion . 1)
	(with-output-to-file . 1)
	(with-output-to-port . 1)
	(with-output-to-process . 1)
	(with-port-locking . 1)
	(with-ports . 3)
	(with-signal-handlers . 1)
	(with-string-io . 1)
	(with-time-counter . 1)
	))

(defvar gauche-mode-syntax-table
  (let ((syntax (copy-syntax-table scheme-mode-syntax-table)))
    (modify-syntax-entry ?\| "  2b3" syntax)
    (modify-syntax-entry ?# "_ p14b" syntax)
    syntax))

(defvar gauche-mode-font-lock-syntactic-keywords
  '(
    ;; regexp
    ("#\\(/\\)\\(\\(\\\\\\\\\\)+\\|\\\\[^\\]\\|[^/\\]\\)*\\(/\\)"
     (1 (7 . ?/))
     (4 (7 . ?/)))
    ))

(defvar gauche-mode-map 
  (let ((map (make-sparse-keymap)))
    (define-key map [(control ?c) (control ?i)] #'gauche-fuzzy-complete-symbol)
    (define-key map [(control ?c) (control ?d)] #'gauche-toggle-debug-print)
    (define-key map [(control ?c) ?m] #'gauche-macroexpand)
    (define-key map [(control ?c) (control ?m)] #'gauche-macroexpand-1)
    (define-key map [(control ?c) ?\;] #'gauche-toggle-datum-comment)
    map))

(define-derived-mode gauche-mode scheme-mode
  "Gauche" "Major mode for Gauche."
  (use-local-map gauche-mode-map)
  (set-syntax-table gauche-mode-syntax-table)
  (setq comment-start ";;"
        font-lock-defaults
        `(,gauche-mode-font-lock-keywords
          nil t (("+-*/.<>=!?$%_&~^:" . "w")) beginning-of-defun
	  (font-lock-syntactic-keywords . gauche-mode-font-lock-syntactic-keywords)
          (font-lock-mark-block-function . mark-defun)
	  (parse-sexp-lookup-properties . t))
	))

(defvar gauche-fuzzy-complete-last-word nil)

(defvar gauche-symbol-separators '(":" "/" "+" ">" "&" "-"))

(defvar gauche-symbol-separator-pat
  (regexp-opt gauche-symbol-separators))

(defvar gauche-symbol-nonseparator-pat
  (format "[^%s]" (apply #'concat gauche-symbol-separators)))

(defun gauche-build-fuzzy-symbol-pat (str)
  (if (not (string-match gauche-symbol-separator-pat str))
      (let ((result '()))
	(dolist (c (split-string str "" t))
	  (setq result (list* gauche-symbol-separator-pat "*"
			      gauche-symbol-nonseparator-pat
			      (regexp-quote c)
			      result)))
	(apply #'concat (reverse (cdr result))))
    (let ((result '())
	  (words '())
	  (beg 0))
      (while (string-match gauche-symbol-separator-pat str beg)
	(push (substring str (max 0 (1- beg)) (match-beginning 0)) words)
	(setq beg (match-end 0)))
      (dolist (w (cons (substring str (max 0 (1- beg))) words))
	(setq result (list* (regexp-quote w)
			    gauche-symbol-nonseparator-pat "*" result)))
      (apply #'concat result))))

(defun gauche-fuzzy-complete-symbol ()
  "Complete the abbreviated symbol at point. Ordinary completion is also
done. If the symbol contains `-', `/', or `:', then they are considered
as a separator for abbreviations. If not, each char of the symbol is
considered as abbreviation for a word.

Ex.
  c-w-cur-c -> call-with-current-continuation
  wiff (is equivalent to w-i-f-f) -> with-input-from-file
  ca -> car, cadr, char-alphabetic?, ..., etc.
  c/c -> call/cc
"
  (interactive)
  (let* ((beg (max (line-beginning-position)
		   (save-excursion
		     (backward-sexp)
		     (point))))
	 (end (point))
	 (str (buffer-substring beg end)))
    (cond
     ((= beg end) nil)			; do nothing
     ((and (string-equal str gauche-fuzzy-complete-last-word)
	   (eq last-command 'gauche-fuzzy-complete-symbol))
      (let ((win (get-buffer-window "*Completions*")))
	(when win
	  (save-selected-window
	    (select-window win)
	    (or (ignore-errors (scroll-up) t)
		(goto-char (point-min)))))))
     (t
      (setq gauche-fuzzy-complete-last-word str)
      (let* ((regexp
	      (format "^\\(%s.*\\|%s\\)"
		      (regexp-quote str)
		      (gauche-build-fuzzy-symbol-pat str)))
	     (candidates
	      (mapcan #'(lambda (s)
			  (let ((match (string-match regexp (car s))))
			    (and match (list (car s)))))
		      (info-lookup->completions 'symbol 'gauche-mode))))
	(labels ((do-insert (beg end comp)
			    (set-text-properties 0 (length comp) '() comp)
			    (delete-region beg end)
			    (insert comp)))
	  (cond
	   ((null candidates)
	    (ding)
	    (message "No match"))
	   ((null (cdr candidates))
	    (let ((comp (car candidates)))
	      (message "Sole completion")
	      (do-insert beg end comp)))
	   (t
	    (let* ((i (reduce #'(lambda (m s)
				  (or (mismatch (car candidates) s :end1 m)
				      m))
			      (cdr candidates)
			      :initial-value (length (car candidates))))
		   (comp (substring (car candidates) 0 i)))
	      (with-output-to-temp-buffer "*Completions*"
		(display-completion-list (sort candidates #'string-lessp) comp))
	      (when (string-match regexp comp)
		(message "Complete but not unique")
		(do-insert beg end comp)))))))))))

(defun gauche-macroexpand (arg &optional n)
  "Expands the last macro and print it on *scheme* buffer.
With universal-argument, do not unwrap syntax."
  (interactive "P")
  (save-excursion
    (let* ((ep (point))
	   (sp (progn (backward-sexp) (point))))
      (let ((exp (buffer-substring sp ep))
	    (f (if arg "values" "unwrap-syntax")))
	(comint-send-string
	 (scheme-proc)
	 (format "(begin (newline) (print (%s (%%macroexpand%s %s))))\n"
		 f (or n "") exp))))))

(defun gauche-macroexpand-1 (arg)
  "Similar to gauche-macroexpand, but use macroexpand-1 instead."
  (interactive "P")
  (gauche-macroexpand arg "-1"))

(defun gauche-toggle-debug-print ()
  (interactive)
  (let ((p (point))
	(c (char-after))
	(d (char-before)))
    (cond
     ((null c) t)			; do nothing
     ((and d
	   (char-equal d ?=)
	   (char-equal (char-before (- p 1)) ??)
	   (char-equal (char-before (- p 2)) ?#))
      (delete-region (- p 3) p))
     ((and (char-equal c ?#)
	   (char-equal (char-after (+ p 1)) ??)
	   (char-equal (char-after (+ p 2)) ?=))
      (delete-region p (+ p 3)))
     ((and (char-equal c ??)
	   (char-equal (char-after (- p 1)) ?#)
	   (char-equal (char-after (+ p 1)) ?=))
      (delete-region (- p 1) (+ p 2)))
     ((and (char-equal c ?=)
	   (char-equal (char-after (- p 1)) ??)
	   (char-equal (char-after (- p 2)) ?#))
      (delete-region (- p 2) (+ p 1)))
     (t
      (insert "#?=")))))

(defun gauche-toggle-datum-comment ()
  (interactive)
  (let ((p (point))
	(b (char-before))
	(c (char-after)))
    (cond
     ((null c) t)			; do nothing
     ((and b
	   (char-equal b ?\;)
	   (char-equal (char-before (- p 1)) ?#))
      (delete-region (- p 2) p))
     ((and (char-equal b ?#)
	   (char-equal c ?\;))
      (delete-region (- p 1) (+ p 1)))
     ((and (char-equal c ?#)
	   (char-equal (char-after (+ p 1)) ?\;))
      (delete-region p (+ p 2)))
     (t
      (insert "#;")))))

;;; info
;; ;; Manual (English)
;; (eval-after-load "info-look"
;;   '(info-lookup-add-help
;;     :topic 'symbol
;;     :mode  'gauche-mode
;;     :regexp "[^()'\" \t\n]+"
;;     :ignore-case nil
;;     :doc-spec '(("(gauche-refe.info)Function and Syntax Index" nil
;;                  "^[ \t]+-- [^:]+:[ \t]*" nil)
;;                 ("(gauche-refe.info)Module Index" nil
;;                  "^[ \t]+-- [^:]+:[ \t]*" nil)
;;                 ("(gauche-refe.info)Class Index" nil
;;                  "^[ \t]+-- [^:]+:[ \t]*" nil)
;;                 ("(gauche-refe.info)Variable Index" nil
;;                  "^[ \t]+-- [^:]+:[ \t]*" nil))
;;     :parse-rule  nil
;;     :other-modes nil))

;; Manual (Japanese)
(eval-after-load "info-look"
  '(info-lookup-add-help
    :topic 'symbol
    :mode  'gauche-mode
    :regexp "[^()'\" \t\n]+"
    :ignore-case nil
    :doc-spec '(("(gauche-refj.info)Index - 手続きと構文索引" nil
                 "^[ \t]+-+ [^:]+:[ \t]*" nil)
                ("(gauche-refj.info)Index - モジュール索引"   nil
                 "^[ \t]+-+ [^:]+:[ \t]*" nil)
                ("(gauche-refj.info)Index - クラス索引"      nil
                 "^[ \t]+-+ [^:]+:[ \t]*" nil)
                ("(gauche-refj.info)Index - 変数索引"        nil
                 "^[ \t]+-+ [^:]+:[ \t]*" nil))
    :parse-rule  nil
    :other-modes nil))

(provide 'gauche-mode)