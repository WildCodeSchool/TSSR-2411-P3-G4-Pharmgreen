# PARTENARIAT-ENTREPRISE - VPN & STOCKAGE
## 📚 Documentation Guide - PARTENARIAT D'ENTREPRISE

> [!WARNING]  
> Cette documentation est en cours d'élaboration. Certaines informations pourraient être incomplètes ou nécessiter des mises à jour.
---
## 📑 Sommaire
- [🔒 VPN site-à-site](#vpn-site-à-site)
- [📁 Stockage partagé](#stockage-partagé)
- [🛠️ Configuration et Guide](#configuration-et-guide)
- 
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
```
--- 

### **🚧 Problèmes rencontrés**
<span id="problemes-rencontres"></span>

Au cours de la mise en œuvre du VPN site-à-site et de la configuration des dossiers partagés, plusieurs problèmes ont été identifiés et résolus :

- **Utilisation initiale d'OpenVPN au lieu de IPsec**  
  La solution OpenVPN a d'abord été testée pour établir une connexion site-à-site. Cependant, elle ne répondait pas aux exigences de performance et de sécurité souhaitées pour ce partenariat, ce qui a conduit à la décision de migrer vers une solution IPsec sur pfsense.

- **Mauvaise configuration des adresses IP des tunnels IPsec**  
  Les tunnels étaient mal configurés car les bonnes adresses IP n'avaient pas été renseignées. Une vérification et une correction minutieuse des adresses IP sur chaque tunnel ont permis de rétablir la connectivité.









