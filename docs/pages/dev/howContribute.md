---
title: Comment contribuer ? 
layout: default
parent: Développement
---

{: .in-progress }
> Cette page est en cours d'écriture.


*Je souhaite contribuer mais je n'ai aucune idée de comment faire.*

Pour contribuer, il y a plusieurs possibilités. 
Il y a plusieurs moyen pour contribuer au projet.

Vous pouvez ouvrir une issue pour `signaler un bug`, `proposer une amélioration` ou `modifier la documentation`. 
Vous pouvez également ouvrir une pull request pour proposer du code et le fusionner dans le projet. 

Quelques soit la nature de votre contribution, essayez d'être clair, évitez l'argot et faite des phrases complètes. 

# Soumettre du code : 

Concernant Git, si vous souhaitez proposer une pull request mais que vous ne connaissez pas git, voici quelques 
étapes pour vous aider. 

- Commencez par créer un compte [Github](https://github.com/login)
- Depuis l'appareil avec lequel vous développez, configurez Git. 

### Configurer Git

- Installez Git, puis configurez-le comme suit : 

```bash
git config --global user.name "VOTRE_NOM_D'UTILISATEUR"
git config --global user.email "you@example.com"
```

Vérifiez ensuite avec : 

```bash
git config --global user.name 
git config --global user.email
```

### Créer une clé SSH pour accéder à votre dépôt

Nous allons créer une clé ssh qui vous permettra d'accéder à votre dépôt github et d'envoyer votre code. 

Depuis votre machine 

```bash
ssh-keygen -t ed25519 -f ~/.ssh/github
```

Appuyez plusieurs fois sur **ENTER**. 

{: .note }
> Vous pouvez ajouter un mot de passe à votre clé si vous le souhaitez.
> Vous pouvez remplacer "github" par n'importe quel mots, il s'agit d'une simple chaine de caractères, le nom n'a aucune importance.

Après avoir généré la clé, vous devriez voir deux nouveaux fichiers dans `~/.ssh` à savoir : 

- `~/.ssh/github`
- `~/.ssh/github.pub`

Vous souhaitez garder en lieu sûr `github`, il s'agit de votre clé privée.
`github.pub` peut quant à lui être exposé, ça n'a pas d'importance, il s'agit de votre clé publique. 

Prenez un instant pour charger votre clé avec :

```bash
ssh-add ~/.ssh/github
```

Cette commande vous servira si votre clé ssh n'est pas automatiquement chargé.

### Ajouter la clé SSH sur github 

Accédez aux paramètres SSH depuis votre compte [Github](https://github.com/settings/keys). 

- New SSH key 
- Ajoutez un nom à votre clé SSH (par exemple le nom de l'appareil qui l'utilise)
- Ajoutez dans la section key, le contenu de votre clé `github.pub`

```bash
pbcopy < ~/.ssh/github.pub 
```

### Vérifier la clé SSH 

{: .note }
> - Vérifier la clé en copiant la ligne de commande de github, adapter après l'argument -f
> - Donner le retour de commande à github 
> - Vérifier la connexion entre git et github 

### Fork le projet 

Maintenant que vous avez configuré Git, vous êtes prêt pour contribuer. 

Rendez-vous sur le lien du [projet](https://github.com/Gaming-Linux-FR/GLF-OS) et cliquez sur le bouton "**Fork**", en haut à droite. 

Choisissez un nom à votre Fork, décochez **Copy the `main` branch only** puis cliquez sur **Create fork**.

{: .note }
> Actuellement, la branche `dev` est la branche principale du dépôt, `dev` pourrait être affiché à la place de `main`.
> Dans ce cas, la case peut rester coché. 

Après quelques instants, vous devriez avoir un nouveau dépôts sur votre compte. 
C'est sur ce dépôt que vous allez travailler. 

### Cloner le fork 

Depuis votre machine, 

```bash
git clone https://github.com/Gaming-Linux-FR/GLF-OS
```

{: .note }
> Remplacez `Gaming-Linux-FR` par votre nom d'utilisateur Github, `GLF-OS` par le nom de votre fork, si vous l'avez nommé différemment. 

### Créer une branche 

Si votre prompt shell n'indique pas le nom de la branche actuelle, saisissez la commande suivante pour le voir : 

```bash
git rev-parse --abbrev-ref HEAD
```

Si votre branche est `main`, vous allez d'abord devoir vous déplacer sur `dev` puisque c'est la branche de travail. 

```bash
git checkout dev 
```

Maintenant, vous devriez voir `dev` en saisissant la commande : 

```bash
git rev-parse --abbrev-ref HEAD
```

Une fois que vous avez confirmé que vous êtes bien sur dev, créez une nouvelle branche : 

```bash
git checkout -b maNouvelleBranche
```

{: .note }
> - Nous ne sommes pas pointilleux sur le nom des branches que vous utilisez.
> - Si vous n'avez pas d'idée, voici quelques exemples : 
>   - `feature_addSteamEnv`
>   - `fix_errorWithNixConfig`
>   - `doc_addIllustrations`
> - Prenez note que l'utilisation dun caractère "/" utilisé dans les paths peut provoquer des problèmes lorsque vous utilisez le makefile du dépôt. Si vous ne comptez pas l'utiliser, ne tenez pas compte de cette information.

### Créer un commit 

Vous venez de modifier par exemple la configuration Nix, vous souhaitez maintenant indiquer à Git que vous souhaitez versionner votre modification. 

Utilisez `git add chemin/vers/la/modification` ou directement `git add .` pour indiquer à Git d'inclure dans la nouvelle version les fichiers modifiés. 

Ensuite, créer un commit avec un message indiquant la nature du commit, par exemple : 

```bash
git commit -m "Mise à jour du flocon utilisateur"
```

### Bonus: nettoyez l'historique de votre branche

{: .note }
> - Reformuler, 
> - Illustrer.

Vous avez passé un très long moment sur votre modification et le nombre de commit dans le log est vous souhaitez fusionner
l'ensemble de vos modifications en un seul commit. 

Faites `git log` et repérez le commit précédent votre première modification (de la branche actuelle). 
Récupérer le hash dudit commit. 

Saissiez la commande : 

```bash
git rebase -i <HASH>
```

{: .note }
> - Remplacez <HASH> par celui que vous avez récupéré plus tôt. 

Une fenêtre avec un éditeur de texte apparaît, repérez la première ligne : 

```
pick HASH XXXXXXXX
```

Cette ligne, vous n'y touchez pas.
Pour toutes celles qui suivent, remplacez `pick` par `squash`
Lorsque vous avez terminé, sauvegardez et quittez votre éditeur de texte. 

Vous devriez maintenant avoir une nouvelle fenêtre affichant l'ensemble des messages de commit que vous avez écrit. 
Supprimez-les et remplacez-les par un message unique qui détaillera vos modifications. 

Sauvegardez et quittez.

### Pousser vers votre dépôt 

Votre modification est prête à être soumise au projet, envoyez vos modifications vers votre Fork : 

```bash
git push -uv origin 
```

Ouvrez la page vers votre fork, un message apparaîtra et vous proposera de contribuer en ouvrant une Pull Request. 
Cliquez dessus. 

Donner un nom à votre pull request de sorte à expliquer succintement la nature de votre contribution.
Ensuite, assurez-vous d'avoir à gauche le dépôt GLF-OS pointant vers `dev` et à droite votre dépôt pointant sur votre nouvelle branche. 

Expliquez dans le message ce que vous avez fait, si une issue lié existe, indiquez-le.

Validez votre pull request. 

A partir d'ici, nous contrôllons votre pull request et vous indiquons si elle est conforme ou non. 
