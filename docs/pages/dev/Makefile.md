---
title: A propos du makefile 
layout: default
parent: Développement
---

Le makefile expose les commandes suivantes : 

| Nom               | Fonction                                                             |
|-------------------|----------------------------------------------------------------------|
| **make check**    | *Vérifier la syntaxe nix sans compiler*                              |
| **make build**    | *Vérifier la syntaxe nix et compiler le projet*                      |
| **make build-vm** | *Construire le projet et exécuter une VM du résultat*                |
| **make update**   | *Mettre à jour le flocon vers la dernière mise à jour disponible*    |
| **make clean**    | *Nettoyer le dépôt*                                                  |
| **make iso**      | *Construire l'image iso*                                             |
| **make install**  | *Copier l'image iso dans un répertoire `iso` et générer un checksum* |

{: .note }
> Dans la majorité des cas, vous aurez besoin de `make check` ou `make build` et `make all`.
