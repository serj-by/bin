. cdstdbbak
tm=`sbtime short_`
fn="st_data_$tm.sql"
opts=""
if [ "$1" != "--ext" ]; then
echo "Separate inserts dump";
opts="--skip-extended-insert"
else
echo "Extended inserts dump";
fi
echo "Exporting SynThes relate tables to `pwd`/$fn"
mysqldump --login-path=wiki $opts reiki_ru synthes_word synthes_rel_word synthes_extra_word > $fn