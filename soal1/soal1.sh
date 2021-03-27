#!/bin/bash

#filter dengan Perl, masukkan ke dalam new line, lalu disort dan dihitung yang unique
grep -Po '(?<=ERROR ).*(?= \()' syslog.log | sort | uniq -c | sort -nr > temp.txt

#membuat header pada error_message.csv
echo "Error,Count">error_message.csv

#looping untuk output error_message.csv
while read -r count error
do
echo "$error,$count" >> error_message.csv
done < temp.txt

#membuat header pada user_statistic.csv
echo "Username,INFO,ERROR" > user_statistic.csv

#filter username yang dimulai dengan "(" dan diakhiri dengan ")", lalu disort dan dimasukkan ke file temp username.txt
(grep -Po '(?<=\().*(?=\))' syslog.log | sort --unique) > username.txt

#inisialisasi temp file errorcount.txt dan infocount.txt
echo "init" > errorcount.txt
echo "init" > infocount.txt

#looping untuk mencari count masing-masing "ERROR" dan "INFO" lalu ditambahkan ke file temp yang sudah dibuat
while read -r line
do
#filter kata "ERROR" dan "$line" masing-masing
 (grep -E -o "ERROR.*($line))" syslog.log | wc -l)>>errorcount.txt
#filter kata "INFO" dan "$line" masing-masing
 (grep -E -o "INFO.*($line))" syslog.log | wc -l)>>infocount.txt
done < username.txt

#menghapus baris 1 hasil inisialiasi
sed -i '1d' errorcount.txt
sed -i '1d' infocount.txt

#menggabungkan per baris dengan delimiter ","
(paste -d',' username.txt infocount.txt errorcount.txt)>>user_statistic.csv

#menghapus file-file temporary yang sudah tidak digunakan
rm temp.txt
rm username.txt
rm errorcount.txt
rm infocount.txt
