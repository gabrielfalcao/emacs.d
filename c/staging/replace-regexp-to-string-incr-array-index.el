(defun replace-regexp-to-string-fn-incr-array-index-by (&optional by-amount)
  (when (null by-amount) (setq by-amount 1))

  (let* ((prefix (match-string 1))
         (index (string-to-number (match-string 2)))
         (suffix (match-string 3))
         (incr (+ index by-amount)))
    (format "%s%s%s" prefix incr suffix)))


(defun debug-match-data (&optional noerase-c-messages)
  (let* (
         (md (match-data))
         (md-len (length md))
         (pairs (/ md-len 2))
         (subexprs (- pairs 1))
         )
    (erase-c-messages
