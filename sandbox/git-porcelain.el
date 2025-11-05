;; (defun meta-function-map-git-status-man-output-class-characters-to-assoc-lists(beg end)
;;   (interactive "*r")
;;   (let* ((regexp "^`\\([[:space:]ACDMRTU!?]\\)'\\s-*=\\s-*\\(\\([a-z]+\\)\\(\\s-*\\([a-z]+\\|\\s-*\\)*\\)\\(\\s-+\\([(].*\\)\\)*\\)?$")
;;          (replace-groups "
;; ((string= \"\1\" input)
;;  (list '\3
;; "))))
;; 
(defconst git-status-porcelain-class-regexp
  "^`\\([[:space:]ACDMRTU!?]\\)'\\s-*=\\s-*\\(\\([a-z]+\\)\\(\\s-*\\([a-z]+\\|\\s-*\\)*\\)\\(\\s-+\\([(].*\\)\\)*\\)?$")

(defconst git-status-porcelain-class-replacement
  "((string= \"\1\" input)\n (list :sym '\3\n :desc \"\4\"\n :long_desc \"\2\"\n :note \"\7\"\n) \n;; \\3 => \3\n;; \\6 => \6\n;; end list \n);; end clause\n\n"
  )
(defun refactor-defun-map-git-porcelain-buffer(beg end)
  (interactive "*r")
  (save-mark-and-excursion
    (widen)
    (beginning-of-buffer)
    (save-mark-and-excursion
      (replace-regexp-in-region
       git-status-porcelain-class-regexp
       git-status-porcelain-class-replacement
       beg
       end
       ))
    (save-mark-and-excursion
      (flush-lines ":note\s-+\"\"" beg end nil)
      )
    (save-mark-and-excursion
      (flush-lines ";\s-*\\[36]" beg end nil)
      )
    )
  )

(defun insert-defun-map-git-porcelain (buffer-or-name)
  "inserts an incomplete implementation of (defun map-git-porcelain) in `buffer-or-name', signals `error' if `buffer-or-name' is neither a buffer nor an existing buffer-name."
  (if (and (not (bufferp buffer-or-name))
           (or (not (stringp buffer-or-name))
               (not (bufferp (get-buffer buffer-or-name)))
               ))
      (error "`buffer-or-name' should be either `bufferp' or `stringp', instead got %S" buffer-or-name))

  (let* (
         (target-buffer (get-buffer buffer-or-name))
         (wip-defun
	  (base64-decode-string
           "KGRlZnVuIG1hcC1naXQtcG9yY2VsYWluKGNoYXIpCiAgIi4iCiAgKGNvbmQKCmAgJyA9IHVubW9kaWZpZWQKYCEnID0gaWdub3JlZApgPycgPSB1bnRyYWNrZWQKYEEnID0gYWRkZWQKYEMnID0gY29waWVkIChpZiBjb25maWcgb3B0aW9uIHN0YXR1cy5yZW5hbWVzIGlzIHNldCB0byBcImNvcGllc1wiKQpgRCcgPSBkZWxldGVkCmBNJyA9IG1vZGlmaWVkCmBSJyA9IHJlbmFtZWQKYFQnID0gZmlsZSB0eXBlIGNoYW5nZWQgKHJlZ3VsYXIgZmlsZSwgc3ltYm9saWMgbGluayBvciBzdWJtb2R1bGUpCmBVJyA9IHVwZGF0ZWQgYnV0IHVubWVyZ2VkCgopCiAgKQo="
           t) ;;end base64-decode-string
	  )) ;;end (let) varlist
    (with-current-buffer target-buffer
      (save-mark-and-excursion
        (widen)
        (beginning-of-buffer)
        (insert wip-defun)))))


(defun gen-defun-map-git-porcelain ()
  "generates lisp code that defines the function `map-git-porcelain' and returns its complete code as string"
  (with-temp-buffer ;; create temp buffer
    ;; insert incomplete defun
    (insert-defun-map-git-porcelain (current-buffer))
    ;; complete defun (refactor)
    (save-mark-and-excursion
      (widen)
      (beginning-of-buffer)
      (refactor-defun-map-git-porcelain-buffer (point-min) (point-max)))
    ;; return buffer contents as string
    (save-mark-and-excursion
      (widen)
      (beginning-of-buffer)
      (buffer-substring-no-properties (point-min) (point-max)
				      ))))

(with-current-buffer
    (let ((code (gen-defun-map-git-porcelain)))
      (save-mark-and-excursion
	(widen)
	(end-of-buffer)
	(insert "\n\n;; (defun map-git-porcelain)\n")
	(end-of-buffer)
	(insert code))
      (end-of-buffer)
      ))


;; (defun map-git-porcelain(char)
;;   "."
;;   (cond
;;    ((string= " " input)
;;     (list :sym 'unmodified
;; 	  :long_desc "unmodified"
;; 	  )
;;     )
;;    ((string= "!" input)
;;     (list :sym 'ignored
;; 	  :long_desc "ignored"
;; 	  )
;;     )
;;    ((string= "?" input)
;;     (list :sym 'untracked
;; 	  :long_desc "untracked"
;; 	  )
;;     )
;;    ((string= "A" input)
;;     (list :sym 'added
;; 	  :long_desc "added"
;; 	  )
;;     )
;;    ((string= "C" input)
;;     (list :sym 'copied
;; 	  :long_desc "copied (if config option status.renames is set to \"copies\")"
;; 	  :note "(if config option status.renames is set to \"copies\")"
;; 	  )
;;     )
;;    ((string= "D" input)
;;     (list :sym 'deleted
;; 	  :long_desc "deleted"
;; 	  )
;;     )
;;    ((string= "M" input)
;;     (list :sym 'modified
;; 	  :long_desc "modified"
;; 	  )
;;     )
;;    ((string= "R" input)
;;     (list :sym 'renamed
;; 	  :long_desc "renamed"
;; 	  )
;;     )
;;    ((string= "T" input)
;;     (list :sym 'file
;; 	  :desc " type changed"
;; 	  :long_desc "file type changed (regular file, symbolic link or submodule)"
;; 	  :note "(regular file, symbolic link or submodule)"
;; 	  )
;;     )
;;    ((string= "U" input)
;;     (list :sym 'updated
;; 	  :desc " but unmerged"
;; 	  :long_desc "updated but unmerged"
;; 	  )
;;     )
;;    (t (list))
;;    )
;;   )
