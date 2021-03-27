#!/bin/bash

tanggal=$(date +"%d-%m-%Y")
kmrn=$(date --date="yesterday" +"%d-%m-%Y")

#kalau baru mulai
#kalau kemaren cetak kucing
if [[ -d "/home/hanifa/Desktop/praktikum1/soal3/Kucing_$kmrn" || ! -d "/home/hanifa/Desktop/praktikum1/soal3/Kucing_$kmrn" && ! -d "/home/hanifa/Desktop/praktikum1/soal3/Kelinci_$kmrn" ]]
then
    mkdir "Kelinci_$tanggal"
    cd Kelinci_$tanggal
    for (( i=1; i<=23; i++))
    do
      wget -O "Koleksi_$i.jpeg" -a Foto.log https://loremflickr.com/320/240/bunny 
    done
    for (( a=1; a<=23; a++ ))
    do
       for(( b=a+1; b<=23; b++ ))
       do
          cmp -s "Koleksi_$a.jpeg" "Koleksi_$b.jpeg"
          if [ $? == 0 ]
          then
               rm "Koleksi_$b.jpeg"
          fi 
       done
    done

    num=1
    for f in *.jpeg
    do
        if((num<10))
        then
             mv -- "$f" "Koleksi_0$num"
             num=$((num+1))
        else
             mv -- "$f" "Koleksi_$num"
             num=$((num+1))
        fi

    done
    cd ..
fi

#kalau kemaren cetak kelinci
if [ -d "/home/hanifa/Desktop/praktikum1/soal3/Kelinci_$kmrn" ]
then 
    mkdir "Kucing_$tanggal"
    cd Kucing_$tanggal
    for (( i=1; i<=23; i++))
    do
      wget -O "Koleksi_$i.jpeg" -a Foto.log https://loremflickr.com/320/240/kitten 
    done
    for (( a=1; a<=23; a++ ))
    do
       for(( b=a+1; b<=23; b++ ))
       do
          cmp -s "Koleksi_$a.jpeg" "Koleksi_$b.jpeg"
          if [ $? == 0 ]
          then
               rm "Koleksi_$b.jpeg"
          fi 
       done
    done

    num=1
    for f in *.jpeg
    do
        if((num<10))
        then
             mv -- "$f" "Koleksi_0$num"
             num=$((num+1))
        else
             mv -- "$f" "Koleksi_$num"
             num=$((num+1))
        fi

    done
    cd ..
fi



