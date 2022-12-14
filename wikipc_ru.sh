LC_NUMERIC="en_US.UTF-8"
printf "%'d\n" `grep -o "{{-ru-}}" $1 | wc -l`
LC_NUMERIC="C"
