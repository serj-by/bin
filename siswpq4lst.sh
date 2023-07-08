#q="$1"
#origin one
#q='SET SESSION group_concat_max_len = 10000000; select group_concat(distinct page_title order by page_title separator '\n') as nouns from synthes_wikidata_txt where page_namespace=0 and page_title not regexp "[^а-яА-ЯЁё]" and txt regexp "\\{\\{сущ.ru[^-]" and txt not regexp "\\{\\{топоним"  and txt not regexp "\\{\\{собств";'
# implicit ruold exclusion
q='SET SESSION group_concat_max_len = 10000000; select group_concat(distinct page_title order by page_title separator "\n") as nouns from synthes_wikidata_txt where page_namespace=0 and page_title not regexp "[^а-яА-ЯЁё]" and txt regexp "\\{\\{сущ.ru[^-]" and txt not regexp "\\{\\{топоним"  and txt not regexp "\\{\\{собств";'
#echo "Query: $q";
cmd="mysql --login-path=root --silent --skip-column-names reiki_ru -e '$q'"
echo "Lainch cmd: $cmd"
#bash -c  "$cmd"
