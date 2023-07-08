mysql --login-path=root --silent --skip-column-names reiki_ru -e 'SET SESSION group_concat_max_len = 10000000; select group_concat(distinct page_title order by page_title separator "\n") as nouns from synthes_wikidata_txt where page_namespace=0 and page_title not regexp "[^а-яА-ЯЁё]" and txt regexp "\\{\\{сущ.ru[^-]" and txt not regexp "\\{\\{топоним"  and txt not regexp "\\{\\{собств";' > ru_nouns_230703.badnl.lst.txt
exit 0;
# command below produces bad newlines (literally backslash-n \n instead of real \n) so we'll fix it using small PHP script:
<?php
$s=file_get_contents("ru_nouns_230703_badnl.lst.txt");
$ns = str_replace ('\n', "\n", $s);
// print (substr($ns, 0, 1000)); // uncomment to test result
file_put_contents ("ru_nouns_230703.lst.txt", $ns);
?>