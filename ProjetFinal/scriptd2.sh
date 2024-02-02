#!/bin/bash

loading="Traitement en cours..."
done="Traitement réussi !"

chmod +x $(dirname $0)/progc/tried2
tail -n +2 $(dirname $0)/data/data.csv | cut -d';' -f1,5,6  > d2.txt

# Exécuter le fichier exécutable "tried2"
$(dirname $0)/progc/tried2
# Déplacer le fichier "L.txt" vers le dossier temp
mv $(dirname $0)/d2.txt $(dirname $0)/temp



gnuplot -persist HistoD2.gp
mv d2.png images
cd images
convert -rotate 90 d2.png d2.png
xdg-open d2.png
cd .

exit

