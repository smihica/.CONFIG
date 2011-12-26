(defmacro ap1 (lis item)
  `(setq ,lis (append (list ,item) ,lis)))

(defmacro append-auto-mode-alist (regex mode)
  `(ap1 auto-mode-alist (cons ,regex ,mode)))

;;defmode
(defmacro defmode (name regexp &rest options)
  `(progn
     (autoload ',name ,(symbol-name name) nil t)
     (append-auto-mode-alist ,regexp ',name)
     ,@options))

(defmacro defmodes (&rest modename-file-reg-s)
  `(progn ,@(mapcar (lambda (x) `(defmode ,@x)))))

;;global-set-keys
(defun global-set-keys-iter (lis)
  (when lis
    `((global-set-key ,(car lis) ,(cadr lis))
      ,@(global-set-keys-iter (cddr lis)))))

(defmacro global-set-keys (&rest key-action-pairs)
  `(progn ,@(global-set-keys-iter key-action-pairs)))

(defmacro global-unset-keys (&rest keys)
  `(progn
     ,@(mapcar (lambda (x)
                 `(global-unset-key ,x)) keys)))

