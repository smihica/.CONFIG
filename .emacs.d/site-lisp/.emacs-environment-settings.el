(defvar *emacs-type* 'unknown-emacs)
(defun get-running-environment ()
  (when (< emacs-major-version 22)
    (error "This Emacs version is %s.\n .emacs reqires Emacs that of version 22 or later."  emacs-major-version))
  (cond ((or
          (eql system-type 'berkeley-unix) ;; FreeBSD
          (eql system-type 'gnu/linux))    ;; Linux
         'gnu)
        ((featurep 'xemacs)
         'x)
        ((and
          (eql system-type 'windows-nt)
          (featurep 'meadow))
         'meadow)
        (t ;(eql system-type 'mac-os-x) ;; mac os X carbon or cocoa
         (or 'cocoa 'carbon))))

(setq *emacs-type* (get-running-environment))

(load (format ".emacs-%s" (symbol-name *emacs-type*)))
