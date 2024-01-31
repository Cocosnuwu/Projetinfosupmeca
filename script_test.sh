#!/bin/bash

tail -n +2 data.csv | cut -d';' -f1,5,6  > L.txt
gcc -o trid2 trid2.c
./trid2
exit
