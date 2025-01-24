---
title: Installer un paquet provenant de Nix
layout: default
parent: Documentation
---

# Comment installer des paquets nix sans flatpak 

Nous vous conseillons de lire la page [configuration personnalisée](/pages/documentation/customconfiguration.html) et nous vous rappelons que cet usage est strictement réservé à ceux qui savent ce qu'ils font.
GLFOS ne supporte pas les modifications de configurations réalisées par vos propre soins.

Cette étape n'est qu'à faire une seule fois. 

- Créez un nouveau fichier:

```bash
sudo touch /etc/nixos/packages.nix
```

Ouvez-le avec `sudo nano /etc/nixos/packages.nix` et ajoutez : 

```nix
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  # Ajoutez ici vos logiciels 
  ];
}
```

Enregistrez le fichier avec `CTRL+O`, `ENTER` puis `CTRL+X`, `ENTER`.

Ouvrez maintenant `configuration.nix` avec : 

```bash
sudo nano /etc/nixos/configuration.nix
```

Dans la section `imports`, ajoutez à la suite de `./hardware-configuration.nix` : 

```nix
imports = [
  ./hardware-configuration.nix
  ./glf
  ./packages.nix
];
```

Enfin, appliquez la configuration avec : 

```bash
glf-switch
```















