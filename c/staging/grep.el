p(defun subprocess-get-outputs--tmp-buffer-name (name &optional prefix  suffix)
  (unless (stringp name)  (signal 'type-error (format "argument `name' must be a string but instead received `%s': %s" (type-of name) name)))
  (unless (or ( null prefix) (stringp prefix))  (signal 'type-error (format "argument `prefix' must be a string but instead received `%s': %s" (type-of prefix) prefix)))
  (unless (or ( null suffix) (stringp suffix))  (signal 'type-error (format "argument `suffix' must be a string but instead received `%s': %s" (type-of suffix) suffix)))

  (when (null prefix)
    (setq prefix (format "subprocess")))

  (when (null suffix)
    (setq suffix (format "%08x" (string-to-number (format-time-string "%s" nil t)))))

  (string-join (list prefix name suffix) "*"))

(defun subprocess-get-outputs--create-tmp-buffer (name &optional prefix suffix)
  (let ((existing-buffer (get-buffer new-buffer-name)))
    (when (not (null existing-buffer)) (kill-buffer existing-buffer)))
  (get-buffer-create (subprocess-get-outputs--tmp-buffer-name name prefix suffix t)))




(defun subprocess-get-outputs (program argv)
  (unless (or (stringp program) (null program)) (signal 'type-error (format "argument `program' must be a string but instead received `%s': %s" (type-of program) program)))
  (unless (or (list-of-strings-p argv) (null argv)) (signal 'type-error (format "argument `argv' must be either nil or a list of strings but instead received `%s': %s" (type-of argv) argv)))

  (when (null argv) (setq argv (list)))

  (let* (
         (stdout-buffer (subprocess-get-outputs--create-tmp-buffer program (string-join (list program "stdout") ":")))
         (stderr-buffer (subprocess-get-outputs--create-tmp-buffer program (string-join (list program "stderr") ":")))
         (call-process-infile     nil)
         (call-process-destination )
         (exit-code
          (call-process program call-process-infile call-process-destination nil argv)))

    ;; (if (string-match "[.][a-z][a-z0-9-]+rc$" current-filename)
    ;;     ;; explicitly specify parser to prettier when filename ends with `.*rc'
    ;;     (append (list "--parser" "json") prettierjs-args)
    ;;   ;;
    ;;   prettierjs-args)
    ;; ))))

    (message


(defun grep (pattern &optional path)
  (let* ((
