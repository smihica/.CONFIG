
;;; Code:

;; marmalade
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize))

;; enable evil
;; (require 'evil)
;; (evil-mode 1)
;; (setq evil-esc-delay 0.00)

;;coding
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(setq buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(cond
 ((or (eq window-system 'mac) (eq window-system 'ns))
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))
 (t
  (setq file-name-coding-system 'utf-8-unix)
  (setq locale-coding-system 'utf-8-unix)))

;;backspace
(global-set-key "\C-h" 'backward-delete-char)

;;scroll-step
(setq scroll-step 2)

;;indent
(setq-default indent-tabs-mode nil)

;;disable startup message
(setq inhibit-startup-screen t)

;; menu bar
(menu-bar-mode 0)

;;trailing-whitespace
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))

;;()paren-mode
(show-paren-mode t)
(setq show-paren-delay 0)

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
(global-set-key (kbd "C-RET") 'cua-set-rectangle-mark)

;;backupFile
(defvar backup-files-dir (expand-file-name "~/.emacs.d/backup-files"))
(defvar temp-files-dir (expand-file-name "~/.emacs.d/temp-files"))

(setq make-backup-files t)
(setq backup-directory-alist (cons (cons "\\.*$" backup-files-dir) nil))

;; color-moccur
(require 'color-moccur)
(require 'moccur-edit)

;; keyBind
(global-unset-keys
 "\e\e\e"
 "\C-\\"
 "\M-h"
 "\M-j"
 "\M-l"
 "\M-k")

(global-set-keys
 "\M-9" 'enlarge-window-horizontally
 "\M-8" 'enlarge-window
 "\M-7" 'shrink-window
 "\M-6" 'shrink-window-horizontally
 "\M-5" 'moccur-grep-find
 "\M-4" 'foreign-regexp/query-replace
 "\M-3" 'query-replace
 "\M-2" 'foreign-regexp/isearch-forward
 "\M-'" 'dabbrev-expand-multiple
 "\C-x\C-k" 'kill-buffer
 "\C-xk" 'kill-buffer
 "\C-x\C-g" 'goto-line
 "\C-j" 'newline
 "\C-h" 'backward-delete-char
 "\M-." 'end-of-buffer
 "\M-," 'beginning-of-buffer
 "\C-\M-]" 'comment-or-uncomment-region
 "\M-h" 'windmove-left
 "\M-j" 'windmove-down
 "\M-l" 'windmove-right
 "\M-k" 'windmove-up)

;;; dabbrev-expand-multiple
(require 'dabbrev-expand-multiple)
(setq dabbrev-expand-multiple-select-keys '("a" "s" "d" "f" "g"))
(add-to-list 'dabbrev-expand-multiple-next-keys "n")
(add-to-list 'dabbrev-expand-multiple-previous-keys "p")
(setq dabbrev-expand-multiple-inline-show-face 'underline)
(setq dabbrev-expand-multiple-inline-show-face nil)
(setq dabbrev-expand-multiple-use-tooltip nil)

;;; ignoreing case switch in completion.
(setq completion-ignore-case t)

;;; auto buffer reload when the file is updated by other program.
(global-auto-revert-mode 1)

;; flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;;;
;;; modes
;;;

;; terminal
(defvar terminal-buffer-maximum-size 10000)
(add-hook 'shell-mode-hook
  (lambda ()
    (setq comint-buffer-maximum-size (- terminal-buffer-maximum-size 1))
    (setq comint-process-echoes nil)
    (add-to-list 'comint-output-filter-functions
                 'comint-truncate-buffer)
    ;; for node-js repl in emacs.
    (add-to-list 'comint-preoutput-filter-functions
                 (lambda (output)
                   (replace-regexp-in-string "\\(?:\\[[0-9][GKJ]\\|\\[\\?[0-9][lh]\\|=\\|>\\|\\[J\\)" "" output)))))

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

;; html
(require 'emmet-mode)
;; Auto-start on any markup modes
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2)))
(custom-set-variables '(emmet-move-cursor-between-quotes t))

(append-auto-mode-alist "\\.mako$" 'html-mode) ;; pyramid. (python)
(setq-default emmet-preview-default nil)

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
(append-auto-mode-alist "\\.hm$" 'objc-mode)
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

;; rust
(require 'rust-mode)
(append-auto-mode-alist "\\.rs$" 'rust-mode)
(add-hook 'rust-mode-hook
          (lambda ()
            (flycheck-mode)))

;; haXe
;; (require 'haxe-mode)
;; (append-auto-mode-alist "\\.hx$" 'haxe-mode)

;; sass
(require 'sass-mode)
(append-auto-mode-alist "\\.sass$" 'sass-mode)
(append-auto-mode-alist "\\.scss$" 'sass-mode)

;; yacc/lex
(append-auto-mode-alist "\\.l$" 'c-mode)

;; bgscript-mode
;(require 'bgscript-mode)
;(append-auto-mode-alist "\\.bgs$" 'bgscript-mode)

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
     ; slime-js
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

(add-to-list 'slime-lisp-implementations `(sbcl (,(executable-find "sbcl")) :coding-system utf-8-unix))

;;lisp-mode
(append-auto-mode-alist "\\.cl$" 'lisp-mode)
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

;; arduino
(append-auto-mode-alist "\\.pde$" 'c++-mode)

;; go
(add-hook
 'go-mode-hook
 (lambda ()
   (setq indent-tabs-mode t)
   (setq tab-width        4)
   (auto-complete-mode t)
   (flycheck-mode)))

;; jsx, es6/7
(add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs$"  . web-mode))

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

(add-hook
 'web-mode-hook
 (lambda ()
   (auto-complete-mode t)
   (setq web-mode-attr-indent-offset   nil)
   (setq web-mode-markup-indent-offset 2)
   (setq web-mode-css-indent-offset    2)
   (setq web-mode-code-indent-offset   2)
   (setq web-mode-sql-indent-offset    2)
   (setq indent-tabs-mode              nil)
   (setq tab-width                     4)
   (local-unset-key "\M-;")
   (flycheck-add-mode 'javascript-eslint 'web-mode)
   (flycheck-mode)))


(add-hook
 'js-mode-hook
 (lambda ()
   (setq js-indent-level 2)))

(append-auto-mode-alist "\\.json$" 'js-mode)

;; haskell
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

;; clojure
(require 'clojure-mode)
(autoload 'clojure-mode "clojure-mode" "A major mode for Clojure" t)

;; scala
(require 'scala-mode)
(autoload 'scala-mode "scala-mode" "A major mode for Scala" t)

;; typescript
;; (require 'typescript)
;; (defmode typescript-mode "\\.ts$"
;;   (add-hook 'typescript-mode-hook
;;             (lambda ()
;;               (setq tab-width 4)
;;               (setq typescript-indent-level 2)
;;               (setq c-tab-always-indent nil)
;;               (setq show-trailing-whitespace t))))


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

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/auto-complete/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)

;; spec-id generator
(defun random-elt (src)
  (let ((l (length src)))
    (elt src (random l))))

(defun random-str (l)
  (concat (loop for i from 1 to l collect (random-elt "abcdefghijklmnopqrstuvwxyz0123456789"))))

(defun insert-spec-id (length)
  (interactive "P")
  (insert "[!" (random-str (or length 5)) "] "))

(global-set-key "\C-c\C-b" 'insert-spec-id)

;; window
(defun split-window-below-ratio (w proportion)
  (split-window w (round (* proportion (window-height w)))))

(defun split-window-right-ratio (w proportion)
  (split-window w (round (* proportion (window-width w))) t))

(defun ws5x ()
  (interactive)
  (let ((w0 (selected-window)))
    (let ((w1 (split-window-right-ratio w0 0.40)))
      (let ((w2 (split-window-right-ratio w1 0.66)))
        (split-window-below-ratio w0 0.50)
        (split-window-below-ratio w1 0.50)))))

(defun ws2 ()
  (interactive)
  (let ((w0 (selected-window)))
    (split-window-right-ratio w0 0.50)))

(defun ws3 ()
  (interactive)
  (let ((w0 (selected-window)))
    (let ((w1 (split-window-right-ratio w0 0.33)))
      (split-window-right-ratio w1 0.50))))

(defun ws4 ()
  (interactive)
  (let ((w0 (selected-window)))
    (let ((w2 (split-window-right-ratio w0 0.50)))
      (split-window-below-ratio w2 0.50)
      (split-window-below-ratio w0 0.50))))

(defun ws4v ()
  (interactive)
  (let ((w0 (selected-window)))
    (let ((w2 (split-window-right-ratio w0 0.50)))
      (split-window-right-ratio w2 0.50)
      (split-window-right-ratio w0 0.50))))

(defun ws5 ()
  (interactive)
  (let ((w0 (selected-window)))
    (let ((w1 (split-window-right-ratio w0 0.33)))
      (let ((w2 (split-window-right-ratio w1 0.50)))
        (split-window-below-ratio w0 0.50)
        (split-window-below-ratio w1 0.50)))))

(defun ws6 ()
  (interactive)
  (let ((w0 (selected-window)))
    (let ((w1 (split-window-right-ratio w0 0.33)))
      (let ((w2 (split-window-right-ratio w1 0.50)))
        (split-window-below-ratio w0 0.50)
        (split-window-below-ratio w1 0.50)
        (split-window-below-ratio w2 0.50)))))

(defun ws7 ()
  (interactive)
  (let ((w0 (selected-window)))
    (let ((w2 (split-window-right-ratio w0 0.50)))
      (let ((w1 (split-window-right-ratio w0 0.50)))
        (let ((w3 (split-window-right-ratio w2 0.50)))
          (split-window-below-ratio w0 0.50)
          (split-window-below-ratio w1 0.50)
          (split-window-below-ratio w2 0.50))))))

(defun ws8 ()
  (interactive)
  (let ((w0 (selected-window)))
    (let ((w2 (split-window-right-ratio w0 0.50)))
      (let ((w1 (split-window-right-ratio w0 0.50)))
        (let ((w3 (split-window-right-ratio w2 0.50)))
          (split-window-below-ratio w0 0.50)
          (split-window-below-ratio w1 0.50)
          (split-window-below-ratio w2 0.50)
          (split-window-below-ratio w3 0.50))))))

;; disable auto indentation when newline
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; regexp
(require 'foreign-regexp)
(custom-set-variables
 '(foreign-regexp/regexp-type 'javascript) ;; ruby or perl available
 '(reb-re-syntax 'foreign-regexp/re-builder/query-replace-on-target-buffer))
