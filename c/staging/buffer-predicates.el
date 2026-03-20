(defun disable-read-only-mode ()
  "shortcut to (read-only-mode -1)"
  (read-only-mode -1))

(defun enable-read-only-mode ()
  "shortcut to (read-only-mode 1)"
  (read-only-mode 1))


(defun buffer-list-builtin-only ()
  "returns all open emacs-only buffers, i.e: starting and ending in `*'."
  (seq-filter
   (apply-partially #'string-match-p "^[*].*[*]$")
   (mapcar 'buffer-name (buffer-list))))

(defun only-builtin-buffers-open-p ()
  "returns `t' if all open buffers are only emacs buffers as determined by `buffer-list-builtin-only'"
  (=
   (length (buffer-list))
   (length (buffer-list-builtin-only))))

(defun buffer-list-existing-files-only ()
  "returns all open emacs buffers which point at actually existing files."
  (seq-filter
   #'(lambda (buf)
       (and
        (not (null (buffer-file-name buf)))
        (file-exists-p (buffer-file-name buf))))
   (buffer-list)))

(defun erase-all-non-file-buffers ()
  "."
  (interactive)
  (ignore-errors
    (erase-scratch)
    (erase-messages)
    (mapcar #'erase-buffer-by-name (buffer-list-builtin-only))))

(defun erase-buffer-by-name (buffer-name)
  "."
  (let ((buffer-to-erase (get-buffer  buffer-name)))
    (if (bufferp buffer-to-erase)
        (with-current-buffer buffer-to-erase
          (let ((buffer-was-read-only
                 (when (and
                        (numberp buffer-read-only)
                        (< buffer-read-only 0)))))
            (read-only-mode -1)
            (widen)
            (erase-buffer)
            (if buffer-was-read-only (read-only-mode 1)))) ;; end inner let
      ) ;;end if
    ) ;; end outer let
  )

(defun erase-messages ()
  "."
  (interactive)
  (erase-buffer-by-name  "*Messages*"))

(defun erase-scratch ()
  "."
  (interactive)
  (erase-buffer-by-name  "*Scratch*"))


(defun buffer-is-current-p (buffer-or-name)
  (let* (
         (buffer (and buffer-or-name (get-buffer buffer-or-name)))
         )
    (eq buffer (current-buffer))))

(condition-case err
    (with-c-message-open
     (c-message "%S" (buffer-is-current-p (current-buffer))))
  (error
   (ignore-errors
     (display-warning 'emacs  (format "error in call to `with-c-message-open': %s" err) :
