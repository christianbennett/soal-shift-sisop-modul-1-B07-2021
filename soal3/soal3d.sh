#!/bin/bash

tanggal=$(date +"%d-%m-%Y")
passtgl=$(date +"%m%d%Y")

zip -r -P $passtgl Koleksi.zip Kelinci_* Kucing_* 
rm -r Kelinci_* Kucing_*
