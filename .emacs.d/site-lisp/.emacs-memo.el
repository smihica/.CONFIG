;; zenkaku<->hankaku
;; (defun zenkaku-katakana-region (min max)
;;   (interactive "r")
;;   (save-excursion
;;     (goto-char min)
;;     (while (re-search-forward "\\ck+" max t)
;;       (japanese-zenkaku-region (match-beginning 0) (match-end 0)))))
;; (defun zenkaku-katakana-buffer ()
;;   (interactive)
;;   (zenkaku-katakana-region (point-min) (point-max)))
;; (defun zenkaku-katakana-at-point (&optional point)
;;   (interactive)
;;   (setq point (or point (point)))
;;   (when (looking-at "\\ck+")
;;     (forward-char 1)
;;     (backward-word 1)
;;     (re-search-forward "\\ck+")
;;     (zenkaku-katakana-region (match-beginning 0) (match-end 0))))

;; sdic-mode
;; (setq load-path (cons "/usr/local/share/emacs/22.2/site-lisp/sdic" load-path))
;; (autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
;; (global-set-key "\C-cw" 'sdic-describe-word)
;; (autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
;; (global-set-key "\C-cW" 'sdic-describe-word-at-point)

;web4r
;; (load "~/.el/web4r.el")

;;cscope
;; (require 'xcscope)
;; useage M-x cscope-index-fiiles

;;for-windows only.this is not safe. should not be set in case of only linux.
;; (add-hook 'find-file-hooks
;;           (lambda ()
;;             (if (string-match "^/C/.+" buffer-file-name)
;;                 (setq write-region-inhibit-fsync t)
;;                 (setq write-region-inhibit-fsync nil))))


;(load "arduino-mode")
;(setq auto-mode-alist (cons '("\\.pde$" . arduino-mode) auto-mode-alist))
;(defmode arduino-mode "\\.pde$"
;  (add-hook 'arduino-mode-hook
;            '(lambda ()
;              (c-set-style "BSD")
;              (setq tab-width 2)
;              (setq indent-tabs-mode nil)
;              (setq c-tab-always-indent nil)
;              (setq c-basic-offset 2)
;              (setq show-trailing-whitespace t))))

;; kahua
;; (require 'kahua)
;; (append-auto-mode-alist "\\.kahua$" 'kahua-mode)
;; (setq auto-mode-alist (append '(( . )) auto-mode-alist))
;; (setq kahua-site-bundle (expand-file-name "~/kahua"))

;; rails
;; (defun try-complete-abbrev (old)
;;   (if (expand-abbrev) t nil))
;; (setq hippie-expand-try-functions-list
;;       '(try-complete-abbrev
;;         try-complete-file-name
;;         try-expand-dabbrev))
;; (setq rails-use-mongrel t)
;; (setq auto-mode-alist (cons '("\\.rhtml$" . ruby-mode) auto-mode-alist))
;; (require 'rails)
;; (define-key rails-minor-mode-map "\C-c\C-p" 'rails-lib:run-primary-switch)
;; (define-key rails-minor-mode-map "\C-c\C-n" 'rails-lib:run-secondary-switch)


;; (defun sbcl-start ()
;;   (interactive)
;;   (shell-command "/usr/local/bin/sbcl --core /home/nagayoru/.sbcl/mylisp.core --load /home/nagayoru/.sbcl/.slime.lisp &"))


;(defmode bison-mode "\\.y$")

;; (add-to-list 'load-path "~/.el/slime-2009-01-02/slime/contrib")
;; (add-hook 'slime-load-hook (lambda () (require 'slime-scheme)))

;; (require 'slime-scheme)
;; (slime-scheme-init)

;; (setq slime-lisp-implementations
;;       '((gauche ("gosh") :init gauche-init)))

;; (defun gauche-init (file encoding)
;;   (format "%S\n\n"
;;           `(begin
;;              (add-load-path "/home/nagayoru/.el/swank-gauche-0.2") ;; add load path to swank-gauche.scm
;;              (require "swank-gauche")
;;              (import swank-gauche)
;;              (start-swank ,file))))

;; (defun gauche ()
;;   (interactive)
;;   (slime 'gauche))

;; (defun find-gauche-package ()
;;   (interactive)
;;   (let ((case-fold-search t)
;;         (regexp (concat "^(select-module\\>[ \t']*"
;;                         "\\([^)]+\\)[ \t]*)")))
;;     (save-excursion
;;      (when (or (re-search-backward regexp nil t)
;;                (re-search-forward regexp nil t))
;;        (match-string-no-properties 1)))))

;; (setq slime-find-buffer-package-function 'find-gauche-package)


;; elscreen
;(autoload 'elscreen "ElScreen" nil t)
;(setq elscreen-tab-display-kill-screen nil)
;(setq elscreen-display-tab nil)

;; howm
;(setq howm-menu-lang 'ja)
;(global-set-key "\C-c,," 'howm-menu)
;(autoload 'howm-menu "howm-mode" "Hitori Otegaru Wiki Modoki" t)


(defun adding-face (symbol face)
  (let ((r (concat "\\([^']\\|^\\)(\\(" (symbol-name symbol) "\\)[ \n)]")))
    (font-lock-add-keywords 'lisp-mode (list (list r 2 face)))))

(defun adding-func (symbol indent face)
  (put symbol 'lisp-indent-function indent)
  (adding-face symbol face))

;(put 'defpage 'lisp-indent-hook 'defun)
;(web4r-face 'defpage 'font-lock-keyword-face)
;(web4r-face 'define-validator 'font-lock-keyword-face)
;(put '|defclass*| 'lisp-indent-hook 'defun)
;(adding-face '|defclass*| 'font-lock-keyword-face)
