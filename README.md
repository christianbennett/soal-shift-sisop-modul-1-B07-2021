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
## Soal 3
