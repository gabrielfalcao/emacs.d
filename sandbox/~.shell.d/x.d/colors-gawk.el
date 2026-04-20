 → \,(let* (
    (color-name (downcase (format "%s %s" \2 \1)))
    (ansi-rgb-triple \3)
    (red (string-to-number \4))
    (green (string-to-number \5))
    (blue (string-to-number \6))
    (hex-rgb (format "#%02X%02X%02X" red green blue))
  )
 (string-join (mapcar
 (lambda (item) (format "%s" item) )
              (list )
)
 "\n")
)
