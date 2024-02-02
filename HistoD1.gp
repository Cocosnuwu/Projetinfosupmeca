# Définir le format de sortie en png
set terminal png
set terminal pngcairo enhanced font "arial,12" size 1000,1000

# Définir le nom du fichier de sortie
set output 'HistoD1.png'

# Définir le titre et les étiquettes

set label "Nbr de trajets" at graph 0, graph 0.5 left rotate by 90 offset -4,16


set datafile separator ";"
set xlabel "Noms des conducteurs"
set ylabel "Option -d1 : Classement des 10 conducteurs ayant fait le plus de trajets" offset -1,-2

set style data histogram
set style fill solid
set boxwidth 1.5
set xlabel rotate by 180
set xtics offset 0,-9
set xlabel offset 0,-8
set ytics offset 0,1
set xtics rotate by 90
set ytics rotate by 90
set bmargin at screen 0.2
set lmargin at screen 0.1


set yrange [0:*]




# Tracer les données en utilisant des boîtes
plot 'DD1.txt' using 2:xticlabels(1) notitle


