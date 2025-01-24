---
title: Aider un utilisateur 
layout: default
parent: Assistance
nav_order: 2
---

{: .warning }
> * Cette page se base sur le PR #100 qui n'est pas encore fusionné dans dev. 

# Contexte

Un utilisateur demande de l'aide à propos d'un problème, vous devez récolter des informations pour pouvoir l'aider à le résoudre.
Cette page vise à vous guider pour l'aider efficacemment.

{: .info }
> N'oubliez pas de récolter les informations, ce sont ces informations qui permettent d'améliorer la documentation et réparer les problèmes connus.

## Réunir des informations

Si l'utilisateur ne l'a pas fait, demandez-lui de récupérer ce [formulaire](./troubleshootingForm.html) et d'y répondre. 

## Interpréter les informations

Dépendamment des réponses fournit, posez-vous ces questions : 

### Si l'utilisateur a modifié la configuration par défaut

- *Les options ajoutées, ont-elles un rapport avec le problème rencontré par l'utilisateur ?* (Exemple: Un problème GPU n'a aucun rapport avec le pilote d'imprimante)
- *Les options ajoutées, sont-elles en contradiction avec celle fournit par le module GLF-OS ?* (Exemple: Le module GLF active Firefox, l'option utilisateur le supprime)
- *L'erreur est-t-elle liée à une erreur de syntaxe nix ?*

### Configuration matérielle

- *L'appareil de l'utilisateur répond-t-il aux exigences minimales de GLF-OS (CPU, RAM, GPU, Disque) ?*
- *L'appareil de l'utilisateur dispose-t-il d'assez d'espace disque ?*

