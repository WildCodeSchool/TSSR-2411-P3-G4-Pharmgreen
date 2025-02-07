# TSSR-2411-P3-G4-Pharmgreen
## 📚 Pharmgreen S03_INSTALL.md
---
## 📑 Sommaire
- [🏛️ GPO](#gpo)
- [🖥️ GLPI](#glpi)
- [⚙️ Script ADDS](#script-adds-core)
- [🌐 Cisco Packet Tracer](#cpt)

---
### **🏛️ GPO**
<span id="gpo"></span> 
## Installation d'une GPO sur Windows Server 2022 🚀

### 1️⃣ Ouvrir la console de gestion des GPO
- **Connectez-vous** à votre contrôleur de domaine sous Windows Server 2022.
- **Lancez** l'outil de gestion des stratégies de groupe :
  - Appuyez sur `Win + R`, tapez `gpmc.msc` et validez avec `Entrée`.

### 2️⃣ Créer une nouvelle GPO
- Dans la console, développez votre domaine (ex. : `votre-domaine.local`).
- Faites un **clic droit** sur **Objets de stratégie de groupe** et sélectionnez **Nouvelle**.
- **Nommez** votre GPO (ex. : `Blocage_Panneau_Configuration`), puis cliquez sur **OK**.

### 3️⃣ Configurer la GPO
- Faites un **clic droit** sur la GPO créée et sélectionnez **Modifier**.
- Dans l’éditeur, choisissez votre chemin en fonction du type de configuration souhaité :
  - **Configuration Ordinateur** : `Configuration Ordinateur → Stratégies → Paramètres Windows → Paramètres de sécurité`
  - **Configuration Utilisateur** : `Configuration Utilisateur → Stratégies → Modèles d'administration`
- **Double-cliquez** sur le paramètre désiré, activez-le et appliquez vos modifications.

### 4️⃣ Lier la GPO à une OU ou au domaine
- Dans la console, faites un **clic droit** sur l'Unité Organisationnelle (OU) ou le domaine ciblé.
- Sélectionnez **Lier un objet de stratégie de groupe existant**.
- Choisissez la GPO créée et cliquez sur **OK**.

### 5️⃣ Appliquer et vérifier la GPO
- Sur un client Windows, ouvrez l’invite de commandes (`Win + R` → `cmd`).
- Exécutez la commande suivante pour forcer l’application des stratégies :
  ```bash
  gpupdate /force


---
### **🖥️ GLPI**
<span id="glpi"></span> 
## Installation de GLPI sur Debian 🚀

### 1️⃣ Préparer la configuration et le système

- **Mettre à jour votre système**
    - Ouvrez un terminal et exécutez la commande suivante pour mettre à jour vos paquets :
        
        ```bash
        sudo apt update && sudo apt upgrade -y
        
        ```
        
- **Créer le fichier de configuration**
    - Dans le même répertoire que le script, créez un fichier nommé `config.txt` contenant les informations de connexion à la base de données. Par exemple :
        
        ```bash
        db_user=glpi_user
        db_pass=glpi_password
        db_name=glpi_db
        
        ```
        
    - **Modifiez** ces valeurs selon vos besoins.

---

### 2️⃣ Rendre le script exécutable

- **Accédez** au répertoire contenant le script.
- Rendez le script exécutable en tapant dans le terminal :
    
    ```bash
    chmod +x install_glpi.sh
    
    ```

### 3️⃣ Exécuter le script d’installation

- **Lancez** le script avec les droits administrateur :
    
    ```bash
    sudo ./install_glpi.sh
    
    ```

### 4️⃣ Que fait le script ?

- **Chargement de la configuration**
    
    Le script importe les variables `db_user`, `db_pass` et `db_name` depuis le fichier `config.txt`.
    
- **Installation des paquets nécessaires**
    - Mise à jour des paquets et installation de PHP (ainsi que ses modules essentiels), Apache2, MariaDB et PHP-ldap.
- **Configuration de MariaDB**
    - Création de la base de données définie dans `config.txt`.
    - Attribution des droits à l’utilisateur pour cette base.
- **Téléchargement et extraction de GLPI**
    - Téléchargement de l’archive de GLPI (version 10.0.15) depuis GitHub.
    - Extraction de l’archive dans le répertoire `/var/www/`.
- **Gestion des permissions et réorganisation des répertoires**
    - Attribution des droits sur le dossier GLPI à l’utilisateur `www-data`.
    - Création des dossiers pour la configuration (`/etc/glpi`), les fichiers (`/var/lib/glpi`) et les logs (`/var/log/glpi`).
    - Déplacement des répertoires `config` et `files` vers leurs nouveaux emplacements.
- **Création des fichiers de configuration PHP**
    - Création de `downstream.php` dans le dossier `inc` de GLPI pour définir le chemin de la configuration.
    - Création de `local_define.php` dans `/etc/glpi` pour préciser les répertoires de fichiers et de logs.
- **Configuration d’Apache**
    - Création d’un fichier de configuration de site (VirtualHost) pour GLPI dans `/etc/apache2/sites-available/`.
    - Activation du site GLPI et désactivation du site par défaut.
    - Activation du module `rewrite` pour rediriger correctement les requêtes.
- **Installation et configuration de PHP-FPM**
    - Installation de PHP-FPM (version 8.2) et configuration des modules Apache nécessaires.
    - Redémarrage des services Apache et PHP-FPM pour appliquer les modifications.

### 5️⃣ Vérifier l’installation

- **Redémarrage des services**
    
    Le script redémarre automatiquement Apache et PHP-FPM pour que toutes les configurations soient prises en compte.
    
- **Accéder à GLPI**
    - Ouvrez votre navigateur et rendez-vous sur l’URL configurée (ex. : [http://pharmgreen.org](http://pharmgreen.org/)) pour finaliser l’installation via l’interface web de GLPI.
---
### **⚙️ Script ADDS**
<span id="script-adds-core"></span>

> [!WARNING]  
> En cours...

---
### **🌐 Cisco Packet Tracer**
<span id="cpt"></span>

## Installation de Cisco Packet Tracer sur Windows 🚀

### 1️⃣ Télécharger l’installateur

- **Accédez** au site de Cisco Networking Academy
    - Rendez-vous sur Cisco Networking Academy pour obtenir la dernière version de Packet Tracer.
- **Connectez-vous**
    - Utilisez vos identifiants (étudiant, enseignant ou autre) pour accéder au téléchargement.
- **Téléchargez**
    - Sélectionnez le fichier d’installation pour Windows (généralement un fichier au format `.exe`) et lancez le téléchargement.

### 2️⃣ Lancer l’installation

- **Localisez** le fichier téléchargé
    - Ouvrez l’Explorateur Windows et rendez-vous dans le dossier de téléchargement.
- **Exécutez l’installateur**
    - Double-cliquez sur le fichier `.exe` pour lancer l’assistant d’installation.
    - Si nécessaire, faites un **clic droit** sur le fichier et sélectionnez **Exécuter en tant qu’administrateur**.

### 3️⃣ Suivre l’assistant d’installation

- **Acceptez** les termes et conditions
    - Lisez les conditions d’utilisation proposées par Cisco et cliquez sur **Accepter** pour continuer.
- **Choisissez le dossier d’installation**
    - Vous pouvez conserver le chemin par défaut ou le modifier selon vos préférences.
- **Poursuivez**
    - Cliquez sur **Suivant** et suivez les instructions à l’écran.
- **Installation**
    - Laissez l’installateur procéder à l’installation. Cela peut prendre quelques minutes.
