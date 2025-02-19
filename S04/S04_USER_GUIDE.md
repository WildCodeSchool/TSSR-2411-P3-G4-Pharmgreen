# TSSR-2411-P3-G4-Pharmgreen
## 📚 Pharmgreen S04_USER_GUIDE.md
---
## 📑 Sommaire
- [⚙️ Refonte infrastructure](#refonte)
- [🌐 PfSense](#pfsense)
- [🍯 HoneyPot](#honeypot)

---

### **⚙️ Refonte infrastructure**
<span id="refonte"></span> 

 Nous avons entièrement restructurer l'infrastructure des machines sur **Proxmox** pour nous permettre d'avoir chaques machines à sa place ainsi que chaques serveurs bien configurées.
> [!NOTE]  
> 🏗️ **Il y aura sûrement d'autres refontes à venir selon l'évolution de nos machines et de notre infrastrucuture !**
---

### **🌐 PfSense**
<span id="pfsense"></span> 

Mise en place d'un **firewall** PfSense qui permet à notre infrastructure réseau d'être **protégée** par celui-ci : 

- **Configuration**
  - Mise en place du WAN, LAN, DMZ.
  - Mise en place de **règles** de pare-feu WAN, LAN, DMZ.

---

### **🍯 HoneyPot**
<span id="honeypot"></span> 

Mise en place d'un serveur Debian configuré en tant qu'HoneyPot permettant à notre infrastructure réseau de ne pas se faire **pénétrer** par quelconques pirates informatiques : 

> [!Warning]  
> Encore à définir !
  
