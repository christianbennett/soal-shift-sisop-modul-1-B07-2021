# soal-shift-sisop-modul-1-B07-2021
## Anggota Kelompok
* Christian Bennett Robin 05111940000078
* Zelda Elma Sibuea 05111940000038
* Hanifa Fauziah 05111940000024
## Soal 1

Pertama melakukan filter menggunakan Perl, lalu dimasukkan ke dalam newline, lalu disort dan dicari yang unik (tidak ada kata duplikat), hasilnya lalu disimpan dalam file sementara `temp.txt`

```
grep -Po '(?<=ERROR ).*(?= \()' syslog.log | sort | uniq -c | sort -nr > temp.txt
```

`grep -Po` digunakan untuk memfilter kata menggunakan perl, lalu hasilnya dimasukkan kedalam newline

`'(?<=ERROR ).*(?= \()'` yaitu untuk mencari kata yang dimulai dengan `ERROR ` dan diakhiri dengan `(`

`sort` untuk melakukan sort

`uniq -c` untuk mencari kata yang unik (menghilangkan duplikat)

`sort -nr` untuk melakukan sort numerik dan reverse (descending sort)

Lalu untuk inisialisasi file `error_message.csv`, dilakukan: 

```
echo "Error,Count">error_message.csv
```

Setelah itu dilakukan looping untuk menambahkan output pada `error_message.csv`

```
while read -r count error
do
echo "$error,$count" >> error_message.csv
done < temp.txt
```

`read -r` untuk membaca input

`count error` sebagai argumen 1 dan argumen 2 yang dibaca dari input

Selanjutnya dilakukan inisialisasi file `user_statistic.csv`:

```
echo "Username,INFO,ERROR" > user_statistic.csv
```

Selanjutnya, memfilter username yang dimulai dengan `(` dan diakhiri dengan `)`, lalu disort dan dimasukkan ke file sementara `username.txt`

```
(grep -Po '(?<=\().*(?=\))' syslog.log | sort --unique) > username.txt
```

`grep -Po` untuk memfilter menggunakan Perl, lalu hasilnya dimasukkan kedalam newline

`'(?<=\().*(?=\))'` yaitu untuk mencari kata yang dimulai dengan `(` dan diakhiri dengan `)`

`sort --unique` untuk mencari kata yang unik (tidak ada duplikat) 

Lalu melakukan inisialisasi file sementara `errorcount.txt` dan `infocount.txt`

```
echo "init" > errorcount.txt
echo "init" > infocount.txt
```

Kemudian, melakukan looping untuk mencari count masing-masing `ERROR` dan `INFO` lalu ditambahkan ke file sementara yang sudah dibuat

```
while read -r line
do
 (grep -E -o "ERROR.*($line))" syslog.log | wc -l)>>errorcount.txt
 (grep -E -o "INFO.*($line))" syslog.log | wc -l)>>infocount.txt
done < username.txt
```

`read -r` untuk membaca input

`line` sebagai argumen yang dibaca

`grep -E -o` untuk melakukan filter dengan grep, `-E` artinya Extended RegEx, yaitu untuk membaca metacharacters, `-o` artinya dimasukkan ke dalam newline

`"ERROR.*($line))"` yaitu untuk memfilter baris yang mempunyai kata `ERROR` dan `$(line)` sesuai input

`"INFO.*($line))"` yaitu untuk memfilter baris yang mempunyai kata `INFO` dan `$(line)` sesuai input

`wc -l` untuk menghitung baris hasil `grep -o` 

Hal selanjutnya yaitu menghapus baris 1 hasil inisialiasi tadi

```
sed -i '1d' errorcount.txt
sed -i '1d' infocount.txt
```
`sed -i` untuk mengedit baris

`'1d'` untuk menghapus baris 1

Kemudian, menggabungkan info per baris dengan delimiter `,` 

```
(paste -d',' username.txt infocount.txt errorcount.txt)>>user_statistic.csv
```
`paste -d','` untuk menempel file per baris dengan pembagi `,`

Terakhir yang dilakukan adalah menghapus file-file sementara yang sudah tidak digunakan

```
rm temp.txt
rm username.txt
rm errorcount.txt
rm infocount.txt
```
## Soal 2

Pertama, melakukan filter menggunakan awk, lalu hasilnya disimpan pada file sementara `temp.txt`

```
LC_ALL=C awk -F '\t' 'NR>1 {
printf("%d\t%.4f\n", $1, ($21/($18-$21))*100);
}' Laporan-TokoShiSop.tsv > temp.txt
```

`LC_ALL=C` untuk lokalisasi bahasa, diperlukan untuk menghitung angka-angka berdesimal (perbedaan penggunaan `,` dan `.` sebagai desimal pada beberapa negara)

`awk -F '\t'` untuk melakukan proses filter, `-F '\t'` artinya menggunakan tab sebagai delimiter atau pemisah

`NR>1` untuk baris lebih dari 1 (baris 1 merupakan header)

Selanjutnya, yang dilakukan adalah melakukan numerical reverse sort dan hanya menampilkan baris pertama

```
(sort -n -r -k2 temp.txt | head -1 )>temp2.txt
```

`sort -n -r -k2` untuk numerical reverse sort (descending sort), dan `-k2` artinya menggunakan key ke-2 sebagai hal yang disort

`head -1` untuk melakukan print baris pertama saja

Selanjutnya print output pada `hasil.txt`

```
LC_ALL=C awk -F '\t' '{
printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.4f%%.\n\n", $1, $2);
}' temp2.txt > hasil.txt
```

Lalu, dilanjuti dengan inisialisasi soal 2b pada `hasil.txt`

```
echo "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:" >> hasil.txt
```

Kemudian, dilakukan pemfilteran customer sesuai dengan permintaan soal dan disimpan pada file sementara `temp.txt`

```
awk -F '\t' '($10 == "Albuquerque") && ($2~/-2017-/) {
printf("%s\n",$7);
}' Laporan-TokoShiSop.tsv > temp.txt
```
`($10 == "Albuquerque")` artinya kolom 10 harus sama dengan "Albuquerque"

`($2~/-2017-/)` artinya kolom 2 harus mengandung "-2017-"

Kemudian hasilnya dilakukan alphabetical sort dan dicari yang unik (tidak duplikat)

```
sort temp.txt | uniq >> hasil.txt
```

Selanjutnya, memfilter masing-masing segment lalu dihitung masing-masing countnya, dan dimasukkan ke dalam variabel
```
countHome=$(grep "Home Office" Laporan-TokoShiSop.tsv | wc -l)
countCons=$(grep "Consumer" Laporan-TokoShiSop.tsv | wc -l)
countCorp=$(grep "Corporate" Laporan-TokoShiSop.tsv | wc -l)
```

Hasilnya dimasukkan ke file sementara `temp.txt`

```
(printf "%d\tHome Office\n" $countHome
printf "%d\tConsumer\n" $countCons
printf "%d\tCorporate\n" $countCorp)>temp.txt
```

Selanjutnya dilakukan sort untuk mencari yang countnya paling sedikit, lalu print baris pertama, hasilnya lalu dimasukkan kedalam file sementara `temp2.txt`

```
(sort -n temp.txt | head -1) > temp2.txt
```

Kemudian output ditambahkan pada `hasil.txt`

```
awk -F  '\t' '{
printf("\nTipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n\n", $2, $1);
}' temp2.txt >> hasil.txt
```

Selanjutnya melakukan inisialisasi ulang temp.txt

```
echo "init" > temp.txt
```

Kemudian, melakukan filtering untuk masing-masing region yang ada dengan awk, lalu menghitung hasil penambahan profitnya, kemudian hasilnya dimasukkan kedalam file sementara `temp.txt`

```
LC_ALL=C awk -F '\t' '($13~/Central/) {
#printf("%f\n ", $21);
s+=$21}
END {printf("%.4f\tCentral\n",s) }' Laporan-TokoShiSop.tsv >>temp.txt 

LC_ALL=C awk -F '\t' '($13~/East/) {
#printf("%f\n ", $21);
s+=$21}
END {printf("%.4f\tEast\n",s) }' Laporan-TokoShiSop.tsv >>temp.txt 

LC_ALL=C awk -F '\t' '($13~/South/) {
#printf("%f\n ", $21);
s+=$21}
END {printf("%.4f\tSouth\n",s) }' Laporan-TokoShiSop.tsv >>temp.txt 

LC_ALL=C awk -F '\t' '($13~/West/) {
#printf("%f\n ", $21);
s+=$21}
END {printf("%.4f\tWest\n",s) }' Laporan-TokoShiSop.tsv >>temp.txt 
```

Selanjutnya menghapus baris pertama hasil init tadi

```
sed -i '1d' temp.txt
```
Kemudian, sort profit untuk mendapatkan profit yang paling kecil, dan hanya menampilkan baris pertama, yaitu baris yang paling kecil profitnya setelah disort

```
(sort -n temp.txt | head -1)>temp2.txt
```
Lalu, melanjutkan print output ke `hasil.txt`

```
LC_ALL=C awk -F '\t' '{
printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.4f\n", $2, $1);
}' temp2.txt >> hasil.txt
```

Terakhir, melakukan remove file temp yang sudah tidak digunakan

```
rm temp.txt
rm temp2.txt
```

## Soal 3
