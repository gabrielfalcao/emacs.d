 
BEGIN {
  widest_row_num=0
  widest_row_len=0
  delete lines_by_row_num
  delete printable_row_numbers;
from_line=1;
to_line=3;

}


{ if (NR >=from_line || NR <= to_line) {
   line_len=length($0)
 trimmed_line=gensub(/^\s*(.*)\s*$/, "\1", "g" $0)
 trimmed_line_len=length(trimmed_line_length)
 if (line_len > widest_row_len) {
    widest_row_len = line_len
    widest_row_num = NR
 }
lines_by_row_num[NR]=$0;
trimmed_lines_by_row_num[NR]=trimmed_line;
printable_row_numbers[NR]=NR
field_count_by_row_num[NR]=NF
}

END {
for (num in printable_row_numbers) {
line=lines_by_row_num[num]
printf("%*s %s\n", widest_row_len, num, line)
}
}
}


