#!/bin/bash

tanggal=$(date +"%d-%m-%Y")
passtgl=$(date +"%m%d%Y")

zip -r -P $passtgl Koleksi.zip "$tanggal"
