---
title: Débugguer un flocon 
layout: default
parent: Développement
---

L'écriture d'un flocon ou d'une configuration est parfois difficile pour de nombreuses raisons. 

Cette page vous donne quelques pistes pour apprendre à debugger. 

# Nix Repl 

Depuis le même répertoire que votre flocon : 

```bash
nix repl 
```

Charger le flocon dans nix repl :

```nix
:lf .
```

En appuyant plusieurs fois sur **TAB**, vous verrez ce que vous avez dans la portée.
Essayons de voir les inputs. Pensez à appuyer sur **TAB** après avoir saisi la ligne :

```nix
inputs.
```

De mon côté, avec le flocon du module GLF, je peux voir les inputs `nixpkgs` et `utils`.

```bash
nix-repl> inputs.
inputs.nixpkgs  inputs.utils
```

Essayons avec les outputs :

```nix
outputs.

```

On retrouve effectivement le devShells (pour build la documentation), l'iso et nixosConfigurations.

```nix
nix-repl> outputs.
outputs.devShells            outputs.iso                  outputs.nixosConfigurations
```

Descendons en profondeur dans `outputs.nixosConfigurations` pour retrouver nos options. 
Je vous épargne la recherche : 

```nix
nix-repl> outputs.nixosConfigurations.glf-installer.config.
```

On obtient :

```nix
nix-repl> outputs.nixosConfigurations.glf-installer.config.
outputs.nixosConfigurations.glf-installer.config.appstream
outputs.nixosConfigurations.glf-installer.config.assertions
outputs.nixosConfigurations.glf-installer.config.boot
outputs.nixosConfigurations.glf-installer.config.console
outputs.nixosConfigurations.glf-installer.config.containers
outputs.nixosConfigurations.glf-installer.config.docker-containers
outputs.nixosConfigurations.glf-installer.config.documentation
outputs.nixosConfigurations.glf-installer.config.dysnomia
outputs.nixosConfigurations.glf-installer.config.ec2
outputs.nixosConfigurations.glf-installer.config.environment
outputs.nixosConfigurations.glf-installer.config.fileSystems
outputs.nixosConfigurations.glf-installer.config.fonts
outputs.nixosConfigurations.glf-installer.config.gtk
outputs.nixosConfigurations.glf-installer.config.hardware
outputs.nixosConfigurations.glf-installer.config.i18n
outputs.nixosConfigurations.glf-installer.config.ids
outputs.nixosConfigurations.glf-installer.config.installer
outputs.nixosConfigurations.glf-installer.config.isSpecialisation
outputs.nixosConfigurations.glf-installer.config.isoImage
outputs.nixosConfigurations.glf-installer.config.jobs
outputs.nixosConfigurations.glf-installer.config.krb5
outputs.nixosConfigurations.glf-installer.config.lib
outputs.nixosConfigurations.glf-installer.config.location
outputs.nixosConfigurations.glf-installer.config.meta
outputs.nixosConfigurations.glf-installer.config.nesting
outputs.nixosConfigurations.glf-installer.config.networking
outputs.nixosConfigurations.glf-installer.config.nix
outputs.nixosConfigurations.glf-installer.config.nixops
outputs.nixosConfigurations.glf-installer.config.nixpkgs
outputs.nixosConfigurations.glf-installer.config.nvidia_config
outputs.nixosConfigurations.glf-installer.config.oci
outputs.nixosConfigurations.glf-installer.config.openstack
outputs.nixosConfigurations.glf-installer.config.passthru
outputs.nixosConfigurations.glf-installer.config.power
outputs.nixosConfigurations.glf-installer.config.powerManagement
outputs.nixosConfigurations.glf-installer.config.programs
outputs.nixosConfigurations.glf-installer.config.qt
outputs.nixosConfigurations.glf-installer.config.qt5
outputs.nixosConfigurations.glf-installer.config.security
outputs.nixosConfigurations.glf-installer.config.services
outputs.nixosConfigurations.glf-installer.config.snapraid
outputs.nixosConfigurations.glf-installer.config.sound
outputs.nixosConfigurations.glf-installer.config.specialisation
outputs.nixosConfigurations.glf-installer.config.stubby
outputs.nixosConfigurations.glf-installer.config.swapDevices
outputs.nixosConfigurations.glf-installer.config.system
outputs.nixosConfigurations.glf-installer.config.systemd
outputs.nixosConfigurations.glf-installer.config.time
outputs.nixosConfigurations.glf-installer.config.users
outputs.nixosConfigurations.glf-installer.config.virtualisation
outputs.nixosConfigurations.glf-installer.config.warnings
outputs.nixosConfigurations.glf-installer.config.xdg
outputs.nixosConfigurations.glf-installer.config.zramSwap
```

Cela doit vous être familié, non ? 

Regardez la dernière ligne `zramSwap`, elle correspond aux options [nixos](https://search.nixos.org/options?channel=24.11&from=0&size=50&sort=relevance&type=packages&query=zramSwap).

```nix 
nix-repl> outputs.nixosConfigurations.glf-installer.config.zramSwap.
outputs.nixosConfigurations.glf-installer.config.zramSwap.algorithm        outputs.nixosConfigurations.glf-installer.config.zramSwap.priority
outputs.nixosConfigurations.glf-installer.config.zramSwap.enable           outputs.nixosConfigurations.glf-installer.config.zramSwap.swapDevices
outputs.nixosConfigurations.glf-installer.config.zramSwap.memoryMax        outputs.nixosConfigurations.glf-installer.config.zramSwap.writebackDevice
outputs.nixosConfigurations.glf-installer.config.zramSwap.memoryPercent
outputs.nixosConfigurations.glf-installer.config.zramSwap.numDevices
```

Essayons de lire la valeur de l'option `zramSwap.enable` (cette fois, utilisez ENTER pour valider) : 

```nix
nix-repl> outputs.nixosConfigurations.glf-installer.config.zramSwap.enable
[1 copied (185.6 MiB), 28.6 MiB DL]false
```

Essayons avec une autre option. 

```nix
nix-repl> outputs.nixosConfigurations.glf-installer.config.programs.firefox.enable
[1 copied (185.6 MiB), 28.6 MiB DL]true
```

Comme vous pouvez le voir, vous venez d'apprendre à parcourir les **attributs** d'un flocon, retrouver une option ainsi que la valeur actuellement attribué ! 




```nix

```


```nix

```





