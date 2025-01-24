---
title: Ajouter une github runner 
layout: default
parent: Développement
---

{: .warning }
> Cette page est en travaux et peut être incomplète

# Qu'est-ce qu'un Github Runner ? 

Un runner est un outil permettant à votre machine d'exécuter des actions github, un runner équivaut à une action maximum. 
Il est possible d'exécuter plusieurs runner sur une seule machine. 

Les étapes suivantes sont valide pour fonctionner sur votre fork comme sur le dépôt GLF. 

{: .warning }
> - En l'état, il est nécessaire d'exécuter le conteneur avec un argument `privileged` pour que l'action puisse exécuter nix avec les privilèges adéquat. 
> À l'avenir, l'objectif est de réduire un maximum les privilèges nécessaire à l'exécution des tâches. 
> - Les runner github se connectent à github et pas l'inverse, ça implique qu'il n'est pas nécessaire d'exposer le moindre port. 
> - Les runner doivent être exécutés sur des machines de confiance puisque le système de fichiers du conteneur est exposé. 

## Déployer un runner 

Dans un fichier `docker-compose.yml`

```yaml
services:
  github-runner:
    image: myoung34/github-runner:latest
    privileged: true
    environment:
      REPO_URL: ${REPO_URL}
      RUNNER_NAME: ${RUNNER_NAME}
      ACCESS_TOKEN: ${ACCESS_TOKEN}
      RUNNER_WORKDIR: ${RUNNER_WORKDIR}
      LABELS: ${LABELS}
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./tmp/runner:/tmp/runner
    deploy:
      resources:
        limits:
          cpus: '2.4'
          memory: 6g
```

Puis dans un `.env`

```yaml
REPO_URL=https://github.com/GLF-OS/Nixos-by-GLF
RUNNER_NAME=
ACCESS_TOKEN=
RUNNER_WORKDIR=/tmp/runner/work
ORG_RUNNER=false
LABELS=linux,x64
```

Dans **RUNNER_NAME**, inscrivez votre nom d'utilisateur puis dans **ACCESS_TOKEN**, inscrivez le token fournis par un membre de l'organisation. 

## Comment régler le pourcentage maximum d'utilisation du cpu/ram ?

Dans le `docker-compose.yml`, vous pouvez lire les lignes : 

```yaml
limits:
  cpus: '2.4'
  memory: 6g
```

### CPU 

Lancez la commande 

```bash
grep -c 'processor' /proc/cpuinfo
```

Si j'obtiens *4* (threads), je peux définir la limite maximale à **400%**, soit 100% par threads.

Dans l'exemple ci-dessus, j'ai définis à 240% l'utilisation du cpu soit un peu plus de la moitié des threads. 

### RAM 

La limite de mémoire permet de définir la quantité maximale allouée au runner. 

## Exécuter plusieurs instances du runner

Si vous disposez de kubernetes (k3s/k8s), il existe un controller permettant d'automatiquement équilibrer la charge dépendamment des actions en attente. 

{: .note }
>- Faites attention à ne pas utiliser `container_name`, docker doit être celui qui gère les noms.
>- Vous devez utiliser un volume docker et pas un montage local
>- Pensez à corriger les limites attribués au conteneur, puisque chaque conteneur se verra apposer la même limite et pas une limite pour l'ensemble.

```yaml
services:
  github-runner:
    image: myoung34/github-runner:latest
    privileged: true
    environment:
      REPO_URL: ${REPO_URL}
      RUNNER_NAME: ${RUNNER_NAME}
      ACCESS_TOKEN: ${ACCESS_TOKEN}
      RUNNER_WORKDIR: ${RUNNER_WORKDIR}
      LABELS: ${LABELS}
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - github_runner:/tmp/runner
    deploy:
      resources:
        limits:
          cpus: '2.4'
          memory: 6g
volumes:
  github_runner:
```

Pour déployer le conteneur, utilisez la ligne suivante (vous pouvez modifier 2 par n'importe qu'elle valeur): 

```bash
docker compose up -d --scale github-runner=2
```

Pour vérifier que le runner fonctionne bien : 

```bash
docker compose logs --follow
```

Lorsque ça fonctionne, vous devriez lire les lignes suivantes:

```bash
github-runner-1  | --------------------------------------------------------------------------------
github-runner-1  | |        ____ _ _   _   _       _          _        _   _                      |
github-runner-1  | |       / ___(_) |_| | | |_   _| |__      / \   ___| |_(_) ___  _ __  ___      |
github-runner-1  | |      | |  _| | __| |_| | | | | '_ \    / _ \ / __| __| |/ _ \| '_ \/ __|     |
github-runner-1  | |      | |_| | | |_|  _  | |_| | |_) |  / ___ \ (__| |_| | (_) | | | \__ \     |
github-runner-1  | |       \____|_|\__|_| |_|\__,_|_.__/  /_/   \_\___|\__|_|\___/|_| |_|___/     |
github-runner-1  | |                                                                              |
github-runner-1  | |                       Self-hosted runner registration                        |
github-runner-1  | |                                                                              |
github-runner-1  | --------------------------------------------------------------------------------
github-runner-1  |
github-runner-1  | # Authentication
github-runner-1  |
github-runner-1  |
github-runner-1  | √ Connected to GitHub
github-runner-1  |
github-runner-1  | # Runner Registration
github-runner-1  |
github-runner-1  |
github-runner-1  |
github-runner-1  |
github-runner-1  | √ Runner successfully added
github-runner-1  | √ Runner connection is good
github-runner-1  |
github-runner-1  | # Runner settings
github-runner-1  |
github-runner-1  |
github-runner-1  | √ Settings Saved.
github-runner-1  |
github-runner-1  |
github-runner-1  | √ Connected to GitHub
github-runner-1  |
github-runner-1  | Current runner version: '2.321.0'
github-runner-1  | 2025-01-01 15:36:14Z: Listening for Jobs
```

## Génération d'un token 

Le token est la clé qui permet à un github runner de se connecter à un dépôt. 
Il faut ouvrir cette [page](https://github.com/settings/tokens). 

- *Generate new token*
- *Generate new token (classic)*

{: .warning }
> Le token ne doit en aucun cas être fournis à un tiers ou rendu public.
> Gardez le précieusement.

Sur la page, donnez un nom au token et une date d'expiration. 

Sélectionnez ensuite les autorisations suivantes : 

```bash
- [X] repo 
  - [X] repo:status
  - [X] repo:deployment
  - [X] public_repo
  - [X] repo:invite
  - [X] security_events
- [X] workflow 
- [X] admin:org
  - [X] write:org
  - [X] read:org
  - [X] manage_runners.org
- [ ] admin:public_key 
  - [ ] write:public_key 
  - [X] read:public_key
- [ ] admin:repo_hook 
  - [ ] write:repo_hook
  - [X] read:repo_hook
- [X] notifications
```

Une fois généré, notez le token et ajoutez-le au `.env`

