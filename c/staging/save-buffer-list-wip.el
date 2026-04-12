(defun proper-error-data (error-symbol message-string props)
  (unless (plistp props)
    (signal 'type-error (format "`proper-error-data' argument PROPS is not a valid property list (%s): %S" (cl-type-of props) props)))
  (unless (symbolp error-symbol)
    (signal 'type-error (format "`proper-error-data' argument ERROR-SYMBOL is not a symbol (%s): %S" (cl-type-of error-symbol) error-symbol)))
  (unless (symbolp message-string)
    (signal 'type-error (format "`proper-error-data' argument MESSAGE-STRING is not a string (%s): %S" (cl-type-of message-string) message-string)))

  (let* (
         ;;
         (default-props (list :error-symbol  error-symbol
                              :error-message message-string
                              :previous-error nil))
         (properties (append default-props props))
         (data (propertize message-string properties))
         ;;
         )
    (list error-symbol data)
    )
  )

(defun throw-error (error-symbol message-string &rest props)
  (apply #'signal (proper-error-data error-symbol message-string props)))



(defun ensure-unix-timestamp (value)
  (let* (
         (min-value 793670400)
         (value-ty      (cl-type-of value))
         (epoch-string (string-trim (format "%s" value)))
         (epoch-number (condition-case err
                           (string-to-number epoch-string)
                         (error
                          (let* ((message (format "cannot ensure that the `%s' %S be a unix timestamp: %S" value-ty value (error-message-string err))))
                          (throw-error 'type-error message 'value value 'previous-error err)))))
         )
  (unless (string-match-p "^[0-9]+$" epoch-string)
    (throw-error 'type-error (format "cannot ensure that the `%s' %S be a unix timestamp" value-ty value)
                 'value value 'epoch-number epoch-number 'epoch-string epoch-string))

  (unless (or (natnump epoch-number) (and (stringp epoch-number) (string-match-p "^1[67][0-9]\\{9,\\}$" epoch-number)))
    (signal 'type-error (format "argument `epoch-number' should be a `natnump' but instead is a `%s': %S" (cl-type-of epoch-number) epoch-number)))

  (unless (>= epoch-number min-value)
    (throw-error 'type-error (format "invalid unix timestamp, %S is too early in time (should be greater than %s)" value min-value)))

  epoch-number))



(defun get-workbench-wip-save-path (epoch &optional no-mkdir)
  (let* (
         ;;
         (epoch (ensure-unix-timestamp (format-time-string "%s")))
         (today (format-time-string "%Y-%m-%d" epoch t))
         (date-YYYY (format-time-string "%Y" epoch t))
         (date-MM (format-time-string "%m" epoch t))
         (date-DD (format-time-string "%d" epoch t))

         (workbench-root (file-name-canonicalize "~/workbench"))
         (workbench-path (file-name-concat workbench-root today))
         (workbench-wip-emacs-path (file-name-concat workbench-path "wip" "emacs"))
         (workbench-wip-buffers-path (file-name-concat workbench-wip-emacs-path
                                                       (format "emacs-buffers")
                                                       (format "emacs-buffers-%s" date-YYYY)
                                                       (format "emacs-buffers-%s-%s" date-YYYY date-MM)
                                                       (format "emacs-buffers-%s-%s-%s" date-YYYY date-MM date-DD)
                                                       (format "emacs-buffers.pid-%s" (emacs-pid))))
         )
    (unless no-mkdir
      (mkdir workbench-wip-buffers-path t))

    workbench-wip-buffers-path
    )
  )

(defun save-open-buffers-as-wip-in-workbench ()
  (interactive)
  (let* ((epoch (string-to-number (format-time-string "%s")))

         (workbench-wip-buffers-path (get-workbench-wip-save-path epoch))
         (workbench-wip-buffers-index-file-path (file-name-concat workbench-wip-buffers-path "index.json"))

         (json-false "false")
         (json-null "null")
         (json-object-type 'plist)
         (json-array-type 'vector)
         (json-key-type 'string)

         (buffers (buffer-list))
         (buffer-count (length buffers))
         (index-file-json-array-items
          (seq-map-indexed
           (lambda (buf index)
             (condition-case err
                 (with-current-buffer buf
	           (let* ((number (1+ index))
		          (pos (format "%d of %d" number buffer-count))
		          (buffer-name-raw (buffer-name buf))
		          (filename (buffer-file-name buf))
		          (is-file (not (null filename)))
		          (buffer-name-fallback
		           (string-to-kebab buffer-name-raw))
		          (wip-filename
		           (format "%s.bkp"
			           (string-to-kebab
                                    (or filename buffer-name-raw))))
		          (wip-full-path
		           (file-name-concat workbench-wip-buffers-path wip-filename))
		          (bufname
		           (if is-file
                               (file-name-nondirectory filename)
                             buffer-name-fallback))
		          (bufcontents
		           (save-match-data
                             (save-mark-and-excursion
                               (widen)
                               (buffer-substring-no-properties
                                (point-min)
                                (point-max)))))
		          (buf-plist-to-json-object
		           (list
		            :index          index
		            :number         number
		            :total          buffer-count
		            :name           bufname
		            :filename       filename
		            :wip_filename   wip-filename
		            :pos            pos
		            :name_raw       buffer-name-raw
		            :is_file (if is-file "true" "false")
		            :contents       bufcontents
		            :size (length bufcontents)
		            ))) ;; end (with-current-buffer (let* ...) varlist )
                     ;; <seq-map-indexed lambda body>
                     (write-region bufcontents         nil wip-full-path nil nil nil nil)
                     ;; </seq-map-indexed lambda body>
                     );; end (let* ...)
	           );; end (with-current-buffer ...)
               (error
                (list :error err)
                )
               ) ;; end (condition-case err...)
               ) ;; end (lambda (buf index)
           buffers) ;; end (seq-map-indexed
          )
         (index-file-contents
          (json-encode index-file-json-array-items)))
    ;; <defun body>

    ;; <write index file>
    (condition-case err
        (write-region index-file-contents nil workbench-wip-buffers-index-file-path nil nil nil nil)
      (error
       (user-error "failed to write index file to %S: %s" workbench-wip-buffers-index-file-path err)))
    ;; </write index file>
    );; end (defun ... (let* ... ))
  );; end (defun save-open-buffers-as-wip-in-workbench)


;;;;(defun throw-error (error-symbol message-string &optional props)
;;;;  (unless (plistp props)
;;;;    (signal 'type-error (format "`throw-error' argument PROPS is not a valid property list (%s): %S" (cl-type-of props) props)))
;;;;  (unless (symbolp error-symbol)
;;;;    (signal 'type-error (format "`throw-error' argument ERROR-SYMBOL is not a symbol (%s): %S" (cl-type-of error-symbol) error-symbol)))
;;;;  (unless (symbolp message-string)
;;;;    (signal 'type-error (format "`throw-error' argument MESSAGE-STRING is not a string (%s): %S" (cl-type-of message-string) message-string)))
;;;;
;;;;  (signal error-symbol (propertize message-string props)))
;;;;
