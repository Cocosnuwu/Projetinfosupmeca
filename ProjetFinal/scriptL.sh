#!/bin/bash

loading="Traitement en cours..."
done="Traitement réussi !"

# Assurez-vous que le fichier exécutable "trieL" est exécutable
chmod +x $(dirname $0)/progc/trieL
tail -n +2 $(dirname $0)/data/data.csv | cut -d';' -f1,5,6 > L.txt
# Exécuter le fichier exécutable "trieL"
$(dirname $0)/progc/trieL

mv  L.txt temp

# tri du premier fichier temporaire temp, dans l'ordre décroissant vers temp1
sort -r -n -k1,1 temp.txt > temp1.txt

# traçage de l'histogramme L 
gnuplot -persist HistoL.gp

echo "${done}"

# Déplacement des fichiers temporaires vers le dossier temp
mv tri_L temp
mv temp.txt temp
mv temp1.txt temp

mv Histo_L.png images

# Ouverture du fichier image
xdg-open images/Histo_L.png

# Nettoyage du dossier temporaire
rm -r temp/*

echo "${done}"

# Déplacement des fichiers temporaires vers le dossier temp
mv $(dirname $0)/resultL.txt $(dirname $0)/temp
mv $(dirname $0)/temp1.txt $(dirname $0)/temp
mv $(dirname $0)/temp.txt $(dirname $0)/temp
mv $(dirname $0)/temp1.txt $(dirname $0)/temp

# Déplacement de l'histogramme vers le dossier images
mv $(dirname $0)/Histo_L.png $(dirname $0)/images

# Ouverture du fichier image
xdg-open $(dirname $0)/images/Histo_L.png

exit

