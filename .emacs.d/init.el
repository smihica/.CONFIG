;; Utils:
(defmacro ap1 (lis item)
  `(setq ,lis (append (list ,item) ,lis)))

(defmacro append-auto-mode-alist (regex mode)
  `(ap1 auto-mode-alist (cons ,regex ,mode)))

(defmacro defmode (name regexp &rest options)
  `(progn
     (autoload ',name ,(symbol-name name) nil t)
     (append-auto-mode-alist ,regexp ',name)
     ,@options))

(eval-when-compile
  (defun global-set-keys-iter (lis)
    (when lis
      `((global-set-key ,(car lis) ,(cadr lis))
        ,@(global-set-keys-iter (cddr lis))))))

(defmacro global-set-keys (&rest key-action-pairs)
  `(progn ,@(global-set-keys-iter key-action-pairs)))

(defmacro global-unset-keys (&rest keys)
  `(progn
     ,@(mapcar (lambda (x)
                 `(global-unset-key ,x)) keys)))

;; auto save list file is no need
(setq auto-save-list-file-prefix nil)

;; Theme:
(load-theme 'wombat)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#000000" :foreground "#FFFFFF")))))

;; package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (add-to-list 'load-path "~/.emacs.d/elpa/")
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)

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
(setq-default show-paren-delay 0)

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
;;"\M-5" 'moccur-grep-find
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

;;; ignoreing case switch in completion.
(setq completion-ignore-case t)

;;; auto buffer reload when the file is updated by other program.
(global-auto-revert-mode nil)

;; ensure use-package
(eval-when-compile
  (require 'use-package))

;; flycheck
(use-package flycheck :ensure t)

;; elisps should be compile automatically
; (use-package auto-async-byte-compile
;   :ensure t
;   :config
;   (progn
;     (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)))

;;;
;;; modes
;;;

;; terminal
(defvar terminal-buffer-maximum-size 10000)
(add-hook 'shell-mode-hook
  (lambda ()
    (setq show-trailing-whitespace nil)
    (setq comint-buffer-maximum-size (- terminal-buffer-maximum-size 1))
    (setq comint-process-echoes nil)
    (add-to-list 'comint-output-filter-functions
                 'comint-truncate-buffer)
    ;; for node-js repl in emacs.
    (add-to-list 'comint-preoutput-filter-functions
                 (lambda (output)
                   (replace-regexp-in-string "\\(?:\\[[0-9][GKJ]\\|\\[\\?[0-9][lh]\\|=\\|>\\|\\[J\\)" "" output)))
    (add-to-list 'comint-preoutput-filter-functions
                 (lambda (output) (replace-regexp-in-string "" "" output)))))

;; C
(append-auto-mode-alist "\\.cm$" 'c-mode)
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-style "BSD")
            (setq tab-width 4)
            (setq indent-tabs-mode nil)
            (setq c-tab-always-indent nil)
            (setq c-basic-offset 4)
            (setq show-trailing-whitespace t)))

;; C++
(append-auto-mode-alist "\\.h$" 'c++-mode)
(append-auto-mode-alist "\\.cpp$" 'c++-mode)
(append-auto-mode-alist "\\.hpp$" 'c++-mode)
(append-auto-mode-alist "\\.hm$" 'c++-mode)
(append-auto-mode-alist "\\.cppm$" 'c++-mode)
(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-style "BSD")
            (setq tab-width 4)
            (setq indent-tabs-mode nil)
            (setq c-tab-always-indent nil)
            (setq c-basic-offset 4)
            (setq show-trailing-whitespace t)))

;; C#
(defmode csharp-mode "\\.cs$"
  (add-hook 'csharp-mode-hook
            (lambda ()
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
          (lambda ()
            (c-set-style "BSD")
            (setq tab-width 4)
            (setq indent-tabs-mode nil)
            (setq c-tab-always-indent nil)
            (setq c-basic-offset 4)
            (setq show-trailing-whitespace t)))

;; java
(add-hook 'java-mode-hook
          (lambda ()
            (c-set-style "BSD")
            (setq tab-width 4)
            (setq indent-tabs-mode nil)
            (setq c-tab-always-indent nil)
            (setq c-basic-offset 4)
            (setq show-trailing-whitespace t)))

;; company
(use-package company
  :ensure t
  :config
  (progn
    (setq company-idle-delay 0.8)
    (setq company-minimum-prefix-length 1)))

;; lsp-mode
(use-package lsp-mode
  :ensure t
  :config
  (progn
    (add-hook
     'lsp-mode-hook
     (lambda ()
       (setq lsp-completion-provider :capf)
       (setq lsp-idle-delay 0.8)
       (setq gc-cons-threshold (* 1024 1024 64))
       (setq read-process-output-max (* 1024 1024 8))
       (setq lsp-modeline-code-actions-enable nil)
       (setq lsp-modeline-diagnostics-mode t)
       (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.*")
       (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]memo")))
    (add-hook
     'lsp-managed-mode-hook
     (lambda ()
       (setq-local company-backends '(company-capf))))))

;; rust
(use-package rust-mode
  :ensure t
  :mode (("\\.rs$" . rust-mode))
  :custom rust-format-on-save t
  :config
  (progn
    (add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))
    (add-hook
     'rust-mode-hook
     (lambda ()
       (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]target")
       (lsp)))))

(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

;; elixir
(use-package elixir-mode
  :ensure t
  :mode (("\\.exs?$" . elixir-mode))
  :config
  (progn
    (add-to-list 'exec-path "/opt/elixir/ls")
    (add-hook
     'elixir-mode-hook
     (lambda ()
       (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]_build")
       (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]deps")
       (lsp)
       (company-mode)
       (add-hook 'before-save-hook 'elixir-format nil t)))))

;; yacc/lex
(append-auto-mode-alist "\\.l$" 'c-mode)

;; lisp / slime
(load (expand-file-name "~/.roswell/helper.el"))
(setq inferior-lisp-program "ros -Q run")
(setq slime-net-coding-system 'utf-8-unix)
(append-auto-mode-alist "\\.ros$" 'lisp-mode)
(defun slime-qlot-exec (directory)
  (interactive (list (read-directory-name "Project directory: ")))
  (slime-start :program "qlot"
               :program-args '("exec" "ros" "-S" "." "run")
               :directory directory
               :name 'qlot
               :env (list (concat "PATH=" (mapconcat 'identity exec-path ":")))))

(use-package ac-slime
  :ensure t
  :custom
  (progn
    (add-hook 'slime-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
    (eval-after-load "auto-complete"
      '(add-to-list 'ac-modes 'slime-repl-mode))))

;lisp-mode
(use-package paredit
  :ensure t
  :custom
  (progn
    (append-auto-mode-alist "\\.cl$" 'lisp-mode)
    (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
    (add-hook 'lisp-interacton-mode-hook 'enable-paredit-mode)
    (add-hook 'lisp-mode-hook 'enable-paredit-mode)
    (add-hook 'lisp-mode-hook (lambda () (auto-complete-mode t)))))

;; go
(add-to-list 'exec-path (expand-file-name "/usr/local/bin"))
(add-to-list 'exec-path (expand-file-name "/opt/go/bin/"))
(add-hook 'go-mode-hook 'flycheck-mode)
(use-package flycheck-gometalinter :ensure t)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-gometalinter-setup))
(add-hook 'go-mode-hook
          (lambda ()
             (add-hook 'before-save-hook 'gofmt-before-save)
             (local-set-key (kbd "M-.") 'godef-jump)
             (setq indent-tabs-mode t)
             (setq tab-width        4)
             (auto-complete-mode    t)
             (setq flycheck-gometalinter-fast t)
             (setq flycheck-gometalinter-disable-linters '("golint"))))

;; web
(defun use-eslint-from-node-modules-if-exist ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/.bin/eslint" root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

(defun web-mode-setup ()
  (pcase web-mode-content-type
    ((or "javascript" "jsx" "tsx" "typescript")
     (progn
       (lsp)
       (prettier-js-mode)
       (use-eslint-from-node-modules-if-exist)
       (when (executable-find flycheck-javascript-eslint-executable)
         (flycheck-add-mode 'javascript-eslint 'web-mode)
         (add-to-list 'flycheck-disabled-checkers 'lsp)
         (flycheck-select-checker 'javascript-eslint))
       (flycheck-mode)))
    ((or "json" "html" "css" "sass")
     (progn
       (lsp)
       (prettier-js-mode)
       (flycheck-mode)))))

(use-package web-mode
  :ensure t
  :mode (("\\.tsx?$" . web-mode)
         ("\\.jsx?$" . web-mode)
         ("\\.html$" . web-mode)
         ("\\.json$" . web-mode)
         ("\\.css$"  . web-mode)
         ("\\.scss$" . web-mode)
         ("\\.sass$" . web-mode))
  :config
  (progn
    (add-hook
     'web-mode-hook
     (lambda ()
       (setq web-mode-attr-indent-offset   nil)
       (setq web-mode-markup-indent-offset 2)
       (setq web-mode-css-indent-offset    2)
       (setq web-mode-code-indent-offset   2)
       (setq web-mode-sql-indent-offset    2)
       (setq indent-tabs-mode              nil)
       (setq tab-width                     2)
       (local-unset-key "\M-;")
       (web-mode-setup)))))

(use-package prettier-js
  :ensure t)

;; graphql
(use-package graphql-mode
  :ensure t
  :mode (("\\.gql$" . graphql-mode)))

;; scala
(use-package scala-mode
  :ensure t)

;; dart
(use-package lsp-dart
  :ensure t
  :config
  (progn
    (add-hook
     'dart-mode-hook
     (lambda ()
       (lsp)
       (add-hook 'before-save-hook 'lsp-format-buffer nil t)))))

;; projectile
(use-package projectile :ensure t)

;;downcase upcase -region enable
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; spec-id generator
(defun random-elt (src)
  (let ((l (length src)))
    (elt src (random l))))

(defun random-str (l)
  (concat (cl-loop for i from 1 to l collect (random-elt "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"))))

(defun insert-id (length)
  (interactive "P")
  (insert "#[" (random-str (or length 5)) "]"))

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
;(use-package foreign-regexp :ensure t)

;; shell runs on same window
(add-to-list 'display-buffer-alist
             `(,(regexp-quote "*shell") display-buffer-same-window))

;;; No need vc
(setq vc-handled-backends ())
(remove-hook 'find-file-hook 'vc-find-file-hook)

(defun my-package-recompile()
  "Recompile all packages"
  (interactive)
  (byte-recompile-directory "~/.emacs.d/elpa" 0 t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(emmet-move-cursor-between-quotes t)
 '(flutter-sdk-path "/opt/flutter/" t)
 '(foreign-regexp/regexp-type 'javascript)
 '(lsp-dart-line-length 120)
 '(package-selected-packages
   '(cargo rust-mode use-package web-mode auto-async-byte-compile elixir-mode prettier-js prettier flycheck-rust quickrun flycheck graphql-mode tss typescript-mode modern-cpp-font-lock flycheck-gometalinter add-node-modules-path yaml-mode go-autocomplete python-mode ac-slime paredit slime scala-mode sass-mode racer php-mode macrostep go-mode emmet-mode paredit))
 '(progn 2 t)
 '(reb-re-syntax 'foreign-regexp/re-builder/query-replace-on-target-buffer)
 '(safe-local-variable-values
   '((eval setq flycheck-clang-include-path
           (list
            (expand-file-name "tests/mocks" root-path)
            (expand-file-name "inc/inc_hp" root-path)
            (expand-file-name "../../component/os/os_dep/include" root-path)
            (expand-file-name "tests/mocks/FreeRTOS-Simulator/Source/include" root-path)
            (expand-file-name "tests/mocks/FreeRTOS-Simulator/Source/portable/GCC/POSIX" root-path)))
     (eval setq flycheck-clang-include-path
           (list
            (expand-file-name "src/" root-path)
            (expand-file-name "src/device" root-path)
            (expand-file-name "lib/drivers/STM32F3xx_HAL_Driver/Inc/" root-path)
            (expand-file-name "lib/drivers/STM32F3xx_HAL_Driver/Inc/Legacy/" root-path)
            (expand-file-name "lib/drivers/CMSIS/Device/ST/STM32F3xx/Include/" root-path)
            (expand-file-name "lib/drivers/CMSIS/Include/" root-path)
            (expand-file-name "lib/middlewares/ST/STM32_USB_Device_Library/Core/Inc/" root-path)
            (expand-file-name "lib/middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc/" root-path))
           flycheck-clang-definitions
           (append flycheck-clang-definitions
                   (list "USE_HAL_DRIVER" "STM32F303xE")))
     (eval setq flycheck-clang-include-path
           (append
            (list
             (expand-file-name "mocks/esp-idf/include/" root-path)
             (expand-file-name "mocks/impls/include/" root-path)
             (expand-file-name "extsrcs/test_utils/include/" root-path))
            (let*
                ((components-path
                  (expand-file-name "components" root-path))
                 (components
                  (remove-if
                   (lambda
                     (itm)
                     (string-prefix-p "." itm))
                   (directory-files components-path))))
              (apply #'append
                     (mapcar
                      (lambda
                        (c)
                        (list
                         (expand-file-name
                          (concat c "/include/")
                          components-path)))
                      components))))
           flycheck-clang-language-standard "c++14")
     (eval set
           (make-local-variable 'root-path)
           (file-name-directory
            (let
                ((d
                  (dir-locals-find-file ".")))
              (if
                  (stringp d)
                  d
                (car d)))))
     (eval add-hook 'c++-mode-hook
           (lambda nil
             (setq flycheck-clang-language-standard "c++14")))
     (c-tab-always-indent)
     (web-mode-css-indent-offset . 4)
     (web-mode-markup-indent-offset . 4)
     (web-mode-code-indent-offset . 4)
     ((web-mode-code-indent-offset . 4)))))
