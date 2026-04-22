;; OzsoZGVmdW4gZGlzcGxheS1saXN0IChjb250YWluZXItdmFsdWVzICZvcHRpb25hbCBkaXNwbGF5LWxldmVsIGNvbnRhaW5lci1uYW1lKQo7OyAgKHVubGVzcyAobGlzdHAgY29udGFpbmVyLXZhbHVlcykKOzsgICAgKHNpZ25hbCAndHlwZS1lcnJvcgo7OyAgICAgICAgICAgIChmb3JtYXQgImBjb250YWluZXItdmFsdWVzJyBzaG91bGQgYmUgYSBsaXN0IG5vdCAlczogJXMiCjs7ICAgICAgICAgICAgICAgICAgICAodHlwZS1vZiBjb250YWluZXItdmFsdWVzKQo7OyAgICAgICAgICAgICAgICAgICAgY29udGFpbmVyLXZhbHVlcykpKQo7OyAgKHdoZW4gKG51bGwgZGlzcGxheS1sZXZlbCkKOzsgICAgICAoc2V0cSBkaXNwbGF5LWxldmVsIDApKQo7Owo7OyAgKHdoZW4gKG51bGwgY29udGFpbmVyLW5hbWUpCjs7ICAgICAgKHNldHEgY29udGFpbmVyLW5hbWUgIiIpKQo7Owo7OyAgKHVubGVzcyAoc3RyaW5ncCBjb250YWluZXItbmFtZSkKOzsgICAgKHNpZ25hbCAndHlwZS1lcnJvcgo7OyAgICAgICAgICAgIChmb3JtYXQgImBjb250YWluZXItbmFtZScgc2hvdWxkIGJlIGEgc3RyaW5nIG5vdCAlczogJXMiCjs7ICAgICAgICAgICAgICAgICAgICAodHlwZS1vZiBjb250YWluZXItbmFtZSkKOzsgICAgICAgICAgICAgICAgICAgIGNvbnRhaW5lci1uYW1lKSkpCjs7Cjs7ICAobGV0ICgoc3RhcnQgIiIpIChlbmQgIiIpIChuZXh0LWRpc3BsYXktbGV2ZWwgKCsgMSBkaXNwbGF5LWxldmVsKSkpCjs7ICAgICh3aGVuIChsZW5ndGg+IGNvbnRhaW5lci1uYW1lIDApCjs7ICAgICAgKHNldHEgc3RhcnQgKGZvcm1hdCAiOzsgPGxpc3QgbmFtZT1cIiVzXCI+IiBjb250YWluZXItbmFtZSkKOzsgICAgICAgICAgICBlbmQgKGZvcm1hdCAiOzsgPC9saXN0IG5hbWU9XCIlc1wiPiIgY29udGFpbmVyLW5hbWUpKSkKOzsgICAgKG1hcGNhciAjJyhsYW1iZGEgKGl0ZW0pCjs7ICAgICAgICAgICAgICAgIChsZXQqICgKOzsgICAgICAgICAgICAgICAgICAgICAgIChpdGVtLXR5ICh0eXBlLW9mIGl0ZW0pKQo7OyAgICAgICAgICAgICAgICAgICAgICAgKQo7OyAgICAgICAgICAgICAgICAgIChjb25kICgoc3RyaW5ncCBpdGVtKQo7OyAgICAgICAgICAgICAgICAgICAgICAgICAoZm9ybWF0ICIlUyIgaXRlbSkpCjs7Cjs7ICAgICAgICAgICAgICAgICAgICAgICAgKChudW1iZXJwIGl0ZW0pCjs7ICAgICAgICAgICAgICAgICAgICAgICAgIChmb3JtYXQgIiVkIiBpdGVtKSkKOzsKOzsgICAgICAgICAgICAgICAgICAgICAgICAoKGxpc3RwIGl0ZW0pCjs7ICAgICAgICAgICAgICAgICAgICAgICAgIChkaXNwbGF5LWxpc3QgaXRlbSBuZXh0LWRpc3BsYXktbGV2ZWwpKQo7Owo7OyAgICAgICAgICAgICAgICAgICAgICAgICh0Cjs7ICAgICAgICAgICAgICAgICAgICAgICAgIChwcm9nbgo7OyAgICAgICAgICAgICAgICAgICAgICAgICAgIChtZXNzYWdlICInKGRpc3BsYXktbGlzdCkgd2FybmluZzogdW5rbm93biB0eXBlICVTIGZvciBpdGVtICVTIiBpdGVtLXR5IGl0ZW0pCjs7ICAgICAgICAgICAgICAgICAgICAgICAgICAgKGZvcm1hdCAiJVMgOzsgdHlwZSAlUyIgaXRlbSBpdGVtLXR5KSkpCjs7ICAgICAgICAgICAgICAgICAgICAgICAgKSA7OyBlbmQgY29uZAo7OyAgICAgICAgICAgICAgICAgICkgOzsgZW5kIGxldCoKOzsgICAgICAgICAgICAgICAgKSA7OyBlbmQgbGFtYmRhCjs7ICAgICAgICAgICAgY29udGFpbmVyLXZhbHVlcwo7OyAgICAgICAgICAgICkgOzsgZW5kIG1hcGNhcgo7OyAgICApIDs7IGVuZCBsZXQKOzsgICkgOzsgZW5kIGRlZnVuIGRpc3BsYXktbGlzdAo7Owo=

(defun uncollapse-repeated-open-or-close-parenthesis(string)
  (let* (
         (regexp "\\([()]\\)\\(\\1\\)+")
         (result string)
         (rounds -1)
         (states (list))
         (state-count 0)) ;; end let* varlist

    (save-match-data
      (string-match regexp result)
      (while (string-match regexp result)
        (setq rounds (+ 1 rounds))
        (let* (
               (parens-char (match-string 1 result))
               (extra-occurrences (match-string 2 result))
               (whole-match (match-string 0 result))
               (new-text (uncollapse-repeated-open-or-close-parenthesis--explode-levels parens-char extra-occurrences))
               (states-list (pp-to-string states))) ;; end let varlist
          (c-message-debug-symbols (list 'result 'states-list 'new-text 'whole-match)
            'state-count
            'string
            'parens-char
            'extra-occurrences)
          (setq result (replace-match new-text nil nil result))
          (setq states (append states (list result)))
          (setq state-count (length states))))))) ;; end let ;; end while ;; end save-match-data ;; end let* ;; end defun

(defun uncollapse-repeated-open-or-close-parenthesis--explode-levels(parens-char extra-occurrences)
  (unless (stringp parens-char)
    (signal 'type-error
      (format "`parens-char' should be a string not %s: %s"
        (type-of parens-char)
        parens-char)))
  (unless (= (length parens-char) 1)
    (signal 'type-error
      (format "`parens-char' should be a string of length 1 but length is: %d"
        (length parens-char))))
  (unless (stringp extra-occurrences)
    (signal 'type-error
      (format "`extra-occurrences' should be a string not %s: %s"
        (type-of extra-occurrences)
        extra-occurrences)))

  (let* (
         (total-levels (length extra-occurrences))
         (len (+ 1 total-levels))
         (levels (number-sequence 0 total-levels)))
    (string-join
      (mapcar
        (lambda (n)
          (let ((padding-left "") (sol ""))
            (when (> n 0)
              (setq sol "#")
              (when (string= "(" parens-char)
                (setq padding-left (make-string (* n 2) (ash 1 5)))))
            (format "%s%s%s\n" sol padding-left parens-char)))
        levels))))

(progn
  (enable-debug-on-error)
  (erase-c-messages)
  (let* (
         (input-string "()((())())")
         groupies)
    (setq groupies
      (uncollapse-repeated-open-or-close-parenthesis
        input-string))

    (c-message "<groups>\n%s\n</groups>\n" groupies)))
