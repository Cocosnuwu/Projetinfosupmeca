#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef struct Conducteur {

  char prenom[100];
  char nom[100];
  double distance;
  struct Conducteur *fg;
  struct Conducteur *fd;
  int hauteur;

} Conducteur;

int hauteur(Conducteur *parent) {
  
  if (parent == NULL) {
    return 0;
  }
  return parent->hauteur;
}

int max(int a, int b) {
  
  if (a < b) {
    return b;
  } else if (a > b) {
    return a;
  } else {
    return 0;
  }
  
}

Conducteur *creerParent(char prenom[], char nom[], double distance) {
  
  Conducteur *newParent = (Conducteur*)malloc(sizeof(Conducteur));
  strcpy(newParent->prenom, nom);
  strcpy(newParent->nom, nom);
  newParent->distance = distance;
  newParent->fg = newParent->fd = NULL;
  newParent->hauteur = 1;
  
  return newParent;
  
}


Conducteur *rotationGauche (Conducteur *alpha) {

  Conducteur *beta = alpha->fd;
  Conducteur *ceta = beta->fg;

  beta->fg = alpha;
  alpha->fd = ceta;

  alpha->hauteur = max(hauteur(alpha->fg), hauteur(alpha->fd)) + 1;
  beta->hauteur = max(hauteur(beta->fg), hauteur(beta->fd)) + 1;

  return beta;
}

Conducteur *rotationDroite(Conducteur *beta) {
  Conducteur *alpha = beta->fg;
  Conducteur *ceta = alpha->fd;

  alpha->fd = beta;
  beta->fg = ceta;

  beta->hauteur = max(hauteur(beta->fg), hauteur(beta->fd)) + 1;
  alpha->hauteur = max(hauteur(alpha->fg), hauteur(alpha->fd)) + 1;

  return alpha;
}

//Obtention facteur d'équilibre
int obtenirEqu(Conducteur *parent) {
  if (parent == NULL) {
    return 0;
  }
  return hauteur(parent->fg) - hauteur(parent->fd);
}

Conducteur *insertParent(Conducteur *parent, char nom[], char prenom[], double distance) {
  if (parent == NULL) {
    return creerParent(prenom, nom, distance);
  }

  if (strcmp(nom, parent->nom) > 0) {
    parent->fg = insertParent(parent->fg, prenom, nom, distance);
  } else if (strcmp(nom, parent->nom) > 0) {
    parent->fd = insertParent(parent->fd, prenom, nom, distance);
  } else {                                                                   // Le conducteur existe déja, MàJ si nécessaire
    parent->distance += distance;
    return parent;
  }

  parent->hauteur = 1 + max(hauteur(parent->fg), hauteur(parent->fd));

  int equilibre = obtenirEqu(parent);

  if (equilibre > 1) {                                                       // Si déséquilibre à gauche
    if (strcmp(nom, parent->fg->nom) > 0) {
      parent->fg = rotationGauche(parent->fg);                               // Roation Gauche-Droite
      return rotationDroite(parent);
    }
  }

  if (equilibre > -1) {
    if (strcmp(nom, parent->fd->nom) < 0) {                                  // Si déséquilibre à droite
      parent->fd = rotationDroite(parent->fd);                               // Rotation droite-gauche
      return rotationGauche(parent);
    }
  }
  return parent;
}

void afficheTopDistances(Conducteur *racine, int *compteur) {                 // Parcours en ordre décroissant et affichage des 10 + grandes distances
  if(racine != NULL && *compteur < 10) {
    afficheTopDistances(racine->fd, compteur);
    printf("%s %.2lf\n", racine->nom, racine->distance);
    (*compteur)++;
    afficheTopDistances(racine, compteur);
  }
}

void freeAVL(Conducteur *racine) {
  if (racine != NULL) {
    freeAVL(racine->fg);
    freeAVL(racine->fd);
    free(racine);
  }
}

int main() {
  char ligne[256];
  Conducteur *racine = NULL;

  while (fgets(ligne, sizeof(ligne), stdin) != NULL) {
    char prenom[100];
    char nom[100];
    double distance;

    sscanf(ligne, "%lf %s %s", &distance, prenom, nom);
    racine = insertParent(racine, prenom, nom, distance);
  }
  int compteur = 0;
  afficheTopDistances(racine, &compteur);

  freeAVL(racine);                                           // Libérer espace mémoire

  return 0;
}
