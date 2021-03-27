#!/bin/bash

./soal3a.sh

tanggal=$(date +"%d-%m-%Y")
mkdir $tanggal

mv ./Koleksi_* ./$tanggal
mv Foto.log ./$tanggal

