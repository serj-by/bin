#! /usr/bin/env bash
. ~/.mydb_local_conf
USAGE="
Usage:\n\
$0 [--help|--countpages|--lastpageid|--lastpagetitle|--countwords|--lastwordid|--lastwordtitle|--dumpviews|<free form query>] [--silent|--nosilent] [<dbname>]\n\
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
# [ @section synthes-importxmldump-stats ]
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
# [ @/section syntthes-importxmldump-stats ]

# [ @section synthes-dumps ]
"--dumpviews")
q="SET SESSION group_concat_max_len = 100000; SELECT replace(group_concat(distinct concat(concat('-- Begin dump of ', TABLE_NAME, CHAR(10), 'CREATE OR REPLACE VIEW \`', TABLE_NAME, '\` AS', CHAR(10), VIEW_DEFINITION), ';', CHAR(10),'-- End dump of ', table_name, CHAR(10)) order by TABLE_NAME separator '\\n'), '\`$dbname\`.', '') FROM information_schema.VIEWS where table_schema='$dbname';"
    if [[ ! $silent ]]; then echo "Dump views"; fi
;;
# [ @/section synthes-dumps ]

# [ @section synthes-word-stats ]
"--countwords")
    q="select format(count(*),0) as count_words from synthes_word;"
    if [[ ! $silent ]]; then echo "Count pages"; fi
;;
"--lastwordid")
    q="select format(max(word_id),0) as max_word_id from synthes_word;"
    if [[ ! $silent ]]; then echo "Max page id"; fi
;;
"--lastwordtitle")
    q="select word_id as max_word_id , convert(word using utf8) as max_word_title_text from synthes_word where word_id=(select max(word_id) from synthes_word);"
    if [[ ! $silent ]]; then echo "Last page title"; fi 
;;
# [ @/section synthes-word-stats ]


# [ @section synthes-myq-misc ]
"--help")
    echo -e $USAGE
    exit 0;
;;
*)
    if [[ ! $silent ]]; then echo "Passed free form query $q"; exit 0; fi
;;
# [ @/section synthes-myq-misc ]
esac

exec mysql --login-path=$dbloginpath $opts $dbname -e "$q"