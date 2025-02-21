# TSSR-2411-P3-G4-Pharmgreen
## 📚 Pharmgreen S05_USER_GUIDE.md
> [!WARNING]  
> Si vous voyez ce message, c'est que la documentation n'est sûrement pas finie et qu'il est possible qu'il y ait des manques d'informations ou autres.
---
## 📑 Sommaire
- [📂 Dossiers partagés](#dossiers-partagés)
- [📁 Arborescence des dossiers](#arborescence-des-dossiers)
- [💾 Stockage avancé](#stockage-avancé)
- [⛔ Sécurité d'accès](#sécurité-d'accès)
- [📅 Avancée de la semaine](#av-sem)
---

### **📂 Dossiers partagés**
<span id="dossiers-partagés"></span> 

- Mise en place de **dossiers réseaux** pour les utilisateurs de l'entreprise :

  - **Stockage** : des données sur un volume spécifique.
  - **Sécurité** : de partage des dossiers par groupe AD.
  - **Mappage** : des lecteurs sur les clients.


---

### **📁 Arborescence des dossiers**
<span id="arborescence-des-dossiers"></span> 

L'arborescence des dossiers a été mise en place pour structurer l'infrastructure de stockage selon l'organisation de l'entreprise. Chaque département, sous-département, service et fonction dispose de dossiers spécifiques avec des règles d'accès dédiées.

#### **Exemple d'arborescence :**

```
Structure du dossier
Le num‚ro de s‚rie du volume est 0000000D EE2F:6096
C:\USERS\ALEXA\DESKTOP\PHARMGREEN.INTRA
+---Communication
|   +---Directrice communication
|   +---publicit‚
|   |   +---designer graphique
|   |   +---photographe
|   |   +---publicitaire
|   |   +---responsable publicit‚
|   |   \---Webmaster
|   \---Relation publique et presse
|       +---Charg‚ de communication
|       +---Charg‚ de presse
|       +---Charg‚ en droit de la communication
|       \---Responsable relation m‚dia
+---Direction FinanciŠre
|   +---Contr“le de gestion
|   |   \---controleur de gestion
|   +---Finance
|   |   +---Analyste Financier
|   |   \---DAF
|   \---Service Comptabilit‚
|       \---Comptabilit‚
+---Direction G‚n‚ral
|   +---Assistant de direction
|   +---CEO
|   +---Directeur adjoint
|   \---Secr‚taire
+---Direction Marketing
|   +---Marketing Digital
|   |   +---Analyste web
|   |   +---Community manager
|   |   +---Content manager
|   |   \---Responsable marketing digital
|   +---Marketing op‚rationnel
|   |   +---Assistant marketing
|   |   +---Charg‚ de promotion
|   |   +---Chef de projet
|   |   +---Coordinateur Marketing
|   |   \---Responsable Marketing operationnel
|   +---Marketing Produit
|   |   +---Chef de produit
|   |   +---Gestionaire de marque
|   |   \---Responsable de marque
|   \---Marketing strat‚gique
|       +---Analyste marketing
|       +---Chef de produit Strat‚gique
|       \---Directeur marketing strat‚gique
+---R&D
|   +---Innovation et strat‚gie
|   |   +---Chercheur
|   |   \---Responsable recherche
|   \---Laboratoire
|       +---Laborantin
|       \---Responsable Laboratoire
+---Ressources
|   +---logiciel
|   |       googlechromestandaloneenterprise64.msi
|   |       
|   \---wallpaper
|           wallpaper.png
|           
+---RH
|   +---Direction RH
|   |   +---Directeur adjoint RH
|   |   \---Directeur RH
|   +---Formation
|   |   \---Formateur
|   +---Gestion des performances
|   |   \---Agent RH performance
|   +---Recrutement
|   |   \---Agent RH
|   \---Sant‚ et scurit‚ au travail
|       +---Animateur s‚curit‚
|       +---Auditeur
|       \---Technicien HSE
+---Service g‚n‚raux
|   +---Gestion immobiliŠre
|   |   \---Gestionnaire immobilier
|   \---Logistique
|       +---Agent logistique
|       \---Responsable logistique
+---Service juridique
|   +---Contentieux
|   |   \---Juriste contentieux
|   \---Contrats
|       +---Juriste
|       \---Responsable juridique
+---Utilisateurs
\---Ventes et d‚voloppement commercial
    +---ADV
    |   +---Gestionnaire ADV
    |   \---Responsable ADV
    +---B2B
    |   +---Commercial B2B
    |   \---Responsable B2B
    +---B2C
    |   +---Commercial B2C
    |   \---Responsable B2C
    +---D‚veloppement internationnal
    |   +---Commerce international
    |   \---Directrice commercial
    +---Grands comptes
    |   +---Commercial
    |   \---Responsable Grands comptes
    +---Service achat
    |   +---Acheteur
    |   \---Responsable achat
    \---Service client
        +---Agent client
        \---Responsable service client
```

Chaque niveau de l'arborescence possède des **règles d'accès spécifiques** basées sur les groupes Active Directory (AD), garantissant que seuls les utilisateurs autorisés peuvent accéder aux ressources nécessaires.

---

### **💾 Stockage avancé**
<span id="stockage-avancé"></span> 

## 📌 Mettre en place du RAID 1 sur un serveur Debian

### **1️⃣ Explication**
Le RAID 1 est une solution de stockage en miroir où les données sont dupliquées sur deux disques identiques. Cela permet d'assurer la redondance des données en cas de panne d'un disque. Cependant, il ne procure pas d'augmentation de performance en écriture, car les données sont écrites simultanément sur les deux disques.

### **2️⃣ Guide d'installation**

#### **Prérequis**
- Un serveur Debian installé
- Deux disques de même capacité
- Le paquet `mdadm` installé

#### **Création du RAID 1**
- Identifier les disques avec :  
  ```bash
  lsblk
  ```
- Créer le RAID 1 avec :  
  ```bash
  sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdX /dev/sdY
  ```
  

#### **Configuration du RAID 1**
- Sauvegarder la configuration :  
  ```bash
  sudo mdadm --detail --scan >> /etc/mdadm/mdadm.conf
  ```
- Mettre à jour l'initramfs :  
  ```bash
  sudo update-initramfs -u
  ```
- Formater et monter la partition :  
  ```bash
  sudo mkfs.ext4 /dev/md0
  sudo mount /dev/md0 /mnt
  ```

---

## 📌 Mettre en place LVM sur un serveur Debian

### **1️⃣ Explication**
LVM (Logical Volume Manager) est un système de gestion de volumes logiques permettant une grande flexibilité dans la gestion des partitions. Il permet d'ajouter, redimensionner et supprimer des volumes logiques à la volée, contrairement aux partitions classiques qui sont fixes.

### **2️⃣ Guide d'installation**

#### **Prérequis**
- Un serveur Debian installé
- Un disque ou une partition disponible
- Le paquet `lvm2` installé

#### **Création de LVM**
- Initialiser le disque pour LVM :  
  ```bash
  sudo pvcreate /dev/sdX
  ```
- Créer un groupe de volumes :  
  ```bash
  sudo vgcreate mon_vg /dev/sdX
  ```
- Créer un volume logique :  
  ```bash
  sudo lvcreate -L 10G -n mon_lv mon_vg
  ```


#### **Configuration de LVM**
- Formater le volume logique :  
  ```bash
  sudo mkfs.ext4 /dev/mon_vg/mon_lv
  ```
- Monter la partition :  
  ```bash
  sudo mount /dev/mon_vg/mon_lv /mnt
  ```
- Ajouter au fstab pour un montage automatique :  
  ```bash
  echo "/dev/mon_vg/mon_lv /mnt ext4 defaults 0 2" | sudo tee -a /etc/fstab
  ```


---

### **⛔ Sécurité d'accès**
<span id="sécurité-d'accès"></span> 

Mise en place d'une sécurité d'accès permettant aux utilisateurs de notre entreprise de ne pas aller dans des dossiers dont ils n'auraient pas besoin.

- **Restriction d'utilisation** :
  - **Utilisateurs standards** : connexion **autorisée** de 8h à 18h, du lundi au vendredi sur les clients (bloquée le reste du temps).
  - **Administrateurs** : droit à un **bypass** constamment.
  - **Gestion des exceptions** : prévoir un groupe **bypass**.

---

### **📅 Avancée de la semaine**
<span id="av-sem"></span>

Voici l'avancée de notre 4ème semaine ci-dessous :
