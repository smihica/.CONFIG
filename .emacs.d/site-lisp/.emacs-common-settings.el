;;coding
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(cond
 ((or (eq window-system 'mac) (eq window-system 'ns))
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))
 (t
  (setq file-name-coding-system 'utf-8-unix)
  (setq locale-coding-system 'utf-8-unix)))

;;slime and shell buffer size
(setq-default comint-buffer-maximum-size 100)

;;backspace
(global-set-key "\C-h" 'backward-delete-char)

;;scroll-step
(setq scroll-step 2)

;;indent
(setq-default indent-tabs-mode nil)

;;trailing-whitespace
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))

;;()paren-mode
(show-paren-mode t)

;; line-truncate
(setq-default truncate-lines t)
(defun toggle-truncate-lines ()
  "truncate switch"
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))

;; cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil)

;;backupFile
(defvar backup-files-dir (expand-file-name "~/.emacs.d/backup-files"))
(defvar temp-files-dir (expand-file-name "~/.emacs.d/temp-files"))

(setq make-backup-files t)
(setq backup-directory-alist (cons (cons "\\.*$" backup-files-dir) nil))

;;(setq backup-by-copying t)
;;(setq backup-by-copying-when-linked t)
;;(setq auto-save-list-file-prefix (concat temp-files-dir ".auto-saves-"))
;;(setq auto-save-file-name-transforms `((".*" ,temp-files-dir t)))

;; color-moccur
(require 'color-moccur)
(require 'moccur-edit)

;; keyBind
(global-unset-keys 
 "\e\e\e"
 "\C-\\"
)
(global-set-keys
 "\M-9" 'enlarge-window-horizontally
 "\M-8" 'enlarge-window
 "\M-7" 'shrink-window
 "\M-6" 'shrink-window-horizontally
 "\M-5" 'moccur-grep-find
 "\M-4" 'query-replace-regexp
 "\M-3" 'query-replace
 "\M-;" 'other-window
 "\M-'" 'dabbrev-expand-multiple
 "\C-x\C-k" 'kill-buffer
 "\C-xk" 'kill-buffer
 "\C-x\C-g" 'goto-line
 "\C-j" 'newline
 "\C-h" 'backward-delete-char
 "\M-." 'end-of-buffer
 "\M-," 'beginning-of-buffer
 "\C-\M-]" 'comment-or-uncomment-region
)

;;; dabbrev-expand-multiple
(require 'dabbrev-expand-multiple)
(setq dabbrev-expand-multiple-select-keys '("a" "s" "d" "f" "g"))
(add-to-list 'dabbrev-expand-multiple-next-keys "n")
(add-to-list 'dabbrev-expand-multiple-previous-keys "p")
(setq dabbrev-expand-multiple-inline-show-face 'underline)
(setq dabbrev-expand-multiple-inline-show-face nil)
(setq dabbrev-expand-multiple-use-tooltip nil)

;;;
;;; modes
;;;

;; ;; term-mode
;; (setq system-uses-terminfo nil)
;; (setq shell-file-name
;;       (or (executable-find "zsh")
;;           (executable-find "bash")
;;           (executable-find "cmdproxy")
;;           (error "can't find 'shell' command in PATH!!")))
;; (setenv "SHELL" shell-file-name)
;; (setq explicit-shell-file-name shell-file-name)

;; ;; multi-term
;; (require 'multi-term)
;; (setq multi-term-program shell-file-name)
;; (add-hook 'term-mode-hook
;;           (lambda ()
;;             (setq show-trailing-whitespace nil)))

;; ;; shell-mode
;; (autoload
;;   'ansi-color-for-comint-mode-on "ansi-color"
;;   "Set `ansi-color-for-comint-mode' to t." t)
;; (setq ansi-color-names-vector
;;       ["#000000"           ; black
;;        "#ff6565"           ; red
;;        "#93d44f"           ; green
;;        "#eab93d"           ; yellow
;;        "#204a87"           ; blue
;;        "#ce5c00"           ; magenta
;;        "#89b6e2"           ; cyan
;;        "#ffffff"]          ; white
;;       )
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; (add-hook 'comint-mode-hook
;;           (lambda ()
;;             (setq show-trailing-whitespace nil)
;;             (setq comint-process-echoes t)))

;; javascript
(add-hook
 'js-mode-hook
 (lambda ()
   ;(setq javascript-indent-level 2)
   ;(setq espresso-indent-level 2)
   (setq js-indent-level 2)
   (slime-js-minor-mode 1)))
(append-auto-mode-alist "\\.json$" 'js-mode)

;; html
(append-auto-mode-alist "\\.mako$" 'html-mode) ;; pyramid. (python)

;; css
;;(defmode css-mode "\\.css$")

;; ruby
;(defmode ruby-mode "\\.rb$"
;  (setq interpreter-mode-alist
;      (append '(("ruby" . ruby-mode))
;              interpreter-mode-alist))
;  (autoload 'run-ruby "inf-ruby"
;    "Run an inferior Ruby process")
;  (autoload 'inf-ruby-keys "inf-ruby"
;    "Set local key defs for inf-ruby in ruby-mode")
;  (add-hook 'ruby-mode-hook
;            '(lambda ()
;               (inf-ruby-keys))))


;; python
(setq python-python-command "/usr/bin/python3.1")

;; C
(add-hook 'c-mode-common-hook
          '(lambda ()
             (c-set-style "BSD")
             (setq tab-width 4)
             (setq indent-tabs-mode nil)
             (setq c-tab-always-indent nil)
             (setq c-basic-offset 4)
             (setq show-trailing-whitespace t)))

;; C++
(append-auto-mode-alist "\\.h$" 'c++-mode)
(add-hook 'c++-mode-hook
          '(lambda ()
             (c-set-style "BSD")
             (setq tab-width 4)
             (setq indent-tabs-mode nil)
             (setq c-tab-always-indent nil)
             (setq c-basic-offset 4)
             (setq show-trailing-whitespace t)))

;; C#
(defmode csharp-mode "\\.cs$"
  (add-hook 'csharp-mode-hook
            '(lambda ()
              (c-set-style "BSD")
              (setq tab-width 4)
              (setq indent-tabs-mode nil)
              (setq c-tab-always-indent nil)
              (setq c-basic-offset 4)
              (setq show-trailing-whitespace t))))

;; obj-C
(append-auto-mode-alist "\\.m$" 'objc-mode)
(append-auto-mode-alist "\\.mm$" 'objc-mode)
(add-hook 'objc-mode
          '(lambda ()
             (c-set-style "BSD")
             (setq tab-width 4)
             (setq indent-tabs-mode nil)
             (setq c-tab-always-indent nil)
             (setq c-basic-offset 4)
             (setq show-trailing-whitespace t)))

;; java
(add-hook 'java-mode-hook
          '(lambda ()
             (c-set-style "BSD")
             (setq tab-width 4)
             (setq indent-tabs-mode nil)
             (setq c-tab-always-indent nil)
             (setq c-basic-offset 4)
             (setq show-trailing-whitespace t)))

;; asm
(require 'gas-mode)
(append-auto-mode-alist "\\.asm$" 'gas-mode)

;; haXe
(require 'haxe-mode)
(append-auto-mode-alist "\\.hx$" 'haxe-mode)

;; scss/sass
(require 'scss-mode)
(require 'sass-mode)
(append-auto-mode-alist "\\.scss$" 'scss-mode)
(append-auto-mode-alist "\\.sass$" 'sass-mode)

;yacc/lex
(append-auto-mode-alist "\\.l$" 'c-mode)

;; slime
(require 'slime)
(setq inferior-lisp-program "sbcl")

(setq slime-lisp-implementations '())

(setq slime-net-coding-system 'utf-8-unix)
(slime-setup
 '( inferior-slime
    slime-asdf
    slime-autodoc
    slime-banner
    slime-c-p-c
    slime-editing-commands
    slime-fancy-inspector
    slime-fancy
    slime-fuzzy
    slime-parse
    slime-references
    slime-scratch
    slime-tramp
    slime-typeout-frame
    slime-xref-browser
    slime-scheme
    slime-js
    slime-repl
    ))

(defun slime-kill-all-buffers ()
  "Kill all the slime related buffers. This is only used by the
  repl command sayoonara."
  (dolist (buf (buffer-list))
  (when (or (string= (buffer-name buf) slime-event-buffer-name)
            (string-match "^\\*inferior-lisp*" (buffer-name buf))
            (string-match "^\\*slime-repl .*\\*$" (buffer-name buf))
            (string-match "^\\*sldb .*\\*$" (buffer-name buf)))
    (kill-buffer buf))))

(defun slime-quit ()
  (interactive)
  (progn
    (if (slime-connected-p) (slime-disconnect))
    (slime-kill-all-buffers)))

(add-hook 'lisp-mode-hook
  (lambda ()
   (progn
     (slime-mode t)
     (local-set-key "\C-j" 'insert-parentheses)
     (local-set-key "\C-\M-j" 'slime-insert-balanced-comments)
     (local-set-key "\C-\M-l" 'slime-remove-balanced-comments)
     (local-set-key "\C-c\C-q" 'slime-quit))))

;;lisp-mode
(append-auto-mode-alist "\\.cl$" 'lisp-mode)

(add-to-list 'slime-lisp-implementations `(sbcl (,(executable-find "sbcl")) :coding-system utf-8-unix))

(put 'if-let 'lisp-indent-function 2)
(font-lock-add-keywords 'lisp-mode '(("\\([^']\\|^\\)(\\(if-let\\)[ \n)]" 2 font-lock-keyword-face)))
(put 'aif 'lisp-indent-function 0)
(font-lock-add-keywords 'lisp-mode '(("\\([^']\\|^\\)(\\(aif\\)[ \n)]" 2 font-lock-keyword-face)))
(font-lock-add-keywords 'lisp-mode '(("\\([^']\\|^\\)(\\(defclass\\*\\)[ \n)]" 2 font-lock-keyword-face)))
(font-lock-add-keywords 'lisp-mode '(("defclass\\*[ \n]*\\([^ ]*\\)" 1 font-lock-string-face)))
(font-lock-add-keywords 'lisp-mode '(("\\([^']\\|^\\)(\\(defmemfn\\*\\)[ \n)]" 2 font-lock-keyword-face)))
(font-lock-add-keywords 'lisp-mode '(("defmemfn\\*[ \n]*\\([^ ]*\\)" 1 font-lock-string-face)))

;; gauche
(defmode gauche-mode "\\.scm$"
  (add-hook 'gauche-mode-hook
            (lambda ()
              (slime-mode t)
              (local-set-key "\C-j" 'insert-parentheses)))
  ;; run-gauche
  (modify-coding-system-alist 'process "gosh" '(utf-8 . utf-8))
  (setq scheme-program-name "gosh -i")
  (autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
  (autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
  (defun scheme-other-window ()
    "Run scheme on other window"
    (interactive)
    (switch-to-buffer-other-window
     (get-buffer-create "'scheme"))
    (run-scheme scheme-program-name))
  (global-set-key "\C-cs" 'scheme-other-window))

;; gauche-swank
;(setq swank-gauche-path (expand-file-name (concat my-site-root "/../lib/swank")))
;(setq swank-gauche-gauche-source-path (expand-file-name "~/opt/sources/Gauche-0.9.2"))
;(push swank-gauche-path load-path)
;(require 'swank-gauche)

;(add-to-list 'slime-lisp-implementations `(gauche (,(executable-find "gosh")) :init gauche-init :coding-system utf-8-unix))

;(setq slime-find-buffer-package-function 'find-gauche-package)
;; c-p-c補完に設定
;(setq slime-complete-symbol-function 'slime-complete-symbol*)
;; web上のGaucheリファレンスマニュアルを引く設定
;(define-key slime-mode-map (kbd "C-c C-d H") 'gauche-ref-lookup)

;; arc
(require 'inferior-arc)
(setq arc-program-name "/home/nagayoru/svn/arc/arc.sh")
(defmode arc-mode "\\.arc$")

;arduino
(append-auto-mode-alist "\\.pde$" 'c++-mode)

;;downcase upcase -region enable
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; auto-install
;(require 'auto-install)
;(setq auto-install-directory "~/.emacs.d/auto-install-site/")
;;(auto-install-update-emacswiki-package-name t)
;(auto-install-compatibility-setup)