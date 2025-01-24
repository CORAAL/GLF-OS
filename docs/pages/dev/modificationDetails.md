---
title: Détails des modifications  
layout: default
parent: Développement
---

Voici un tableau Markdown résumant le contenu des fichiers Nix fournis :

| Fichier          | Description                                 | Options                  | Configuration                                                                                                                                           |
|------------------|---------------------------------------------|--------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| `printing.nix`   | Configuration de l'impression               | `glf.printing.enable`    | Configure les pilotes d'imprimante, active la découverte automatique, supporte les scanners, ajoute les utilisateurs aux groupes scanner et lp.         |
| `gaming.nix`     | Configuration du gaming                     | `glf.gaming.enable`      | Installe des paquets de gaming, configure des variables d'environnement, ajoute des règles udev pour les contrôleurs, active le support matériel Steam. |
| `system.nix`     | Configuration du système                    | `glf.system.enable`      | Active les graphiques, optimise le stockage Nix.                                                                                                        |
| `updateConf.nix` | Configuration de la mise à jour automatique | `glf.autoUpgrade.enable` | Ajoute un script de mise à jour et configure un service systemd pour l'exécuter périodiquement.                                                         |
| `gnome.nix`      | Configuration de GNOME                      | `glf.gnome.enable`       | Active GNOME, configure les paquets système, les extensions, les paramètres GNOME, et les fonds d'écran.                                                |
| `nvidia.nix`     | Configuration de NVIDIA                     | `glf.nvidia_config`      | Configure les pilotes NVIDIA, le support Prime, le gestion de l'énergie.                                                                                |
| `nh.nix`         | Configuration de Nix Home                   | `glf.nh.enable`          | Ajoute des alias de shell et configure le nettoyage périodique.                                                                                         |
| `boot.nix`       | Configuration du démarrage                  | `glf.boot.enable`        | Nettoie `/tmp` au démarrage, configure les paramètres du noyau.                                                                                         |
| `fstrim.nix`     | Configuration de fstrim                     | `glf.fstrim.enable`      | Active fstrim pour le nettoyage des SSD.                                                                                                                |
| `default.nix`    | Fichier de configuration par défaut         | N/A                      | Importe tous les autres fichiers de configuration.                                                                                                      |
| `version.nix`    | Configuration de la version                 | `glf.version.enable`     | Configure les fichiers de version du système.                                                                                                           |
| `packages.nix`   | Configuration des paquets                   | `glf.packages.enable`    | Installe des paquets système et configure Flatpak.                                                                                                      |
| `firefox.nix`    | Configuration de Firefox                    | `glf.firefox.enable`     | Configure Firefox avec le support de PipeWire et les packs de langue.                                                                                   |
| `pipewire.nix`   | Configuration de PipeWire                   | `glf.pipewire.enable`    | Active PipeWire, JACK, PulseAudio, et ALSA.                                                                                                             |
