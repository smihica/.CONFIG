
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defconst ignores-in-site-lisp '("CVS" "cvs" ".svn" ".git"))
(defun my-site-lisp-registration (directory required-depth)
  (progn
    (let ((epath (expand-file-name directory)))

      ;; set to load-path
      (unless (member epath load-path)
        (setq load-path (cons epath load-path)))

      (when (< 0 required-depth)
        (dolist (item (directory-files epath t "^[^\.]"))
          (when (and (not (member (file-name-nondirectory item) ignores-in-site-lisp))
                     (file-directory-p item))
            (my-site-lisp-registration item (1- required-depth))))))))


;; set load-path to ~/.emacs.d/site-lisp
(defconst my-site-root (expand-file-name "~/.emacs.d/site-lisp"))
(defconst my-elpa-root (expand-file-name "~/.emacs.d/elpa"))
(my-site-lisp-registration my-site-root 1)

(load ".emacs-util.el")
(load ".emacs-environment-settings")
(load ".emacs-common-settings")

;;
;; write your personal settings follow.
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(emmet-move-cursor-between-quotes t)
 '(foreign-regexp/regexp-type (quote javascript))
 '(package-selected-packages
   (quote
    (slime scala-mode sass-mode rust-mode flycheck emmet-mode clojure-mode)))
 '(reb-re-syntax
   (quote foreign-regexp/re-builder/query-replace-on-target-buffer))
 '(safe-local-variable-values
   (quote
    ((web-mode-css-indent-offset . 4)
     (web-mode-markup-indent-offset . 4)
     (web-mode-code-indent-offset . 4)
     ((web-mode-code-indent-offset . 4))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
