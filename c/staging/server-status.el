(defun server-status ()
  (let* (
         (clients (copy-sequence server-clients))
         (pid (emacs-pid))
         (status (process-status server-process))
         (total-clients (length clients)))
    (format "server: %s, pid: %s (%d clients)" status pid total-clients)))
