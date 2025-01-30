# TSSR-2411-P3-G4-Pharmgreen
## 📚 Pharmgreen README

> [!WARNING]  
> Si vous voyez ce message, c'est que la documentation n'est sûrement pas finie et qu'il est possible qu'il y ait des manques d'informations ou autres.
---
## 📑 Sommaire
- [📜 Présentation du Projet](#presentation-projet)
- [👥 Membres du groupe](#membres-du-groupe)
- [🌐 Configuration Réseau](#config-reseau)
- [⚙️ Choix Techniques](#choix-tech)
- [⚠️ Difficultés rencontrées](#difficultés-rencontrées)
- [💡 Solutions trouvées](#solutions)
- [🚀 Améliorations envisageable](#améliorations)
- [🔚 Conclusion](#conclusion)
---
### **📜 Présentation du Projet**
<span id="presentation-projet"></span> 

Le projet **Pharmgreen - Build Your Infra** est un projet dans lequel nous avons été nommés par une société pour nous occuper de leur infrastructure. On nous a mis à disposition des informations, avec lesquelles nous avons dû construire une infrastructure depuis zéro. Nous avons dû faire face aux besoins de la société et avons mis en place des objectifs pour chaque sprint.

Pour résumer, Notre rôle est de mettre en place une infrastructure de A à Z, de répondre aux besoins de l’entreprise et d’assurer la sécurité des systèmes.

---
### **👥 Membres du groupe**
<span id="membres-du-groupe"></span> 
| Prénom    | Rôles
| --------- | --------- |
| Alexandre | Scrum Master, Technicien
| Balt      | Product Owner, Technicien
| Ismail    | Technicien
| Tom       | Technicien

---
### **🌐 Configuration Réseau**
<span id="config-reseau"></span> 
| Client Proxmox                 | Adresses IP                  | Rôles
| -------------------------------| ---------------------------- |-----------------------
| G4-Windows-Server              | 192.168.10.10                | AD Domaine, DNS, DHCP, Serveur de fichier
| G4-Windows-Server-Core         | 192.168.10.20                | xxx


---
### **⚙️ Choix Techniques**
<span id="choix-tech"></span> 
### OS, Versions, etc.

- **Serveurs** :
  - **Windows Server 2022** : `G4-Windows-Server`
  - **Windows Server 2022 (CORE)** : A définir.
  
- **Client** :
  - **Windows 10**

> [!NOTE]  
> Toutes nos machines sont hypervisées via **Proxmox** et configurées sur celui-ci.
---
