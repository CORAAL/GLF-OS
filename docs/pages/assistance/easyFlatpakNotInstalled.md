---
title: EasyFlatpak n'est pas installé 
layout: default
parent: Assistance
---

{: .warning }
> Cette page deviendra caduc lorsqu'*EasyFlatpak* sera fournis via un paquet nix natif au lieu de flatpak.

# Nature du problème
**Easy Flatpak** n'apparaît pas, ni dans la barre des tâches, ni dans la liste d'applications. 

# Raison du problème 
Easy Flatpak est actuellement installé via Flatpak.

Pour des raisons techniques, l'installation de ce dernier est exécuté post-installation avec le service `flatpak-repo` et n'apparaît donc pas immédiatement au premier démarrage. 
Plusieurs dépendances doivent être d'abord installé ce qui nécessite un certains temps (dépends de votre connexion internet). 

Après un certains temps, EasyFlatpak devrait apparaître de lui-même (après une dizaine de minutes) ou après un redémarrage. 

Pour consulter la progression de l'installation : 

- **Ouvrez** l'application `Console`,
- **Exécutez la commande** dans le terminal : 

```bash
sudo journalctl -u flatpak-repo.service -f
```

Vous pourriez également avoir un problème lié au réseau, vérifiez que vous ayez bien une connexion internet.

# Résolution

Si le service est planté, EasyFlatpak n'est pas installé après un long moment, depuis l'application `Console`, **exécutez la commande**:

```bash
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && flatpak install -y flathub org.dupot.easyflatpak
```

- **Redémarrez**.

# Vérification 

EasyFlatpak doit apparaître dans votre liste d'application et la barre des tâches. 
