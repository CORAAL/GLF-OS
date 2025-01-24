---
title: Erreur avec Nvidia Dynamic Boost
layout: default
parent: Assistance
---

# Nature du problème

Après une reconstruction via `glf-switch`, si vous disposez d'un GPU Nvidia, vous pourriez obtenir l'erreur suivante : 

```bash
building Nix...
building the system configuration...
setting up /etc...
reloading user units for agarbu...
restarting sysinit-reactivation.target
the following new units started: flatpak-repo.service, run-credentials-systemd\x2dtmpfiles\x2dresetup.service.mount, sysinit-reactivation.target, systemd-tmpfiles-resetup.service
warning: the following units failed: nvidia-powerd.service
nvidia-powerd.service - nvidia-powerd service
   Loaded: loaded (/etc/systemd/system/nvidia-powerd.service; enabled; preset: ignored)
   Active: failed (Result: exit-code) since Sat 2025-01-11 15:02:27 CET; 269ms ago
Invocation: 37bcf2d843e54b43954543e7542eed8c
  Process: 2981 ExecStart=/nix/store/rswdx3495sqz279ddaw40mjfx23846hj-nvidia-x11-565.57.01-6.12-1-bin/bin/nvidia-powerd (code=exited, status=1/FAILURE)	 
 Main PID: 2981 (code=exited, status=1/FAILURE)
    IP: 0B in, 0B out
    IO: 0B read, 0B written
   Mem peak: 1.5M
        CPU: 14ms

janv. 11 15:02:27 GLF-OS /nix/store/rswdx3495sqz279ddaw40mjfx23846hj-nvidia-x11-565.57.01-6.12-1-bin/bin/nvidia-powerd[2981]: nvidia-powerd version:1.0(build 1)
janv. 11 15:02:27 GLF-OS /nix/store/rswdx3495sqz279ddaw40mjfx23846hj-nvidia-x11-565.57.01-6.12-1-bin/bin/nvidia-powerd[2981]: SBIOS support not found for NVPCF GET_SUPPORTED function
janv. 11 15:02:27 GLF-OS /nix/store/rswdx3495sqz279ddaw40mjfx23846hj-nvidia-x11-565.57.01-6.12-1-bin/bin/nvidia-powerd[2981]: no matching GPU found
janv. 11 15:02:27 GLF-OS /nix/store/rswdx3495sqz279ddaw40mjfx23846hj-nvidia-x11-565.57.01-6.12-1-bin/bin/nvidia-powerd[2981]: failed to initialize Dynamic Boost
janv. 11 15:02:27 GLF-OS /nix/store/rswdx3495sqz279ddaw40mjfx23846hj-nvidia-x11-565.57.01-6.12-1-bin/bin/nvidia-powerd[2981]: failed to detach GPU ID 256
janv. 11 15:02:27 GLF-OS /nix/store/rswdx3495sqz279ddaw40mjfx23846hj-nvidia-x11-565.57.01-6.12-1-bin/bin/nvidia-powerd[2981]: failed to initialize Dynamic Boost
janv. 11 15:02:27 GLF-OS /nix/store/rswdx3495sqz279ddaw40mjfx23846hj-nvidia-x11-565.57.01-6.12-1-bin/bin/nvidia-powerd[2981]: failed to detach GPU ID 256
janv. 11 15:02:27 GLF-OS systemd[1]: nvidia-powerd.service: Main process exited, code=exited, status=1/FAILURE
janv. 11 15:02:27 GLF-OS systemd[1]: nvidia-powerd.service: Failed with result 'exit-code'.
janv. 11 15:02:27 GLF-OS systemd[1]: Failed to start nvidia-powerd.service.
warning: error(s) occurred while switching to the new configuration
```


# Raison du problème 

Cette erreur peut apparaître lorsque l'option NixOS `hardware.nvidia.dynamicBoost.enable` est activée et que votre GPU n'est pas compatible car trop ancien.<br>
**Nvidia-powerd** fournit un support pour la fonctionnalité [NVIDIA Dynamic Boost](https://download.nvidia.com/XFree86/Linux-x86_64/510.47.03/README/dynamicboost.html), il permet de contrôler l'alimentation du CPU et du GPU en fonction de la charge de travail du système. 


# Résolution du problème 

- **Ouvrez** l'application `Console`, 
- **Saisissez** la commande : 

```bash
sudo nano /etc/nixos/customConfig/default.nix
```

Ajoutez à l'intérieur de la seconde accolade : 

```nix
hardware.nvidia.dynamicBoost.enable = lib.mkForce false;
```

- **Sauvegardez** (`CTRL+O`, `ENTER`) puis **quittez** (`CTRL+X`, `ENTER`)

- **Reconstruisez** une nouvelle version GLFOS:

```bash
glf-switch
```

# Vérification

L'erreur devrait avoir disparu.

