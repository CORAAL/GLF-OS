---
title: À propos des mises à jours 
layout: default 
parent: Documentation
---

# A quelle fréquence apparaissent les mises à jours ?

Il y a deux types de mises à jours dans glf-os : 

## Mise à jours des paquets 

Les mises à jours de vos paquets suivent celle du projet NixOS et sont effectués une fois par semaine en tâche de fond. 

## Mise à jour du module GLF 

GLF-OS propose dans vos configurations `/etc/nixos` un module GLF (`/etc/nixos/glf`) contenant des options pré-configuré. 

Après l'installation, tous les trois jours, vous recevez une mise à jour des options.

{: .warning }
> Les mises à jours du module sont en cours de modifications et utiliseront les flocons. 

## Comment mettre à jour manuellement ? 

Actuellement, aucun outil graphique n'est disponible, il est donc nécessaire d'ouvrir l'application `console`. 

### Mettre à jour manuellement le module GLF 

```bash
sudo bash /etc/update-glf-config.sh
```

### Mettre à jour manuellement les paquets

```bash
sudo nixos-rebuild switch --upgrade
```

# Post-flake : 

Le flocon fournis à l'utilisateur gère en un seul point le suivis des paquets nix (nixpkgs) et le suivis du module GLF. 
Le flocon cherche la dernière version disponible des paquets nix et le module GLF puis référence les informations de versions dans un fichier `flake.lock`.

Ce qui implique que tant que le fichier n'est pas mis à jour, nixos-rebuild reconstruira en pointant sur la même version. 

## Mettre à jour le flocon 

{: .info }
> Les manipulations suivantes nécessite une élévation de privilèges et sont à effectués avec sudo. 

```bash
glf-update 
```

Si vous voyez une ligne comme `Updated input "nixpkgs"` ou `Updated input "glf"`, ça signifie qu'un input pointe sur une nouvelle version plus récente alors la prochaine reconstruction effectuera une mise à jour.

## Mettre à jour le système

Maintenant que le flocon pointe sur la dernière version en date disponible, vous pouvez effectuer : 

```bash
glf-switch
```


