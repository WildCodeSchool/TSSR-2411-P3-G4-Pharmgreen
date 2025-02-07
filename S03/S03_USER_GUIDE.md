# TSSR-2411-P3-G4-Pharmgreen
## 📚 Pharmgreen S03_USER_GUIDE.md
---
## 📑 Sommaire
- [🖥️ GLPI](#glpi)
- [⚙️ Script ADDS](#script-adds-core)
- [🌐 Plan réseau](#p-r)

---

### **🖥️ GLPI, Installation et configuration**
<span id="glpi"></span> 

Suivre le [S03_INSTALL.md](https://github.com/WildCodeSchool/TSSR-2411-P3-G4-Pharmgreen/tree/main/S03) pour l'installation et la configuration de GLPI ainsi que de ses dépendances.

- **Création d’un script**
  - **Automatisation**: de l'installation de GLPI ainsi que de ses **dépendances associées**
  - **Configuration**: de la **base de données** et des fichiers de configuration

> [!NOTE]  
> 🏗️ **On travaille actuellement sur la synchronisation via Active Directory pour les utilisateurs**

---

### **⚙️ Script ADDS**
<span id="script-adds-core"></span> 

Ce script permet de **configurer** l'ADDS sur un serveur **Windows Core**, c'est-à-dire sans interface graphique.
Il permet **d'automatiser** entièrement l'installation et la configuration via un script, sans avoir à saisir un grand nombre de commandes, ce qui représente un **gain de temps considérable**.

- **Création d'un script**
  - **Installation AD-DS**: Si l'AD-DS n'est pas installé, le script l'installe automatiquement.
  - **Configuration IP**: Le script récupère les paramètres du serveur depuis un fichier CSV et configure, via ce fichier, le nom du serveur, l'adresse IP, l'utilisateur, le mot de passe, etc.
  - **Confirmation**: Il confirme les modifications et l'installation, puis redémarre la machine.

---

### **🌐 Plan réseau**
<span id="p-r"></span> 

Mise en place d'un schéma du réseau

- Création du schéma réseau via Cisco Packet Tracer
    - **Haute disponibilité**
    - **DMZ**
    - **Méthode de load balancing**
    - **Sécurité** (Firewall, Honeypot)

**Schéma du réseau**:
> [!TIP]
> Clique sur les images pour les afficher en grand.

**Haut du schéma:**
<img src="https://github.com/WildCodeSchool/TSSR-2411-P3-G4-Pharmgreen/blob/main/Ressources/Plan%20R%C3%A9seau/haut.png?raw=true" alt="Plan Réseau" width="1900">
**Bas du schéma:**
<img src="https://github.com/WildCodeSchool/TSSR-2411-P3-G4-Pharmgreen/blob/main/Ressources/Plan%20R%C3%A9seau/bas.png?raw=true" alt="Plan Réseau" width="1900">

