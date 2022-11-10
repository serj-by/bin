#! /usr/bin/env bash
. ~/.mydb_local_conf
USAGE="
Usage:\n\
$0 [-countpages|-maxpageid|-lastpagetitlt|<free form query>] [--silent] [<dbname>]
"
silent=false
opts=""
if [[ $2 == "--silent" ]]; then
silent=true
opts="-s -N"
fi
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
"-countpages")
    q="select count(*) as count_pages from wiki_page;"
    if [[ ! $silent ]]; then echo "Count pages"; fi
;;
"-maxpageid")
    q="select max(page_id) as max_page_id from wiki_page;"
    if [[ ! $silent ]]; then echo "Max page id"; fi
;;
"-laspagetitle")
    q="select page_id as ma_page_id , convert(page_title using utf8) as max_page_title_text from wiki_page where page_id=(select max(page_id) from wiki_page);"
    if [[ ! $silent ]]; then echo "Last page title"; fi 
;;
"--help")
    echo -e $USAGE
    exit 0;
;;
*)
    if [[ ! $silent ]]; then echo "Passed free form query $q"; fi
;;
esac

mysql $opts --login-path=$dbloginpath $dbname -e "$q"