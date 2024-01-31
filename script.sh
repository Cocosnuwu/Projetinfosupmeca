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


# Chemins des dossiers
data_folder="data"
progc_folder="progc"
temp_folder="temp"
images_folder="images"
demo_folder="demo"

# Création des dossiers s'ils n'existent pas
mkdir -p $data_folder
mkdir -p $progc_folder
mkdir -p $temp_folder
mkdir -p $images_folder
mkdir -p $demo_folder

# Copie du fichier CSV dans le dossier 'data'
cp $1 $data_folder/

# Vérification de l'exécutable C
if [ ! -f $progc_folder/code_c ]; then
    echo "Compilation du programme C en cours..."
    (cd $progc_folder && make)
    if [ $? -ne 0 ]; then
        echo "Erreur lors de la compilation du programme C."
        exit 4
    fi
fi

# Fonction pour créer le graphique avec GnuPlot
function create_graph() {
    gnuplot -e "input='$1'" -e "output='$2'" gnuplot_script.gp
    echo "Le graphique a été créé et sauvegardé dans le dossier images."
}

# Traitements en fonction des options
for arg in ${@:2}; do
    case $arg in
        -d1)
            start_time=$(date +%s)
            $progc_folder/code_c -d1 $data_folder/data.csv > $temp_folder/resultat_d1.txt
            end_time=$(date +%s)
            execution_time=$((end_time - start_time))
            echo "Temps de traitement [D1] : $execution_time secondes"
            create_graph "$temp_folder/resultat_d1.txt" "$images_folder/graphique_d1.png"
            ;;
        -d2)
            start_time=$(date +%s)
            $progc_folder/code_c -d2 $data_folder/data.csv > $temp_folder/resultat_d2.txt
            end_time=$(date +%s)
            execution_time=$((end_time - start_time))
            echo "Temps de traitement [D2] : $execution_time secondes"
            create_graph "$temp_folder/resultat_d2.txt" "$images_folder/graphique_d2.png"
            ;;
        -l)
            start_time=$(date +%s)
            $progc_folder/code_c -l $data_folder/data.csv > $temp_folder/resultat_l.txt
            end_time=$(date +%s)
            execution_time=$((end_time - start_time))
            echo "Temps de traitement [L] : $execution_time secondes"
            create_graph "$temp_folder/resultat_l.txt" "$images_folder/graphique_l.png"
            ;;
        -t)
            start_time=$(date +%s)
            $progc_folder/code_c -t $data_folder/data.csv > $temp_folder/resultat_t.txt
            end_time=$(date +%s)
            execution_time=$((end_time - start_time))
            echo "Temps de traitement [T] : $execution_time secondes"
            create_graph "$temp_folder/resultat_t.txt" "$images_folder/graphique_t.png"
            ;;
        -s)
            start_time=$(date +%s)
            $progc_folder/code_c -s $data_folder/data.csv > $temp_folder/resultat_s.txt
            end_time=$(date +%s)
            execution_time=$((end_time - start_time))
            echo "Temps de traitement [S] : $execution_time secondes"
            create_graph "$temp_folder/resultat_s.txt" "$images_folder/graphique_s.png"
            ;;
        *)
            # option de traitement invalide, afficher un message d'erreur
            echo "Option de traitement inconnue : $arg"
            exit 5
            ;;
    esac
done

# Nettoyage du dossier temp après les traitements
rm -rf $temp_folder/*
