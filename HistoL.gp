set terminal png
set terminal pngcairo enhanced font "arial,12" size 1000,1000

set output 'Histo_L.png'

set datafile separator ";"
set title  "Option -l : Les 10 trajets les plus longs"
set xlabel "Route ID"
set ylabel "Distance (Km)


set style data histogram
set style fill solid
set boxwidth 1.5
set yrange [0:*]

plot 'temp1.txt' using 2:xticlabels(1) notitle
