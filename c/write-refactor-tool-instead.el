;;;;;;;
;; WIP
(defun shell-script-fix-variable-assignments-region (beg end) ;; WIP
  "."
  ;; WIP
  (interactive "*r")
  (let* ((regexp
          "^\\(\\s-*\\)\\([a-z0-9_]+\\)=\\([$][(].*[)]\\|[$][{][a-z_][a-z0-9_]+[^}]*[}]\\);?\\s-*$")
         (replacement "\1\2=\"\3\""))
    (save-mark-and-excursion
      (replace-regexp-within-bounds regexp replacement beg end))))

;; __      _____ ___ _____ ___
;; \ \    / / _ \_ _|_   _| __|
;;  \ \/\/ /|   /| |  | | | _|
;;   \_/\_/ |_|_\___| |_| |___|
;;
;;  ___ ___ ___ _   ___ _____ ___  ___
;; | _ \ __| __/_\ / __|_   _/ _ \| _ \
;; |   / _|| _/ _ \ (__  | || (_) |   /
;; |_|_\___|_/_/ \_\___| |_| \___/|_|_\
;;
;;  _____ ___   ___  _
;; |_   _/ _ \ / _ \| |
;;   | || (_) | (_) | |__
;;   |_| \___/ \___/|____|
;;
;;  ___ _  _ ___ _____ ___   _   ___    _ _ _
;; |_ _| \| / __|_   _| __| /_\ |   \  | | | |
;;  | || .` \__ \ | | | _| / _ \| |) | |_|_|_|
;; |___|_|\_|___/ |_| |___/_/ \_\___/  (_|_|_)
;;
(defun shell-script-add-missing-declare-statement-to-variable-assignments-region (beg end)
  "
fixes variable assignments missing declare/local

examples:

# strings
foo=\"bar\"

# numbers and math

number_123=123
zero=0
two_fifty_five_from_hex=$(( 0xFF ))
four_twenty_from_oct=$(( 0644 ))
ten_from_base_2=$(( 2#1010 ))
twelve_from_base_8=$(( 8#12 ))
twenty_from_base_10=$(( 10#20 ))
_calculation_pure=$(( 1 + 2 ))
_calculation_var_lhs=$(( $number_123 + 2 ))
calculation_var_rhs=$(( 4 - ${number_123} ))
calculation_var_rhs=$(( -${number_123} ))
calculation_var_both_sides=$(( $number_123 + ${zero} ))
calculation_var_both_sides=$(( ${number_123} + $zero ))

# indexed arrays
my_sorted_array=( {1..7} )
my_alphabet=(
    \"a\"
    \"b\"
    \"c\"
)

# associative arrays
my_associative_array=( [\"foo\"]=\"bar\" )

."
  (interactive "*r")
  (let* ((regexp "^\\(\\s-*\\)?\\([a-zA-Z_][a-zA-Z0-9_]*\\)=\\(\".*?\"\\|[$]((\\(\\s-*\\([-]?\\([0-9]\\|[1-9]+[0-9]*\\)[/*%^+-]\\s-*\\)\\(\\s-*[$]\\([a-zA-Z_][a-zA-Z0-9]*\\|[{][a-zA-Z_][a-zA-Z0-9]*[}]\\)\\s-*\\)\\(\\s-*[/*%^+-][0-9]+\\s-*\\)))\\)\\(\\s-*[;]?\\s-*\\)$")
         (replacement "${\\1}"))
    (save-mark-and-excursion
      (replace-regexp-within-bounds regexp replacement beg end))))

;; WIP
;;;;;;;
