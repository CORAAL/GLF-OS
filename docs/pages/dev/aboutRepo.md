---
title: A propos du dépôt 
layout: default
parent: Développement
---

{: .in-progress }
> Cette page se base sur le PR #100 qui n'est pas encore fusionné dans dev. 

{: .todo }
> - Pour éviter les pavés, proposer un screen/balise de code avec une coloration, mise en évidence du rôle de chaque lignes.

Le dépôt est structuré des éléments principaux suivant : 

```bash
.
├── flake.nix
├── flake.lock
├── Makefile
├── patches/
│   └── calamares-nixos-extensions/
│       ├── branding/
│       │   └── nixos/
│       │       └── ...
│       ├── config/
│       │   └── ...
│       └── modules/
│           └── nixos/
│               └── main.py
├── iso/
│   ├── flake.nix
│   ├── flake.lock
│   ├── configuration.nix
│   └── hardware-configuration.nix
├── modules/
│   └── default/
│       └── ...
└── assets/
    └── wallpaper/
        └── ...
```

| Nom            | Fonction                                                                                                                |
|----------------|-------------------------------------------------------------------------------------------------------------------------|
| **flake.nix**  | Décrit comment générer une image iso.                                                                                   |
| **flake.lock** | Verrou de version de nixpkgs.                                                                                           |
| **Makefile**   | Contient des commandes pour automatiser les tests de la configuration, génération d'image iso.                          |
| **patches**    | Contient des modifications pour calamares permettant d'inclure des configurations personnalisées durant l'installation. |
| **iso**    | Contient les configurations propres à l'image iso et des configurations ajoutées durant l'installation.                 |
| **modules**    | Contient l'ensemble des modules **GLF**                                                                                 |
| **assets**     | C'est ici que sont conservés les assets comme les wallpapers ou icons.                                                  |

# Fonctionnement du flocon à la racine du dépôt. 

Le flocon `./flake.nix` à la racine du dépôt endosse plusieurs capes. 

## Générer une configuration nixos 

- Import des modules NixOS pour obtenir le support d'installation calamares. 
- Import des channels pour qu'ils soient disponible dans l'iso (réduit la quantité à télécharger durant l'installation)
- Import du module GLF
- Import du fichier `./nix-cfg/configuration.nix`

- Permettre l'installation de paquets propriétaire. 
- Modification de calamares de sorte à permettre l'ajout d'une configuration personnalisée. 

- Paramètres liés à l'image ISO générée, tels que la compression, l'ajout du répertoire `./nix-cfg` dans l'iso.

Les lignes ci-dessous sont liés à `./nix-cfg/configuration.nix`

Le premier rôle est de construire une configuration NixOS incluant : 
- Configuration des langues pour proposer du français par défaut 
- Configuration du layout pour proposer AZERTY
- Ajout d'un utilisateur "nixos" (par défaut)
- HostName définit sur "GLF-OS"
- Activation du support des flocons













