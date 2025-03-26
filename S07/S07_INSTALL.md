# TSSR-2411-P3-G4-Pharmgreen
## 📚 Pharmgreen S03_INSTALL.md
---
## 📑 Sommaire
- [🔐 BitWarden](#bitwarden)
- [📧 iRedMail](#redmail)

---
## **🔐 BitWarden**
<span id="bitwarden"></span> 

### **1️⃣ Installation des dépendances**

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y nginx certbot sqlite3 unzip
```

### **2️⃣ Création de l'utilisateur et des répertoires**

```bash
sudo adduser --system --group --home /opt/bitwarden bitwarden
sudo mkdir -p /opt/bitwarden
sudo chown -R bitwarden:bitwarden /opt/bitwarden
```

### **3️⃣ Téléchargement et installation de Bitwarden**

```bash
cd /opt/bitwarden
wget https://github.com/dani-garcia/vaultwarden/releases/latest/download/vaultwarden-linux-amd64.tar.gz
sudo tar -xvzf vaultwarden-linux-amd64.tar.gz
rm vaultwarden-linux-amd64.tar.gz
sudo chown -R bitwarden:bitwarden /opt/bitwarden
```

### **4️⃣ Création du service systemd**

```bash
sudo tee /etc/systemd/system/bitwarden.service <<EOF
[Unit]
Description=Bitwarden (Vaultwarden) Password Manager
After=network.target

[Service]
User=bitwarden
Group=bitwarden
ExecStart=/opt/bitwarden/vaultwarden
Restart=always

[Install]
WantedBy=multi-user.target
EOF
```

### **5️⃣ Démarrage du service**

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now bitwarden
sudo systemctl status bitwarden
```

Votre instance Bitwarden (Vaultwarden) tourne maintenant sur le port 80.

### **6️⃣ Configuration de Nginx et SSL**

```bash
sudo tee /etc/nginx/sites-available/bitwarden <<EOF
server {
    listen 80;
    server_name bitwarden.pharmgreen.com;

    location / {
        proxy_pass http://127.0.0.1:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF
```

```bash
sudo ln -s /etc/nginx/sites-available/bitwarden /etc/nginx/sites-enabled/
sudo systemctl restart nginx
```

### **7️⃣ Activation du SSL avec Let's Encrypt**

```bash
sudo certbot --nginx -d bitwarden.pharmgreen.com
```

Accessible via https://bitwarden.pharmgreen.com

---

## **📧 iRedMail**
<span id="redmail"></span> 

### **1️⃣ Mise à jour et installation des dépendances**

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git unzip
```

### **2️⃣ Téléchargement et exécution du script d'installation**

```bash
cd /root
wget https://github.com/iredmail/iRedMail/archive/refs/tags/1.6.9.tar.gz
mkdir iRedMail && tar xzf 1.6.9.tar.gz -C iRedMail --strip-components=1
cd iRedMail
sudo bash iRedMail.sh
```

### **3️⃣ Configuration de iRedMail**

- Définir le répertoire d'installation

- Sélectionner MariaDB, PostgreSQL ou OpenLDAP pour la gestion des comptes

- Définir le nom de domaine principal

- Spécifier l'adresse e-mail administrateur

- Une fois l'installation terminée, redémarrage du serveur
```bash
sudo reboot
```

### **4️⃣ Accéder à l'interface d'administration**

- **URL :** https://mail.pharmgreen.com/iredadmin



