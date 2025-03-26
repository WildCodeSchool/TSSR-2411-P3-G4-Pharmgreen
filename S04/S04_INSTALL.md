# TSSR-2411-P3-G4-Pharmgreen
## 📚 Pharmgreen S07_INSTALL.md
---
## 📑 Sommaire
- [🌐 pfSense](#pfsense)
- [🍯 HoneyPot](#honeypot)

---
## **🌐 Installation de pfSense**
<span id="pfsense"></span> 

### **1️⃣ Prérequis**

- Une machine physique ou virtuelle avec au moins 2 interfaces réseau

- Une image ISO de pfSense téléchargeable sur https://www.pfsense.org/

### **2️⃣ Installation de pfSense

- Démarrer sur l'ISO de pfSense

- Suivre l'assistant d'installation

- Partitionner automatiquement le disque

- Configurer les interfaces WAN et LAN

- Installer les paquets nécessaires

### **3️⃣ Configuration Initiale

- Accéder à l'interface web

- Se connecter avec `admin / pfsense`

- Modifier le mot de passe administrateur

- Configurer le WAN (IP statique ou DHCP)

- Configurer le LAN (DHCP ou IP statique)

---

## **🍯 Installation d'un HoneyPot**
<span id="honeypot"></span> 

### **1️⃣ Installation de Pentbox**

Pentbox est une boîte à outils de sécurité contenant un module honeypot, c'est la solution que j'ai utilisé pour créer un honeypot, simple, efficace.

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install git perl -y
git clone https://github.com/whitehatpanda/pentbox.git
cd pentbox
```

### **2️⃣ Configuration et Lancement**

Lancer le honeypot avec Pentbox :

```bash
cd pentbox
chmod +x pentbox.rb
./pentbox.rb
```

- Sélectionner Honeypot dans le menu principal

- Configurer le port d’écoute (ex: `80` ou `22` pour SSH)

- Lancer la surveillance des connexions

**Les logs des tentatives d'intrusion seront enregistrés dans le dossier de Pentbox.**
