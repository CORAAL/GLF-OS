---
title: Comment tester la documentation ? 
layout: default
parent: Développement
---

La documentation est générée puis déployée sur le dépôt à l'aide d'une "action" github. 
Lorsque vous écrivez dans votre fork la documentation, vous voudrez avoir un rendu en direct de vos modifications. 

Pour ce faire : 

```bash
cd docs
nix-shell -p bundler ruby --run "bundle install && bundle exec jekyll serve"
```

Après avoir récupéré localement les dépendances à la construction de la documentation, vous devriez voir une ligne : 

```bash
http://127.0.0.1:4000
```

{: .info }
> - Sachez que les modifications peuvent apparaître après un petit moment, 2-3 minutes parfois.
> - Les modifications d'un fichier existant, apparaîssent "instantanément" après un rechargement de la page.

Si nix est installé sur votre système, essayez : 

```bash
nix develop
```
