---
title: Erreur avec Nvidia après une mise à jour
layout: default
parent: Assistance
---

# Nature du problème

Après une reconstruction via `glf-switch`, si vous disposez d'un GPU Nvidia, vous pourriez obtenir l'erreur suivante : 

```bash
nvidia-powerd.service - nvidia-powerd service
   Loaded: loaded (/etc/systemd/system/nvidia-powerd.service; enabled; preset: enabled)
   Active: failed (Result: exit-code) since Mon 2024-12-02 18:57:41 EET; 268ms ago
   Invocation: 3407735c2e43471e9a1c29c4209082a6
  Process: 149160 ExecStart=/nix/store/xdxyd05p3brlj7s1nsij58kivf7q9lc1-nvidia-x11-550.120-6.10.9-bin/bin/nvidia-powerd (code=exited, status=1/FAILURE)
```

Remarquez `failed to initialize Dynamic Boost` dans l'erreur.

# Raison du problème 

Cette erreur peut apparaître après la mise à jour du pilote Nvidia, le service `nvidia-powerd` n'arrive pas à se lancer.<br>
**Nvidia-powerd** fournit un support pour la fonctionnalité [NVIDIA Dynamic Boost](https://download.nvidia.com/XFree86/Linux-x86_64/510.47.03/README/dynamicboost.html), il permet de contrôler l'alimentation du CPU et du GPU en fonction de la charge de travail du système. 

Parfois, après une mise à jour, le service peine à se relancer. 

# Résolution du problème 

- **Ouvrez** l'application `Console`, 
- **Saisissez** la commande : 

```bash
glf-boot
```

Cette commande va construire la nouvelle version et l'exécuter au prochain démarrage. 

- **Redémarrez**.

# Vérification

- **Ouvrez** l'application `Console`, 
- **Saisissez** la commande : 

```bash
sudo systemctl status nvidia-powerd.service
```

L'erreur devrait avoir disparu.
