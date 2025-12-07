# strings
foo="bar"
bar='foo bar'

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
    "a"
    "b"
    "c"
)
# associative arrays
my_associative_array=( ["foo"]="bar" [2]="two" ["two"]=2 )
