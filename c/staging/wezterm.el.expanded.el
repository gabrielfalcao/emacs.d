(defun wezterm-cli-run-command (command args &optional pane-id)
  (unless (stringp command)
    (signal 'type-error
      (format "`wezterm-cli-run-command' argument `command' must be string but instead received `%s': %S"
        (type-of command)
        command)))

  (progn
    (unless (listp args)
      (signal 'type-error
        (format "`wezterm-cli-run-args' argument `args' must be a list but instead received `%s': %S"
          (type-of args)
          args)))
    (seq-do-indexed
      #'(lambda (arg index)
         (unless (stringp elt)
          (signal 'type-error
           (format "`wezterm-cli-run-elt' index %d of `list' argument `args' should be `string' but is %s: %S"
            index
            (type-of elt)
            elt))))
      args))

  (unless (or (stringp pane-id) (null pane-id))
    (signal 'type-error
      (format "`wezterm-cli-run-pane-id' argument `pane-id' must be either nil or string but instead received `%s': %s"
        (type-of pane-id)
        pane-id)))
  t)
