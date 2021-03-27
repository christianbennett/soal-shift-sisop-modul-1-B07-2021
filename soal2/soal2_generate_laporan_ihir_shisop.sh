#!/bin/bash

#filter menggunakan awk dengan delmiter "\t"
LC_ALL=C awk -F '\t' 'NR>1 {
printf("%d\t%.4f\n", $1, ($21/($18-$21))*100);
}' Laporan-TokoShiSop.tsv > temp.txt

#melakukan numerical reverse sort dan hanya menampilkan baris pertama
(sort -n -r -k2 temp.txt | head -1 )>temp2.txt

#print 2a
LC_ALL=C awk -F '\t' '{
printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.4f%%.\n\n", $1, $2);
}' temp2.txt > hasil.txt

#inisialisasi 2b
echo "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:" >> hasil.txt

#memfilter customer sesuai dengan permintaan soal 2b
awk -F '\t' '($10 == "Albuquerque") && ($2~/-2017-/) {
printf("%s\n",$7);
}' Laporan-TokoShiSop.tsv > temp.txt

#alphabetical sort dan select distinct
sort temp.txt | uniq >> hasil.txt

#filter masing-masing segment lalu dicount
countHome=$(grep "Home Office" Laporan-TokoShiSop.tsv | wc -l)
countCons=$(grep "Consumer" Laporan-TokoShiSop.tsv | wc -l)
countCorp=$(grep "Corporate" Laporan-TokoShiSop.tsv | wc -l)

#masukkan ke file temp 
(printf "%d\tHome Office\n" $countHome
printf "%d\tConsumer\n" $countCons
printf "%d\tCorporate\n" $countCorp)>temp.txt

#sort untuk mencari yang paling sedikit lalu hanya diprint baris pertama
(sort -n temp.txt | head -1) > temp2.txt

#print 2c
awk -F  '\t' '{
printf("\nTipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n\n", $2, $1);
}' temp2.txt >> hasil.txt

#inisialisasi ulang temp.txt
echo "init" > temp.txt

#filtering Central
LC_ALL=C awk -F '\t' '($13~/Central/) {
#printf("%f\n ", $21);
s+=$21}
END {printf("%.4f\tCentral\n",s) }' Laporan-TokoShiSop.tsv >>temp.txt 

#filtering East
LC_ALL=C awk -F '\t' '($13~/East/) {
#printf("%f\n ", $21);
s+=$21}
END {printf("%.4f\tEast\n",s) }' Laporan-TokoShiSop.tsv >>temp.txt 

#filtering South
LC_ALL=C awk -F '\t' '($13~/South/) {
#printf("%f\n ", $21);
s+=$21}
END {printf("%.4f\tSouth\n",s) }' Laporan-TokoShiSop.tsv >>temp.txt 

#filtering West
LC_ALL=C awk -F '\t' '($13~/West/) {
#printf("%f\n ", $21);
s+=$21}
END {printf("%.4f\tWest\n",s) }' Laporan-TokoShiSop.tsv >>temp.txt 

#menghapus baris pertama hasil init
sed -i '1d' temp.txt

#sort profit yang paling kecil
(sort -n temp.txt | head -1)>temp2.txt

#print 2d
LC_ALL=C awk -F '\t' '{
printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.4f\n", $2, $1);
}' temp2.txt >> hasil.txt

#remove file temp yang tidak digunakan
rm temp.txt
rm temp2.txt
