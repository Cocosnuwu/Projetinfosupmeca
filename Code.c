#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Arbre {
    char nom[50];
    int somme;
    struct Arbre* fg;
    struct Arbre* fd;
} Arbre;

typedef Arbre* pArbre;

// Fonction pour créer un nouvel élément dans l'arbre
pArbre creerArbre(char nom[50], int valeur) {
    pArbre newarbre = (pArbre)malloc(sizeof(Arbre));
    if (newarbre != NULL) {
        strcpy(newarbre->nom, nom);
        newarbre->somme = valeur;
        newarbre->fg = NULL;
        newarbre->fd = NULL;
    }
    return newarbre;
}

// Fonction pour insérer un élément dans l'arbre
pArbre insertab2(pArbre a, char nom[50], int valeur) {
    if (a == NULL) {
        return creerArbre(nom, valeur);
    }

    int comparaison = strcmp(nom, a->nom);

    if (comparaison < 0) {
        a->fg = insertab2(a->fg, nom, valeur);
    } else if (comparaison > 0) {
        a->fd = insertab2(a->fd, nom, valeur);
    } else {
        // Même nom, additionner la valeur
        a->somme += valeur;
    }

    return a;
}
pArbre traitement() {
    FILE* fichier = fopen("d2.txt", "r");

    if (fichier == NULL) {
        fprintf(stderr, "Erreur : Impossible d'ouvrir le fichier.\n");
        exit(1);
    }

    pArbre arbre = NULL;
    char ligne[100];

    while (fgets(ligne, sizeof(ligne), fichier) != NULL) {
        char nom[50];
        int valeur;
        if (sscanf(ligne, "%*d;%49[^;];%d", nom, &valeur) == 2) {
            printf("Ligne lue : %s, Valeur lue : %d\n", nom, valeur);
            arbre = insertab2(arbre, nom, valeur);
        } else {
            fprintf(stderr, "Erreur de lecture de la ligne : %s", ligne);
        }
    }

    fclose(fichier);
    return arbre;
}


int traiter(Arbre* a, int compteur) {
    FILE* fichier = fopen("d1.txt", "w"); // Ouvrir le fichier en mode "w" pour effacer le contenu existant

    if (fichier != NULL) {
        // Écrire les noms des 10 premiers éléments dans le fichier
        pArbre current = a;
        int i = 0;
        while (current != NULL && i < 10) {
            fprintf(fichier, "%s\n", current->nom);
            current = current->fd; // Vous pouvez également utiliser a->fg pour les 10 premiers éléments à gauche
            i++;
        }

        fclose(fichier);
        compteur++;
    }

    return compteur;
}


void parcoursPrefixeinv(pArbre a, int compteur) {
    if (a != NULL) {
        parcoursPrefixeinv(a->fd, compteur);
        parcoursPrefixeinv(a->fg, compteur);
        compteur = traiter(a, compteur);
    }
    if(a==NULL){
        printf("erreur");
    }
}
int main() {
    pArbre arbre = NULL;
    int compteur=0;
    FILE *fichier; 
    arbre=traitement();
    parcoursPrefixeinv(arbre,compteur);
    
    
    return 0;
}

