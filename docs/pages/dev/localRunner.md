---
title: Runners locaux 
layout: default
parent: Développement
---

# Comment exécuter localement des workflows ?

Il est possible d'exécuter localement les workflows sans devoir systématiquement pousser votre code vers un dépôt.
Les workflows sont conservés dans `.github/workflows` et sont exécutable à l'aide de `docker` et `act`.

## Pré-requis 

- Docker
- act 

### Cas Mac ARM
{: .info }
> - Si vous êtes en possession d'un Mac doté d'une puce ARM (M1/M2/...), vous ne pourrez pas exécuter les builds qui sont prévus pour x86_64.
> Si vous avez une machine x86_64 accessible via SSH et docker d'installé, suivez les lignes suivantes depuis votre MAC.
> - Vous souhaiterez utiliser une clé ssh pour accéder à votre machine distante.

Précédez chacune de vos commandes `act` avec cette variable d'environnement, éditez les mots `user`, `ip` et `port` pour correspondre à votre appareil. 
Si vous utilisez le port SSH par défaut (22), vous pouvez retirer `:port`.

```bash
DOCKER_HOST='ssh://user@ip:port' act
```

## Lister les workflows

```bash
act -l
```

```bash
Stage  Job ID  Job name  Workflow name                Workflow file  Events
0      build   build     Deploy Jekyll site to Pages  pages.yaml     push,workflow_dispatch
1      deploy  deploy    Deploy Jekyll site to Pages  pages.yaml     workflow_dispatch,push
```

## Exécuter les workflows 

```bash
act
```

## Exécuter un workflow spécifique

Si nous reprenons le résultat de la liste précédent, nous allons essayer de "build" la documentation.

```bash
act -j build
```
