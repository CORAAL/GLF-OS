# Construction de l'ISO

Pour construire l'ISO, suivez les étapes ci-dessous :

1. **Accédez au répertoire** :
   ```sh
   cd chemin/vers/Nixos-by-GLF
   ```

2. **Exécutez la commande de construction** :
   ```sh
   nix build .#iso 
   ```

# Alternative (via utilisation de make)

> [!NOTE]  
> Pré-requis: `gnumake` doit être installé  
> Peut être installé temporairement via la commande `nix-shell -p gnumake`  

1. **Contruction de l'iso** :

La construction de l'iso peut être lancée via la commande:  
   ```
   make
   ```

Cette commande exécutera 2 opérations consécutives: `make iso` et `make install`.  

La première aura le même effet que la commande `nix build .#iso` hormis qu'elle ajoutera automatiquement les extra-features `nix-command flakes`.  
La deuxième copiera l'ISO généré (suffixé du nom de la branche courante) dans le répertoire `iso` à la racine du projet et créera son fichier hash associé.  

Exemple de résultat:  
   ```
   $ ls iso
   glfos-24.11.20241202.f9f0d5c_dev.iso  glfos-24.11.20241202.f9f0d5c_dev.iso.sha256sum
   ```

2. **Nettoyage après la construction** : 

Cette commande effacera tout ce qui a été généré localement, ISOs inclus.  

   ```
   make clean
   ```

3. **Test de la configuration nix** : 

Deux méthodes ici, la première permet de tester la configuration sans "build" et de repérer les erreurs de syntaxes.

```bash
make check
```

> [!NOTE]
> Les fichiers vérifiés sont ceux qui sont appelés par le flocon (ex: le répertoire glf)
> Tant que votre fichier est appelé par le flocon, configuration.nix ou un default.nix, le fichier sera vérifié.

La seconde méthode vérifie la syntaxe et construit la configuration sans générer d'iso (la configuration est mise en cache).

```bash 
make build
```

4. **Test de la configuration dans une machine virtuelle** :

La configuration peut-être construite et lancée dans une machine virtuelle (depuis nixos uniquement)

```bash
make build-vm
```
