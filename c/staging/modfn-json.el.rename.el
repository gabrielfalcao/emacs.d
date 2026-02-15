(defconst
  json-el-all-defnames    ;; (mapc (lambda (item) (end-of-line) (insert (format "\n\"%s\"" item))) (list-of-strings-sorted-by-length modfn-json-defnames))
  (list
   "json-null" "json-read" "json--path" "json-false" "json--print" "json-encode" "json-alist-p" "json-plist-p" "json-key-type" "json-keywords" "json-read-file" "json--print-key" "json--print-map" "json-array-type" "json-encode-key" "json-new-object" "json-read-array" "json--print-list" "json--print-pair" "json-encode-list" "json-object-type" "json-read-number" "json-read-object" "json-read-string" "json--print-alist" "json--print-array" "json--record-path" "json-encode-alist" "json-encode-array" "json-encode-plist" "json-pretty-print" "json-read-keyword" "json--print-string" "json-add-to-object" "json-encode-string" "json-special-chars" "json--print-keyword" "json-encode-keyword" "json--check-position" "json--plist-nreverse" "json-path-to-position" "json-read-from-string" "json--print-stringlike" "json--with-indentation" "json-read-escaped-char" "json--print-indentation" "json-encoding-separator" "json-readtable-dispatch" "json-pretty-print-buffer" "json--print-unordered-map" "json-pretty-print-ordered" "json-encoding-pretty-print" "json-pretty-print-max-secs" "json--with-output-to-string" "json--print-keyval-separator" "json--print-indentation-depth" "json--decode-utf-16-surrogates" "json--print-indentation-prefix" "json-pre-element-read-function" "json-post-element-read-function" "json-pretty-print-buffer-ordered" "json-encoding-default-indentation" "json-encoding-lisp-style-closings" "json-encoding-object-sort-predicate"
   ))

(defun sort-lessp--list-of-strings-sorted-by-length (left right)
  (let* ((len-left (length left))
         (len-right (length right))
         (first-is-shorter (< len-left len-right)))

    (or first-is-shorter
        (and first-is-shorter (value< len-left len-right)))))

(defun list-of-strings-sorted-by-length (seq-obj &optional convert-symbols-and-numbers reverse)
  (sort
   (ensure-list-of-strings seq-obj convert-symbols-and-numbers)
   :key (lambda
          (item)
          (append (list (length item)) (string-to-list item )))
   ;; :lessp #'sort-lessp--list-of-strings-sorted-by-length
   :reverse reverse))


(defun ensure-list-of-strings (seq-obj &optional convert-symbols-and-numbers)
  (unless (sequencep seq-obj)
    (signal 'type-error
            (format  "wrong type argument `seq-obj' is a `%s', not a sequence: %s"
                     (type-of seq-obj)
                     seq-obj)))
  (seq-map-indexed
   (lambda (item index)
     (unless (or
              (stringp item)
              (and convert-symbols-and-numbers
                   (or
                    (symbolp item)
                    (numberp item)
                    (null item)
                    (eq t item))))
       (signal 'type-error
               (format  "element at index %d of sequence `seq-obj' is a `%s', not a string: %S"
                        index
                        (type-of seq-obj)
                        seq-obj)))
     (substring-no-properties (format "%s" item)))
   seq-obj))

(defun get-string-and-suffix-positions (seq-obj)
  "takes a list of strings and returns a list of cons which maps each string of the original list to a list of indexes where that string is a prefix of a wider string"
  (let* ((string-seq (list-of-strings-sorted-by-length seq-obj))
         (count (length string-seq))
         (index 0))
    (seq-map-indexed
     (lambda (item index)
       (let* ((len-item (length item))
              (rev-index count)
              (rev-item (nth (- rev-index 1) string-seq))
              (pos nil)
              (result (list)))
         (while (> (- rev-index 1) 0)
           (setq rev-index (- rev-index 1))
           (setq rev-item (nth rev-index string-seq))
           (setq pos (string-search item rev-item))
           (unless (or (null pos) (= index rev-index)) (push rev-index result)))
         (list item result)))
     string-seq)))

(defun sort-lessp--list-of-strings-sorted-by-length-and-uniqueness (left right)
  (let* ((len-left (length left))
         (len-right (length right))
         (first-is-shorter (< len-left len-right)))

    (or first-is-shorter
        (and first-is-shorter (value< len-left len-right)))))


(defun list-of-strings-sorted-by-length-and-uniqueness (seq-obj &optional convert-symbols-and-numbers reverse)
  (let* ((with-suffix-positions (get-string-and-suffix-positions seq-obj))
         (count (length with-suffix-positions))
         (index 0)
         (index-where-positions-first-occur nil)
         (result (list)))
    (erase-c-messages)
    (c-message-open "")

    (while (< index count)
      (let* (
             (elt (nth index with-suffix-positions))
             (item-string (car elt))
             (positions (cadr (elt)))
             (tag-open (format "<index:%d>" index))
             (tag-close (format "</index:%d>" index))
             (lines (list
                     tag-open
                     (format "positions: %s" (type-of positions))
                     (format "string: %S" item-string)
                     tag-close
                     ))
             )
        (c-message "%s" (string-join https://www.netflix.com/watch/81764695?trackId=14170286&tctx=1%2C0%2C36603864-7635-41b8-a636-740c23b33f4d-51011296%2CNES_0E8696AF8CCD5113A3F704621F1737-994911DC4F528C-96D0E2F08C_p_1771136473282%2CNES_0E8696AF8CCD5113A3F704621F1737_p_1771136473282%2C%2C%2C%2C%2CVideo%3A81303831%2CminiDpPlayButton lincoln lawyer s4 e5 42:33 bg music


  (sort
   (ensure-list-of-strings seq-obj convert-symbols-and-numbers)
   :key (lambda
          (item)
          (append (list (length item)) (string-to-list item )))
   ;; :lessp #'sort-lessp--list-of-strings-sorted-by-length
   :reverse reverse))

;; (progn
;;   (widen)
;;   (seq-map-indexed
;;    (lambda (def-name index)
;;      (beginning-of-buffer)
;;      (replace-regexp def-name
;;                      (format "modfn-%s" def-name)
;;                      t
;;                      (point-min)
;;                      (point-max)))
;;    modfn-json-defnames)  )
