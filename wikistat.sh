#dbname="wikti_ru"
#dbuser="root"
#dbpass="rootmysql"
. ~/.my_local_conf
if [ ! -z $1 ]; then
echo "First param is not empty - $1 . Using as DB name"
dbname=$1
fi
mysql -u$dbuser -p$dbpass $dbname -e "select count(*) as count_pages from wiki_page;" 2>/dev/null
mysql -u$dbuser -p$dbpass $dbname -e "select max(page_id) as max_page_id from wiki_page;" 2>/dev/null
mysql -u$dbuser -p$dbpass $dbname -e "select page_id as ma_page_id , convert(page_title using utf8) as max_page_title_text from wiki_page where page_id=(select max(page_id) from wiki_page);" 2>/dev/null
