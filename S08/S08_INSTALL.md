# PARTENARIAT-ENTREPRISE - VPN & STOCKAGE
## 📚 Documentation Guide - PARTENARIAT D'ENTREPRISE

> [!WARNING]  
> Cette documentation est en cours d'élaboration. Certaines informations pourraient être incomplètes ou nécessiter des mises à jour.
---
## 📑 Sommaire
- [🔒 VPN site-à-site](#vpn-site-à-site)
- [📁 Stockage partagé](#stockage-partagé)
- [🛠️ Configuration et Guide](#configuration-et-guide)
- [⛔ Sécurité d'accès](#sécurité-daccès)
- [📅 Avancée de la semaine](#avancée-de-la-semaine)
---

### **🔒 VPN site-à-site**
<span id="vpn-site-à-site"></span>

- **Objectif** : Mettre en place un VPN site-à-site entre les deux réseaux d'entreprise pour assurer une communication sécurisée.  
- **Technologie utilisée** : VPN IPsec sur pfsense.  
- **Avantages** :  
  - Communication chiffrée et sécurisée entre les sites.  
  - Connectivité fiable et continue.  
  - Meilleure gestion de la bande passante et des ressources réseau.

#### **Guide de déploiement VPN**
1. **Prérequis** :
   - Deux réseaux d'entreprise distincts.
   - Routeurs pfsense configurés sur chaque site.
   - Adresses IP publiques ou dynamiques pour chaque site.
2. **Configuration de pfsense** :
   - Accéder à l'interface web de pfsense.
   - Naviguer vers **VPN > IPsec** et créer un nouveau tunnel.
   - Configurer la phase 1 avec les paramètres d’authentification et de chiffrement appropriés.
   - Définir la phase 2 en spécifiant les sous-réseaux locaux et distants.
3. **Validation** :
   - Tester la connectivité avec des commandes comme `ping` ou `traceroute`.
   - Vérifier les journaux de pfsense pour s’assurer du bon fonctionnement du tunnel.
  
---

### **📁 Stockage partagé**
<span id="stockage-partagé"></span>

- **Objectif** : Intégrer à la structure de dossiers existante des dossiers partagés accessibles via le VPN site-à-site.  
- **Technologie utilisée** : Partage de dossiers sous Windows avec gestion des permissions.  
- **Avantages** :  
  - Collaboration facilitée entre les utilisateurs des deux entreprises.  
  - Gestion centralisée des ressources de stockage.
  - Possibilité pour les administrateurs de l’autre entreprise d’avoir un accès complet pour la gestion de la sécurité des dossiers.

#### **Mise en place des dossiers partagés**
- **Création et organisation** :
  - Définir une arborescence commune pour les dossiers partagés.
  - Créer les dossiers sur un serveur dédié ou via un NAS accessible via VPN.
- **Configuration des permissions** :
  - Attribuer des droits d’accès via les permissions Windows pour chaque groupe d’utilisateurs.
  - Donner aux administrateurs de l’entreprise partenaire un accès complet (full access) afin de gérer la sécurité des dossiers.
- **Accès via VPN** :
  - S’assurer que l’accès aux dossiers se fait uniquement via le tunnel VPN pour garantir la sécurité des données.

---

### **🛠️ Configuration et Guide**
<span id="configuration-et-guide"></span>

#### **Exemple de configuration pour le VPN (pfsense)**
```bash
# Exemple de configuration de la phase 1 :
- Accéder à l'interface web de pfsense
- Aller dans VPN > IPsec > Ajouter un tunnel
- Paramétrer :
   - Interface : WAN
   - Remote Gateway : [Adresse IP du site distant]
   - Authentification : Mutual PSK
   - Chiffrement : AES 256 (ou selon vos besoins)
