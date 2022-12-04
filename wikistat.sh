. ~/.mydb_local_conf
dbname=$default_dbname

silent=false
if [[ $2 == "--silent" ]]; then
silent=true
fi

#echo -n "silent: "
#echo "$silent"

if [ -n $1 ]; then
if [[ ! $silent ]]; then echo "First param is not empty - $1 . Using as DB name"; fi
dbname=$1
else
if [[ ! $silent ]]; then echo "No first param. Using $dbname as default."; fi
fi
if [[ ! $silent ]]; then echo "DB: $dbname"; fi
#mysql -u$dbuser -p$dbpass $dbname -e "select count(*) as count_pages from wiki_page;" 2>/dev/null
#mysql -u$dbuser -p$dbpass $dbname -e "select max(page_id) as max_page_id from wiki_page;" 2>/dev/null
#mysql -u$dbuser -p$dbpass $dbname -e "select page_id as ma_page_id , convert(page_title using utf8) as max_page_title_text from wiki_page where page_id=(select max(page_id) from wiki_page);" 2>/dev/null
myq.sh --countpages --nosilent $dbname
myq.sh --lastpageid --nosilent $dbname
myq.sh --lastpagetitle --nosilent $dbname
myq.sh --langparts --nosilent $dbname
