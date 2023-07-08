q="$1"
#echo "Query: $q";
cmd="mysql --login-path=root --silent --skip-column-names reiki_ru -e $q"
echo "Lainch cmd: $cmd"
#bash -c  "$cmd"
