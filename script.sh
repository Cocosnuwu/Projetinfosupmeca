#!/bin/bash

# verifier le nombre d'arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 data.csv [-d1 | -d2 | -l | -t | -s]"
    exit 1
fi

# verifier le premier argument
if [ ! -f $1 ]; then
    echo "Le fichier $1 n'existe pas ou n'est pas accessible en lecture"
    exit 2
fi

# verifier les autres arguments
for arg in ${@:2}; do
    case $arg in
        -h)
            # afficher le message d'aide
            echo "Ce script permet d'analyser et de visualiser des donnees de transport routier"
            echo "Les options de traitement sont les suivantes :"
            echo "-d1 : afficher les 10 conducteurs ayant fait le plus grand nombre de trajets"
            echo "-d2 : afficher les 10 conducteurs ayant parcouru la plus grande distance"
            echo "-l : afficher les 10 trajets les plus longs"
            echo "-t : afficher les 10 villes les plus traversees"
            echo "-s : statistiques sur les etapes"
            exit 0
            ;;
        -d1 | -d2 | -l | -t | -s)
            # option de traitement valide, ne rien faire
            ;;
        *)
            # option de traitement invalide, afficher un message d'erreur
            echo "Option de traitement inconnue : $arg"
            exit 3
            ;;
    esac
done

# si on arrive ici, les arguments sont valides
# continuer le script avec les appels au programme C et à GnuPlot
