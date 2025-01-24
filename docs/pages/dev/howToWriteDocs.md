---
title: Comment écrire la documentation ? 
layout: default
parent: Développement
---

{: .in-progress }
> - A propos des paths pour les images
> - Documentation accessible (un maximum) aux débutants

La documentation est écrit au format [markdown](https://docs.framasoft.org/fr/grav/markdown.html). 

# Convention de noms 

## Noms de fichiers, répertoires
- Les noms de fichiers, répertoires sont en minuscule, dans le cas de noms composés, ajoutez une majuscule à la première de chaque mots : 

```
- dossier
- unDossier
- glfos
- glfosConfigurations
```

## Assets

- Les répertoires qui contiennent des illustrations propre à une page de documentation sont à une page, doivent être nommés comme la page suivis d'un `Assets` :

```
- page.md
- pageAssets
```

{: .in-progress }
> L'url ci-dessous pointe vers une url qui n'existe pas encore (docs non fusionné)

- Les illustrations "globales" sont à conservés dans `["docs/assets"](https://github.com/Gaming-Linux-FR/Nixos-by-GLF/tree/dev/docs/assets)`.
Ce sont des images qui peuvent être réutilisés.


# Ajouter une image 



{: .info }
> Les images sont stockés de cette façon pour que les tests locaux et le déploiement github aient le même résultat (des images qui s'affichent et qui pointent au même endroits)


