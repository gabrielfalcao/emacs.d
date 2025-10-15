sed 's/\(script_path="\$[(]2>\/dev\/random 1>\/dev\/random cd \$[(]dirname "\)\$[{]this_script_path[}]\("[)] && pwd[)]\)"/\1${BASH_SOURCE[0]}/2/g' -i
