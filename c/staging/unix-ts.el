(defclass unixtimestamp ()
  (
    (seconds :initarg :seconds
      :type ;(and integer natnump)
      integer
      :allocation
      :instance
      :documentation
      "(natural) number of seconds since epoch"
      :label
      "number of seconds since epoch"))

  :documentation
  "Stores unix timestamp in seconds since epoch as well as nanoseconds,
microseconds, milliseconds and timezone.

This class is primarily s high-level container for data generated
through the `unix-ts' function.")

(defun unix-ts (&optional time zone)
  "Returns a list with 2 items, both natural numbers, respectively
`seconds' and `nanoseconds' relative to the `current-time' and universal
timezone (UTC) when called without arguments.

The optional arguments TIME and ZONE, follow the same logic and
semantics of the arguments of `format-time-string'.
"
  (let* (
         (time (or time (current-time)))
         (unix-seconds (format-time-string "%s" time zone))
         (nano-seconds (format-time-string "%N" time zone))
         ;; (micro-seconds (format-time-string "%6N" time zone))
         ;; (milli-seconds (format-time-string "%3N" time zone))
         )
    (list unix-seconds nano-seconds)))
