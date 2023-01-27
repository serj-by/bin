#! /usr/bin/env bash
. ~/.mydb_local_conf
USAGE="
Usage:\n\
$0 [--help|--countpages|--lastpageid|--lastpagetitle|--dumpviews|<free form query>] [--silent|--nosilent] [<dbname>]\n\
"
silent=false
opts=""
if [[ $2 == "--silent" ]]; then
silent=true
opts="-r -s -N"
elif [[ $2 == "--nosilent" ]]; then
silent=false
opts=""
elif [[ $2 == "--silentbutinfo" ]]; then
silent=false
opts="-r -s -N"
fi
#echo "silopts $silent $opts"
dbname=$default_dbname
if [ -n "$3" ]; then
if [[ ! $silent ]]; then echo "DB param is not empty - $3 . Using as DB name"; fi
dbname=$3
else
if [[ ! $silent ]]; then echo "No DB param. Using $dbname as default."; fi
fi
if [[ ! $silent ]]; then echo "DB: $dbname"; fi
q=$1
if [[ ! $silent ]]; then echo "Q: $q"; fi
case "$q" in
"--countpages")
    q="select format(count(*),0) as count_pages from wiki_page;"
    if [[ ! $silent ]]; then echo "Count pages"; fi
;;
"--lastpageid")
    q="select format(max(page_id),0) as max_page_id from wiki_page;"
    if [[ ! $silent ]]; then echo "Max page id"; fi
;;
"--lastpagetitle")
    q="select page_id as max_page_id , convert(page_title using utf8) as max_page_title_text from wiki_page where page_id=(select max(page_id) from wiki_page);"
    if [[ ! $silent ]]; then echo "Last page title"; fi 
;;
"--langparts")
#    q='select sum(IF(old_text like "%{{сущ ru%", 1, 0)) as "nouns",sum(IF(old_text like "%{{сущ ru%", 1, 0)) as "verbs",sum(IF(old_text like "%{{прил ru%", 1, 0)) as "adjectives",sum(IF(old_text like "%{{числ ru%", 1, 0)) as "numerals",sum(IF(old_text like "%{{буква%", 1, 0)) as "letters",sum(IF(old_text like "%{{part ru%" and old_text not like "%{{предик.|ru%", 1, 0)) as "particles",sum(IF(old_text like "%{{предик.|ru%" or old_text like "%|или=предикатив%", 1, 0)) as "predicatives",sum(IF(old_text like "%{{adv ru%", 1, 0)) as "adverbs",count(*) as "TOTAL"from wiki_text;';
    q='select sum(IF(old_text like "%{{сущ ru%", 1, 0)) as "nouns",sum(IF(old_text like "%{{сущ ru%", 1, 0)) as "verbs",sum(IF(old_text like "%{{прил ru%", 1, 0)) as "adjs",sum(IF(old_text like "%{{числ ru%", 1, 0)) as "nums",sum(IF(old_text like "%{{буква%", 1, 0)) as "ltrs",sum(IF(old_text like "%{{part ru%" and old_text not like "%{{предик.|ru%", 1, 0)) as "parts",sum(IF(old_text like "%{{предик.|ru%" or old_text like "%|или=предикатив%", 1, 0)) as "preds",sum(IF(old_text like "%{{adv ru%", 1, 0)) as "adverbs",count(*) as "TTL" from wiki_text';
    if [[ ! $silent ]]; then echo "Lang part stats"; fi
;;
"--dumpviews")
    q='SET SESSION group_concat_max_len = 100000; SELECT group_concat(distinct concat(concat("-- Begin dump of ", TABLE_NAME, "\nCREATE OR REPLACE VIEW `", TABLE_NAME, "` AS\n", VIEW_DEFINITION), ";\n-- End dump of ", table_name, "\n") order by TABLE_NAME separator "\n") FROM information_schema.VIEWS where table_schema="reiki_ru";'
    if [[ ! $silent ]]; then echo "Dump views"; fi
;;

"--help")
    echo -e $USAGE
    exit 0;
;;
*)
    if [[ ! $silent ]]; then echo "Passed free form query $q"; fi
;;
esac

mysql --login-path=$dbloginpath $opts $dbname -e "$q"