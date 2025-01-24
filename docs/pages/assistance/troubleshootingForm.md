---
title: Formulaire de dépannage 
layout: default
parent: Assistance
nav_order: 1
---

# Formulaire de dépannage pour les utilisateurs de GLF-OS

Ce formulaire est conçu pour aider l'utilisateur à fournir des informations clairs et pertinentes pour la ou les personnes qui lui viennent en aide de sorte que ce dernier puisse se concentrer sur la résolution du problème.
Nous ne demandons aucune informations sensible ou personnelle. 


## 1. Description du problème: 

* **Description du problème :** Quel est le problème que vous rencontrez ?
* **Date d'apparition du problème :** Quand le problème a-t-il commencé, quand l'avez-vous remarqué ?
* **Activité en cours :** Que faisiez-vous lorsque le problème est apparu ? 

## 2. Informations sur le système : 

- **Ouvrez l'application** `Console`:
- **Copier puis collez la commande suivante dans l'application:**

```bash
nix-shell -p pciutils util-linux inxi gawk --run '
echo -e "\n--- Infos ---" 
inxi -M 
echo -e "\n--- CPU ---" 
lscpu | grep -E "(Architecture|CPU op-mode|Vendor ID|Model name|Mode\(s\) opératoire\(s\) des processeurs|Identifiant constructeur|Nom de modèle)" | awk "{print \$0}" 
echo -e "\n--- GPU ---" 
lspci | grep -E "VGA|3D" 
echo -e "\n--- Disque ---" 
df -h 
echo -e "\n--- RAM ---" 
free -h
'
```

{: .info }
> Un alias qui propose la même commande : `glf-systemInfo`

## 3. Actions déjà entreprises : 

- Démarches effectuées : Avez-vous déjà essayé des solutions pour résoudre le problème ? (**Oui**/**Non**)
  - Si oui, décrivez ce que vous avez fait.

## 4. Modifications de la configuration : 

- **Changement apportés :** Avez-vous modifié la configuration fournie par défaut ? (**Oui**/**Non**)
- **Détails des modifications :** Si oui, décrivez les changements apportés.

## 5. Impact du problème: 

- 🪦 Bloquant : Je ne peux pas utiliser le système.

- 🚨 Majeur : Des fonctionnalités critiques ne sont pas disponibles.

- ⚠️ Mineur : Gênant, mais gérable.

- 👁 Cosmétique : Problème visuel ou de confort uniquement.

## 6. Informations supplémentaires : 

- **Autres détails :** Fournissez toute autre information que vous jugez pertinente.

## 7. Version du flocon

- **Fournissez les informations sur votre version du flocon :**
  - **Ouvrez l'application `Console`**:
    - **Fournissez le retour de la commande:**

```bash
cat /etc/nixos/flake.lock
```












