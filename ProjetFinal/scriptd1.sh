#!/bin/bash

loading="Traitement en cours..."
done="Traitement réussi !"

echo "${loading}"

# Triage
tail -n +2 $(dirname $0)/data/data.csv | cut -d';' -f1,6 | sort -r -d -t';' -k2 > d1.txt
awk '!a[$0]++' d1.txt > D1.txt
awk -F";" '{occ[$2]++} END {for (name in occ) print name ";" occ[name] }' D1.txt > DD.txt
sort -r -n -t';' -k2 DD.txt | head -10 > DD1.txt


# Traçage de l'histogramme d1
gnuplot -persist HistoD1.gp
convert -rotate 90 HistoD1.png HistoD1.png

mv HistoD1.png images

# Envoi des fichiers temporaires dans leur dossier réservé
mv d1.txt temp
mv D1.txt temp
mv DD.txt temp
mv DD1.txt temp

# Ouverture de l'histogramme d1
xdg-open images/HistoD1.png

# Suppression du contenu du dossier temporaire
rm -r temp/*

echo "${done}"
exit
