---
title: Erreur avec le pilote avec un ancien GPU Nvidia
layout: default
parent: Assistance
---

# Nature du problème

Si vous lancez la commande `sudo dmesg`, si vous disposez d'un GPU Nvidia, vous pourriez obtenir l'erreur suivante : 

```bash
NVRM: The NVIDIA GeForce 920M GPU installed in this system is 
NVRM: supported through the NVIDIA 470.xx Legacy drivers. Please
NVRM: visit http://www.nvidia.com/object/unix.html fo more
NVRM: information. The 565.57.01 NVIDIA driver will ignore
NVRM: this GPU. Continuing probe...
NVRM: No NVIDIA GPU found.
```

# Raison du problème 

Comme indiqué clairement dans l'erreur, votre système utilise un driver Nvidia qui ne supporte pas votre GPU. 
Il est nécessaire d'utiliser une ancienne version, à savoir `470.xx`.

# Résolution du problème 

- **Ouvrez** l'application `Console`, 
- **Saisissez** la commande : 

```bash
sudo nano /etc/nixos/customConfig/default.nix
```

Ajoutez à l'intérieur de la seconde accolade : 

```nix
hardware.nvidia.package = lib.mkForce config.boot.kernelPackages.nvidiaPackages.legacy_470;
hardware.nvidia.dynamicBoost.enable = lib.mkForce false;
```

{: .info }
> Si vous êtes amené à utiliser un vieux pilote, vous devrez aussi désactiver la fonctionnalité `DynamicBoost` disponible sur les pilotes `560.xx`.<br>
> Cette seconde ligne vous permet de corriger l'erreur lié à [Dynamic Boost](./errorNvidiaDynamicBoost.html).


- **Sauvegardez** (`CTRL+O`, `ENTER`) puis **quittez** (`CTRL+X`, `ENTER`)

- **Reconstruisez** une nouvelle version GLFOS:

```bash
glf-switch
```

- Si vous n'obtenez pas d'erreur, **redémarrez**.

# Vérification

- **Ouvrez** l'application `Console`, 
- **Saisissez** la commande : 

```bash
sudo nvidia-smi 
```

Vérifiez le numéro de version du pilote, vous devriez obtenir `470.xx`.
