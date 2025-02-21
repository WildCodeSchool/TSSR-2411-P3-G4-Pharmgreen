# TSSR-2411-P3-G4-Pharmgreen
## 📚 Pharmgreen S05_USER_GUIDE.md
> [!WARNING]  
> Si vous voyez ce message, c'est que la documentation n'est sûrement pas finie et qu'il est possible qu'il y ait des manques d'informations ou autres.
---
## 📑 Sommaire
- [📂 Dossiers partagés](#dossiers-partagés)
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
  ![RAID 1 Creation](https://upload.wikimedia.org/wikipedia/commons/3/3c/RAID_1.svg)

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
  ![LVM Schema](https://upload.wikimedia.org/wikipedia/commons/0/04/Linux_LVM.svg)

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
