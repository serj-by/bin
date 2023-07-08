#/usr//bin/env bash
# nouns 1gb lim
mysql --login-path=wiki --database='reiki_ru' --silent --raw --skip-column-names --execute 'SET SESSION group_concat_max_len = 10000000; select group_concat(distinct page_title order by page_title separator "\n") as nouns from synthes_wikidata_txt where page_namespace=0 and page_title not regexp "[^[:Cyrillic:]]+" and txt regexp "\\{\\{сущ.ru";' > ru_nouns_1glim.lst.txt
echo "$0 finished... on `sbdate dashed` @ `sbtime short`"
