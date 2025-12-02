;;; rgb-parser --- Parse RGB colors from hexadecimal strings; -*- lexical-binding: t -*-
;;
;; Author: Gabriel Falcao <gabrielteratos@gmail.com>
;; URL: https://github.com/gabrielfalcao/rgb-parser.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "28.1"))
;;
;; Copyright (C) 2025-2025  Gabriel Falcao
;;
;;; Code:

(require 'seq)

(define-error 'rgb-parse-mismatch-error "Mismatch Error" 'rgb-parse-error)
(define-error 'rgb-parse-invalid-match-error "Invalid Match Error" 'rgb-parse-error)
(define-error 'rgb-parse-runtime-error "Runtime Error" 'rgb-parse-internal)

(defconst rgb-parse-total-regex-groups
  3)

(defconst rgb-parse-regex-prefix
  "\\b\\([#]\\|0x\\|\\b\\)?")

(defconst rgb-parse-regex-prefix
  "\\b\\([#]\\|0x\\|\\b\\)?")

(defconst hex-regex-whole-band
  "\\([A-F0-9]\\{2\\}\\)")

(defconst hex-regex-min-unit
  "\\([A-F0-9]\\)")

(defconst hex-regex-delta-to-first-band-subext
  3
  "how many regexp groups to skip to get to the first band (red)")

(defconst hex-regex-rgb-bands-long
  (format "%s\\(%s\\)\\b" rgb-parse-regex-prefix (string-join (make-list rgb-parse-total-regex-groups hex-regex-min-unit) "\\|" )))
(defconst hex-regex-rgb-bands-abbrev
  (format "%s\\(%s\\)\\b" rgb-parse-regex-prefix (string-join (make-list rgb-parse-total-regex-groups hex-regex-whole-band) "\\|")))

(defconst rgb-band-symbols
  (seq-map-indexed
   #'(lambda (band index)
       (let* ((name (symbol-name band))
              (symbol (intern (format "rgb-parser-band-%s" name)))
              (place (+1 index))
              (subexp (+ index hex-regex-delta-to-first-band-subext))
              (props (setplist symbol (list
                                       :index index
                                       :place place
                                       :first (= 1 place)
                                       :last (= 3 place)
                                       :name name
                                       :subexp subexp))))
         symbol))
   (list 'red 'green 'blue))
  "propertized symbols for each band: `red', `green' and `blue'."
  )

(defun throw-rgb-parser-runtime-error (fmt &rest args)
  (signal
   'rgb-parse-runtime-error
   (apply #'format (append (list fmt) args))))

(defun throw-rgb-band-symbol-inconsistent-name (symbol expected actual)
  (throw-rgb-parser-runtime-error
   "symbol `%S' should have `:name' `%S' but is `%S'" (symbol-value symbol) name internal-name))

(c-message-open "%s" (list (keywordp :red) (symbol-name :red) (symbol-value :red) ))
(defun rgb-band-keyword (band &optional noerror)
  "returns an intern symbol matching one of the 3 RGB bands.

`band' is a keyword, symbol or string corresponding to `red', `green' or `blue'.
"

(defun rgb-band-symbol (band &optional noerror)
  "returns an intern symbol matching one of the 3 RGB bands.

`band' is a keyword, symbol or string corresponding to `red', `green' or `blue'.
"
  (let* ((name (string-trim-left (format "%s" band) ":+"))
         (symbol (intern (format "rgb-parser-band-%s" name)))
         (internal-name (get symbol :name))
         (name-matches (string= name internal-name)))

    (cond (name-matches symbol)
          ((not noerror)
           (throw-rgb-band-symbol-inconsistent-name symbol name internal-name))
          nil)))



(defun get-rgb-band-subexp (band)
  "`band' is the same form as `rgb-band-symbol'"
  (let* ((symbol (rgb-band-symbol band))
         match match-length hexadecimal value
         )
    (let-alist (seq-partition (symbol-plist symbol) 2)
      (setq match (match-string .subexp



  (condition-case err
      (cond ((equal (symbol-value symbol) 'red)
             hex-regex-delta-to-first-band-subext
(defun match-rgb-parse (string &optional noerror)
  "tries to match hexadecimal RGB from `string' using either
`hex-regex-rgb-bands-abbrev' or
`hex-regex-rgb-bands-long'. Signals `rgb-parse-mismatch-error' in
case of failure unless `noerror' is non-nil.

this function modifies global match data and so you probably want
to call it from within the body of `save-match-data'"
  (cond (when-let* ((match-index (string-match hex-regex-rgb-bands-abbrev string))
                    (match-width 1)
                    (get-band #'(lambda (band)
                                  (cond

        (string-match hex-regex-rgb-bands-long string)
        ((null noerror)
         (signal
          'rgb-parse-mismatch-error
          (format "Could not parse hexadecimal RGB color from string `%s'" string)))))


(let* ((target "#fce94f")
       (rgb-bands (save-match-data
                    (match-rgb-parse target)
                    (seq-map-indexed
                   #'(lambda (band index)

                        (let* ((name (symbol-name band))
                               (subexp (+ index hex-regex-delta-to-first-band-subext))
                               (match (match-string subexp))
                               (hexadecimal (cond ((length= match 2) match)
                                                  ((length= match 1) (string-join (make-list 2 match) ""))
                                                  (signal
                                                   'rgb-parse-invalid-match-error
                                                   (format "Could not parse hexadecimal RGB color from string `%s'" string)))))



                               (value (string-to-number hex-string 16))
                               (props (setplist band (list
                                                      :index index
                                                      :first (= 1 subexp)
                                                      :last (= 3 subexp)
                                                      :name name
                                                      :subexp subexp
                                                      :hexadecimal hexadecimal
                                                      :value value))))
                          band))
                    (list 'red 'green 'blue))))
       (my-sym 'mysym)
       (my-props (symbol-plist my-sym)))

  ;; (put my-sym 'regexxx 67)
  (setplist my-sym (list
                    :name "Foobar"
                    :age 37
                    :index 1
                    ))



  (c-message-open "my-sym: %S\nmy-props: %S" my-sym my-props)

  (c-message "\n(assoc : %S\nmy-props)" (assq :age (seq-partition my-props 2)))

  )


;; (let* ((my-sym 'mysym)
;;        (my-props (symbol-plist my-sym)))
;;   ;; (put my-sym 'regexxx 67)
;;   (setplist my-sym (list 'regexxx 666))

;;   (c-message-open "my-sym: %S\nmy-props: %S" my-sym my-props))

(provide 'rgb-parser)
