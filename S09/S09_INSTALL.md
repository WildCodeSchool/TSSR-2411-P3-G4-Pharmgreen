# PARTENARIAT-ENTREPRISE - SERVEUR BASTION, VOIP & SUPERVISION UNIFIÉE
## 📚 Documentation Guide - Intégration et Supervision

---
## 📑 Sommaire
- [🖥️ Serveur Bastion](#serveur-bastion)
- [📞 VoIP](#voip)
- [📊 Supervision Unifiée](#supervision-unifiée)
- [⛔ Sécurité d'accès](#sécurité-daccès)
- [📅 Avancée de la semaine](#avance-de-la-semaine)
---

### **🖥️ Serveur Bastion**
<span id="serveur-bastion"></span>

- **Objectif** : Mettre en place un serveur Guacamole sur chaque infrastructure.  
- **Utilisation** :  
  - **Externe-Interne** : Permettre à une personne extérieure au réseau d'accéder aux serveurs de l'entreprise via une plateforme centralisée.
- **Avantages** :  
  - Accès sécurisé aux ressources internes sans nécessiter de VPN dédié.
  - Gestion centralisée des sessions et des accès à distance.
  - Interface web intuitive pour administrateurs et utilisateurs.

#### **Guide d'installation et configuration**
1. **Prérequis** :
   - Serveur dédié ou machine virtuelle pour Guacamole.
   - Accès réseau sécurisé entre l’utilisateur externe et l'infrastructure interne.
   - Configuration DNS et certificats SSL pour sécuriser l'accès.
2. **Installation de Guacamole** :
   - Télécharger et installer Guacamole (serveur et client).
   - Configurer le fichier `guacamole.properties` avec les paramètres d’accès aux serveurs cibles.
3. **Validation** :
   - Tester l'accès via l'interface web de Guacamole.
   - Vérifier les logs pour s'assurer de la bonne gestion des sessions.

---

### **📞 VoIP**
<span id="voip"></span>

- **Objectif** : Mettre en place un serveur de téléphonie sur IP pour faciliter la communication inter-entreprises.  
- **Solutions utilisées** :
  - **FreePBX** : Pour la gestion des lignes VoIP et la configuration initiale. [FreePBX](https://www.freepbx.org/)
  - **3CX** : Pour la validation et l'utilisation de la communication téléphonique entre clients.
- **Avantages** :
  - Centralisation des communications VoIP.
  - Création et gestion aisée des lignes téléphoniques.
  - Intégration de fonctionnalités avancées (messagerie vocale, transfert d'appel, etc.).

#### **Guide d'installation et configuration**
1. **Prérequis** :
   - Serveur ou VM dédiée pour FreePBX.
   - Connexion réseau stable entre les clients VoIP.
   - Matériel compatible (téléphones IP, softphones, etc.).
2. **Installation de FreePBX** :
   - Télécharger l'image ISO ou installer via un paquet sur une distribution Linux.
   - Suivre le guide de configuration initiale et sécuriser l'accès.
3. **Création des lignes VoIP** :
   - Configurer les tronçons SIP et attribuer les numéros aux clients.
   - Paramétrer les règles de routage et les politiques de sécurité.
4. **Validation de la communication** :
   - Tester les appels entre différents clients.
   - Intégrer et tester la solution 3CX pour une gestion complémentaire des communications.

---

### **📊 Supervision Unifiée**
<span id="supervision-unifiée"></span>

- **Objectif** : Créer une plateforme de surveillance partagée entre les deux entreprises pour une supervision globale et centralisée.  
- **Technologie utilisée** : Zabbix.
- **Composantes de la supervision** :
  - **Supervision Globale** : Vue d'ensemble de l'infrastructure des deux entreprises.
  - **Surveillance Matérielle** : Monitoring complet des serveurs virtuels.
  - **Monitoring Réseau** : Suivi des équipements réseau et des communications inter-entreprises.
  - **Surveillance des Services** : Suivi en temps réel des applications et services critiques.
  - **Alertes Centralisées** : Notification immédiate des incidents pour les équipes techniques.

#### **Guide d'installation et configuration**
1. **Prérequis** :
   - Serveur dédié ou VM pour installer Zabbix.
   - Agents installés sur les serveurs et équipements réseau à surveiller.
   - Accès réseau entre les deux entreprises pour une surveillance partagée.
2. **Installation de Zabbix** :
   - Installer Zabbix Server, Frontend et les Agents sur les cibles à surveiller.
   - Configurer le serveur Zabbix et importer les templates adaptés.
3. **Configuration de la surveillance** :
   - Paramétrer des dashboards personnalisés pour chaque domaine (serveurs, réseau, services).
   - Définir des seuils et des alertes pour une réaction rapide aux incidents.
4. **Validation** :
   - Vérifier que les données de surveillance sont correctement collectées et affichées.
   - Tester la fonctionnalité d’alerte et la réception de notifications par les équipes.

---

### **⛔ Sécurité d'accès**
<span id="sécurité-daccès"></span>

- **Accès contrôlé** :
  - Limiter l'accès aux interfaces de gestion (Guacamole, FreePBX, Zabbix) aux utilisateurs autorisés.
  - Utilisation de certificats SSL et de VPN si nécessaire pour sécuriser les connexions.
- **Gestion des permissions** :
  - Attribution de rôles et de permissions spécifiques pour chaque utilisateur.
  - Surveillance et audit régulier des accès et des configurations.
- **Maintenance et mise à jour** :
  - Appliquer régulièrement les mises à jour de sécurité.
  - Réviser les politiques d'accès en fonction des retours des audits.

---

### **📅 Avance de la semaine**
<span id="avance-de-la-semaine"></span>

- **Semaine en cours** :
  - Installation initiale et configuration de Guacamole sur les deux infrastructures.
  - Déploiement du serveur FreePBX et création des premières lignes VoIP.
  - Mise en place de Zabbix pour la surveillance des équipements critiques.
  - Tests fonctionnels en cours sur les trois solutions pour valider la communication et la sécurité.

---

### **🚧 Problèmes rencontrés**
<span id="problèmes-rencontrés"></span>

Durant la mise en œuvre de cette infrastructure, plusieurs problèmes ont été identifiés et résolus :

- **Problème de passerelle pour Zabbix**  
  Une configuration incorrecte de la passerelle réseau empêchait la collecte des données de certains équipements via Zabbix. Après vérification, la passerelle a été correctement reconfigurée pour permettre la communication entre les agents Zabbix et le serveur central.


---
