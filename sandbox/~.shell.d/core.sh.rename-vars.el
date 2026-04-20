;; \(\(default\|actual\)_\(shell_d_path\|x_d_path\)\) → shell_d_core_\1

(defun is-valid-bash-varname (varname)
  (unless (stringp varname)
    (signal 'type-error
            (format  "is-valid-bash-varname argument `varname' must be either nil or string but instead received `%s': %s"
                     (type-of varname)
                     varname))))

  (string-match-p "^[a-zA-Z_][a-zA-Z0-9_]+$" name)

(defun rename-bash-variable (varname new-varname)
(let* (

  (point-before (- (match-beginning 1) 1))
  (point-after (+ (match-end 1) 1))
  (char-before (char-at-point point-before))
  (char-after (char-at-point point-after))
  (is-assignment (and (string= char-before " ")
		      (string= char-after "=")))
  (is-braced (and (string= char-before "{")
		  (string= char-after "}")))
  (c-message-open "")
  (c-message ""))
