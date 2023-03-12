. cdstdbbak
tm=`sbtime short_`
mkdir -p $tm
cd $tm
echo "Exporting SynThes relate tables to `pwd`"
mysqldump --login-path=wiki reiki_ru synthes_word synthes_rel_word synthes_extra_word > st_data_`sbtime short_`.sql