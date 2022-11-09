q=$1
mysql -s -N -uroot -prootmysql wikti_ru -e "$q" 2>/dev/null