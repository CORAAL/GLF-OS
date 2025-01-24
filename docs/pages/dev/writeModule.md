---
title: Ecrire un module GLF 
layout: default
parent: Développement
---

{: .todo }
> - Où faut-il appeler le module ?
> - Que mettre dans l'entête en haut ?
> - Expliquer pourquoi il faut favoriser l'option `mkDefault` au lieu de `mkForce`

# Comment fonctionne le module GLF ?

Le module GLF est un ensemble d'options NixOS auquels nous avons appliqués des options pré-configuré. 

La structure d'un module est la suivante : 

```nix
{ lib, config, pkgs, ... }:

{

  options.glf.<option>.<sous-option> = lib.mkOption {
    description = "<Que fait l'option ?>";
	type = lib.types.<type>;
	default = true;
  };
  
  config = lib.mkIf config.glf.<option>.<sous-option> {
    
	# Option NixOS existante.
    # ....	

  };

}

```

Représentez-vous le premier bloc comme une description de l'option : 
- Nom
- Description
- Type de valeur attendue
- Valeur fournis par défaut

Le second bloc décrit ce qu'il se passe si l'option GLF est activé. 














