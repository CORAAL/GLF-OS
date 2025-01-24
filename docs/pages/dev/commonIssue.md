---
title: Problèmes courant
layout: default
parent: Développement
---

Cette page vise à référencer des problèmes rencontrés durant le développement. 
Il s'agit de notes diversent qui pourraient aider à l'avenir. 

# 2025-01-06

## Problème 

Durant le développement, après la construction d'une image ISO, l'assistant Calamares n'affichait plus les modifications GLF. 
Les modifications liés à GNOME étaient toujours présentes.

## Procédure de debug

### Calamares-nixos-extensions 

La première étape était de vérifier si le paquet `calamares-nixos-extensions` avait modifié des chemins vers des fichiers.
Pour rappel, nous appliquons un `patch` au fichier `main.py` contenant nos modifications qui écrase le fichier original du paquet officiel. 

Après vérifications, aucune modifications majeur n'avait eu lieu. 
Les chemins du paquet compilé dans `/nix/store` n'avait là non plus, pas changé.

### Tests d'anciennes versions du projet GLF-OS 

Nous avons tenté de reconstruire d'anciennes images iso, même là, les modifications de calamares étaient perdus, ce qui n'était pas normal.
Une chose que nous avions observé, c'est qu'en remontant assez haut dans le développement du projet à la période où nous avions un répertoire `nix-cfg`, les modifications de calamares revenaient. 
La modification majeur entre la période où ça fonctionnait et où ça ne fonctionnait plus corresponds au déplacement des anciens modules `glf` aux nouveaux.
On note que le flocon avait été édité pour correspondre aux nouveaux changements.

D'une manière ou d'une autre, la modification du flocon semblait jouer un rôle. 

### Passage de stable à unstable 

De nombreux essaies plus tard, nous avons supposé que le problème pourrait venir d'un bug propre à `calamares`.
Nous avons construit une nouvelle image ISO pointant cette fois sur `nixos-unstable` (`25.05`), cette fois un message d'erreur indiquait un problème avec notre flocon.

```
evaluation warning: You have set specialArgs.pkgs, which means that options like nixpkgs.config
                    and nixpkgs.overlays will be ignored. If you wish to reuse an already created
                    pkgs, which you know is configured correctly for this NixOS configuration,
                    please import the `nixosModules.pkgsReadOnly` module from the nixpkgs flake or
                    `(modulesPath + "/misc/nixpkgs/read-only.nix"), and set `{ nixpkgs.pkgs = <your pkgs>; }`.
                    This properly disables the ignored options to prevent future surprises.
```

### Le rôle de nix 

Comme l'erreur ci-dessus le mentionne, nous faisons passer des valeurs pour `nixpkgs.config` et `nixpkgs.overlays` en plus de faire hériter de valeur dans `specialArgs`. 
Formulé autrement, nous configurons plusieurs même élément dans deux endroits différents. 

Si auparavant nix n'avait pas de problème avec ça, aujourd'hui il décide d'ignorer l'une des deux, ici, il a choisi d'ignorer l'overlay calamares.

### La solution

Le système sur lequel GLF-OS est développé est un système NixOS.
Celui-ci avait été mis à jour quelques jours avant les tests, Nix était passé de la version `2.24.10` à `2.24.11`.

L'organisation du flocon avec cette nouvelle version faisait que des options étaient ignorés sans fournir de message d'erreur.
Le passage à `nixos-unstable` pour le GLF-OS permettait d'afficher des erreurs qui n'apparaissent pas avec `nixos-24.11`.

Après modification du flocon, le problème a été corrigé, les modifications de calamares pour GLF-OS revenus. 

{: .warning }
> Faites attentions aux montées de version de Nix. 
