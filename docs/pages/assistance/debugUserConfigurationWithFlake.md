---
title: Débugguer la configuration d'un utilisateur à l'aide du flocon 
layout: default
parent: Assistance
nav_order: 3
---

{: .in-progress }
> Cette page est en cours de rédaction, elle peut être incomplète.
> La documentation décrit un cas d'utilisation fonctionnant uniquement après que la Pull Request #100 ait été fusionné. 

{: .todo }
> Illustrer ce que voit l'utilisateur & l'assistant

Nous allons voir ici comment aider l'utilisateur en profitant du mécanisme des flocons.

L'idée est la suivante : 

- L'utilisateur à un `flocon` dans sa configuration ce qui lui permet de modifier la provenance des sources qu'il utilise pour 
ses paquets, modules, etc. 
GLF-OS est un simple module que l'on appose sur une configuration NixOS, le flocon que nous fournissons par défaut à l'utilisateur récupère le module GLF-OS
du dépôt `Gaming-Linux-FR/GLF-OS`. 
Nous allons voir un exemple de dépannage où l'assistant fournira une branche temporaire de debug à l'utilisateur.
L'utilisateur aura trois tâches, `rebuild`, fournir les logs et alerter la personne lorsque le problème est résolu. 

# Contexte 

Dans cet exemple, nous allons partir d'un cas connu, l'utilisation de GLF-OS sur un laptop équipé d'un ancien GPU NVIDIA.
Cet situation implique deux problèmes : 

- L'utilisateur doit utiliser une ancienne version du pilote GPU, dans notre exemple la version `470`. 
- Puisque l'utilisateur utilise une ancienne version (`470`), il doit désactiver l'option `hardware.nvidia.dynamicBoost.enable` qui inclut la fonctionnalité `Dynamic Boost`
uniquement disponible à partir du pilote `560` et plus, cette option est activé par défaut avec GLF-OS. 

Dans la confiuration, ça corresponds à : 

```nix
hardware.nvidia.package = lib.mkForce config.boot.kernelPackages.nvidiaPackages.legacy_470;
hardware.nvidia.dynamicBoost.enable = lib.mkForce false;
# ou 
hardware.nvidia = { 
  package = lib.mkForce config.boot.kernelPackages.nvidiaPackages.legacy_470;
  dynamicBoost.enable = lib.mkForce false;
};
```

# Situation 
## Récupérer les informations 

L'utilisateur vous a fourni dans une issue ou un `help-me` sur discord, des informations sur ça machine (corresponds au retour de commande `glf-systeminfo`).

```bash
--- Infos ---
Machine:
  Type: Laptop System: LENOVO product: 80DU v: Lenovo Y70-70 Touch serial: <superuser required>
  Mobo: LENOVO model: Lenovo Y70-70 Touch v: 31900058WIN serial: <superuser required>
    UEFI: LENOVO v: 9ECN31WW(V1.14) date: 08/18/2014

--- CPU ---
Architecture :                          x86_64
Mode(s) opératoire(s) des processeurs : 32-bit, 64-bit
Identifiant constructeur :              GenuineIntel
Nom de modèle :                         Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz

--- GPU ---
00:02.0 VGA compatible controller: Intel Corporation 4th Gen Core Processor Integrated Graphics Controller (rev 06)
01:00.0 3D controller: NVIDIA Corporation GM107M [GeForce GTX 860M] (rev a2)

--- Disque ---
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        393M     0  393M   0% /dev
tmpfs           3,9G     0  3,9G   0% /dev/shm
tmpfs           2,0G  7,1M  2,0G   1% /run
/dev/sda2       228G   37G  180G  17% /
efivarfs         88K   56K   28K  67% /sys/firmware/efi/efivars
tmpfs           1,0M     0  1,0M   0% /run/credentials/systemd-journald.service
tmpfs           1,0M     0  1,0M   0% /run/credentials/systemd-tmpfiles-setup-dev-early.service
tmpfs           1,0M     0  1,0M   0% /run/credentials/systemd-tmpfiles-setup-dev.service
tmpfs           3,9G  1,2M  3,9G   1% /run/wrappers
tmpfs           1,0M     0  1,0M   0% /run/credentials/systemd-vconsole-setup.service
/dev/sda1       511M   91M  421M  18% /boot
tmpfs           1,0M     0  1,0M   0% /run/credentials/systemd-tmpfiles-setup.service
tmpfs           1,0M     0  1,0M   0% /run/credentials/systemd-sysctl.service
tmpfs           1,0M     0  1,0M   0% /run/credentials/getty@tty1.service
tmpfs           786M   72K  786M   1% /run/user/1000

--- RAM ---
               total       utilisé      libre     partagé tamp/cache   disponible
Mem:           7,7Gi       1,2Gi       4,9Gi       148Mi       2,0Gi       6,5Gi
Échange:          0B          0B          0B
```

Dans la section `GPU`, vous pouvez remarquer `01:00.0 3D controller: NVIDIA Corporation GM107M [GeForce GTX860M] (rev a2)`, ça nous apprends que le GPU est une 
**GTX860M**. 

La commande `sudo nvidia-smi --version` nous apprends que nous utilisons le driver 565.77 : 

```bash
NVIDIA-SMI version  : 565.77
NVML version        : 565.77
DRIVER version      : 565.77
CUDA Version        : 12.7
```

{: .note }
> Puisque nous savons déjà comment résoudre le problème, passons à l'étape dédié aux tests

## Création d'une branche de debug 

{: .info }
> Nous allons supposer que vous avez déjà configuré git et votre compte Github, si vous ne l'avez pas fait, consulter la page sur "Comment contribuer". 

- Depuis la page du [projet](https://github.com/Gaming-Linux-FR/GLF-OS), cliquez sur le bouton `Fork` pour créer une copie du projet. 
- Depuis votre machine : 

```bash
git clone https://github.com/votreUtilisateur/GLF-OS
```

- Assurez-vous de partir de la branche `main` 

```bash
git checkout main 
```

- Créez une nouvelle branche :

```bash
git checkout -b debug_user 
```

{: .note }
> Le nom de la nouvelle branche n'a pas d'importance, essayez de mettre un prefix `debug_` ou n'importe qu'elle information qui permette de clairement 
> comprendre le rôle de cette branche. 

- Poussez votre branche vers votre fork 

```bash
git push origin debug_user 
```

## Modifier le flocon utilisateur 

Demandez à l'utilisateur d'ouvrir le fichier `/etc/nixos/flake.nix` puis d'effectuer les modifications suivantes : 

Par défaut, l'utilisateur devrait avoir le flocon : 

```nix
{

  description = "GLF-OS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    glf.url = "github:Gaming-Linux-FR/GLF-OS/main";
  };

  outputs = { self, nixpkgs, glf, ... }@inputs:
  let
    pkgsSettings = system: import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
   nixosConfigurations."GLF-OS" = nixpkgs.lib.nixosSystem {
      pkgs = pkgsSettings "x86_64-linux";
      modules = [
	./configuration.nix
	inputs.glf.nixosModules.default
      ];
    };
  };
  
}
```

Ici, l'utilisateur doit éditer la section inputs et ajouter un caractère `#` devant `glf.url`.
Ensuite, il ajoute une nouvelle ligne pointant vers votre dépôt : 

```nix 
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    #glf.url = "github:Gaming-Linux-FR/GLF-OS/main";
    glf.url = "github:yourGithubUsername/GLF-OS/debug_user";
  };
```

{: .note }
> Vous devez faire attention à bien préciser le nom de votre branche de debug, auquel cas, les modifications portés sur votre branche n'auront aucune 
> conséquence sur la machine utilisateur. 

## Test de la branche 

L'utilisateur doit maintenant effectuer les commandes : 

```bash
glf-update && glf-switch 
```

Si aucune erreur n'a été commise, l'utilisateur ne devrait avoir aucune erreur. 

## Correction 

L'assistant peut maintenant ajouter des modifications pour corriger le problème chez l'utilisateur. 

Nous allons ouvrir le fichier `./modules/default/debug.nix`.

```nix 
{ lib, config, pkgs, ... }:

{

  options.glf.debug.enable = lib.mkOption {
    description = "Enable GLF debug";
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf config.glf.debug.enable {

    # Add your debug configurations here

  };

}
```

Nous allons ajouter notre correctif mentionné au début de cette page à savoir : 

```nix 
hardware.nvidia.package = lib.mkForce config.boot.kernelPackages.nvidiaPackages.legacy_470;
hardware.nvidia.dynamicBoost.enable = lib.mkForce false;
```

Nous avons maintenant : 


```nix 
{ lib, config, pkgs, ... }:

{

  options.glf.debug.enable = lib.mkOption {
    description = "Enable GLF debug";
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf config.glf.debug.enable {

    # Add your debug configurations here
    hardware.nvidia.package = lib.mkForce config.boot.kernelPackages.nvidiaPackages.legacy_470;
    hardware.nvidia.dynamicBoost.enable = lib.mkForce false;

  };

}
```

```bash 
git add `./modules/default/debug.nix`
git commit -m "Fixer la version du pilote nvidia sur 470, désactivation de dynamic Boost". 
git push origin 
```

{: .info }
> Prenez le temps d'indiquer un message à vos commits, ça vous permettra à vous aux mainteneurs du projet de comprendre ce que vous avez fait.

## Test de la correction chez l'utilisateur 

Depuis l'application `Console`, 

```bash
glf-update && glf-switch 
```

Puisque nous touchons au pilote nvidia, l'utilisateur devrait redémarrer pour s'assurer que la correction ait bien fonctionné. 

Après le redémarrage, l'utilisateur s'assure que son driver est à la bonne version : 

```bash
sudo nvidia-smi --version
```

## Rapporter la solution au projet 

Maintenant que vous avez confirmé que la modification a bien résolu le problème, il vous reste plus qu'à ouvrir une issue pour expliquer ce que vous avez fait. 
Une pull request "propre" sera ensuite ouverte pour inclure les modifications.

{: .todo }
> Lorsque le projet à introduit les changements au projet, l'utilisateur doit ensuite rebasculer sur l'input GLF d'origine, sinon il ne recevra pas les mises à jours du module. 








