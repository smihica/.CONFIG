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
