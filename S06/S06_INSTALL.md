---
### **🖥️ Graylog**
<span id="graylog"></span> 
## Installation de Graylog sur Debian 🚀

### 1️⃣ Préparer la configuration et le système

- **Mettre à jour votre système**
  - Ouvrez un terminal et exécutez la commande suivante pour mettre à jour vos paquets :
    
    ```bash
    sudo apt-get update && sudo apt-get upgrade -y
    ```

- **Installer les outils nécessaires**
  - Installez curl, lsb-release, ca-certificates, gnupg2 et pwgen :
    
    ```bash
    sudo apt-get install curl lsb-release ca-certificates gnupg2 pwgen -y
    ```

---

### 2️⃣ Installation de MongoDB

Graylog utilise MongoDB pour stocker ses métadonnées (utilisateurs, dashboards, etc.).

- **Ajouter la clé GPG de MongoDB**
  
  ```bash
  curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor
Ajouter le dépôt MongoDB

bash
Copier
Modifier
echo "deb [signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] http://repo.mongodb.org/apt/debian bullseye/mongodb-org/6.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
Mettre à jour le cache et installer MongoDB

bash
Copier
Modifier
sudo apt-get update
sudo apt-get install -y mongodb-org
(Optionnel) Installer libssl1.1 si nécessaire

bash
Copier
Modifier
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.23_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2.23_amd64.deb
sudo apt-get install -y mongodb-org
Activer et démarrer MongoDB

bash
Copier
Modifier
sudo systemctl daemon-reload
sudo systemctl enable mongod
sudo systemctl restart mongod
3️⃣ Installation d’OpenSearch
Graylog utilise OpenSearch comme moteur d’indexation pour stocker et rechercher les logs.

Ajouter la clé GPG d’OpenSearch

bash
Copier
Modifier
curl -o- https://artifacts.opensearch.org/publickeys/opensearch.pgp | sudo gpg --dearmor --batch --yes -o /usr/share/keyrings/opensearch-keyring
Ajouter le dépôt OpenSearch

bash
Copier
Modifier
echo "deb [signed-by=/usr/share/keyrings/opensearch-keyring] https://artifacts.opensearch.org/releases/bundle/opensearch/2.x/apt stable main" | sudo tee /etc/apt/sources.list.d/opensearch-2.x.list
Mettre à jour et installer OpenSearch

bash
Copier
Modifier
sudo apt-get update
sudo env OPENSEARCH_INITIAL_ADMIN_PASSWORD=VotreMotDePasseFort apt-get install opensearch
Configurer OpenSearch pour un nœud unique

Ouvrez le fichier de configuration :

bash
Copier
Modifier
sudo nano /etc/opensearch/opensearch.yml
Ajoutez ou modifiez les lignes suivantes :

yaml
Copier
Modifier
cluster.name: graylog
node.name: ${HOSTNAME}
path.data: /var/lib/opensearch
path.logs: /var/log/opensearch
discovery.type: single-node
network.host: 127.0.0.1
action.auto_create_index: false
plugins.security.disabled: true
(Optionnel) Ajuster la mémoire via la JVM

Éditez le fichier /etc/opensearch/jvm.options et remplacez :

plaintext
Copier
Modifier
-Xms1g
-Xmx1g
par

plaintext
Copier
Modifier
-Xms4g
-Xmx4g
Redémarrer OpenSearch

bash
Copier
Modifier
sudo systemctl daemon-reload
sudo systemctl enable opensearch
sudo systemctl restart opensearch
4️⃣ Installation de Graylog
Ajouter le dépôt Graylog

Téléchargez le paquet du dépôt Graylog :

bash
Copier
Modifier
wget https://packages.graylog2.org/repo/packages/graylog-6.1-repository_latest.deb
sudo dpkg -i graylog-6.1-repository_latest.deb
sudo apt-get update
Installer Graylog

bash
Copier
Modifier
sudo apt-get install graylog-server -y
Configurer Graylog

Ouvrez le fichier de configuration :

bash
Copier
Modifier
sudo nano /etc/graylog/server/server.conf
Générer une clé secrète
Utilisez la commande suivante pour générer une chaîne aléatoire (par exemple, 96 caractères) :

bash
Copier
Modifier
pwgen -N 1 -s 96
Copiez la valeur générée et remplacez la ligne :

plaintext
Copier
Modifier
password_secret = VOTRE_CLE_GENEREE
Définir le mot de passe de l’administrateur
Pour définir le mot de passe de l’admin, générez son hash SHA-256. Par exemple, pour le mot de passe PuitsDeLogs@ :

bash
Copier
Modifier
echo -n "PuitsDeLogs@" | shasum -a 256
Copiez le hash obtenu et remplacez la ligne :

plaintext
Copier
Modifier
root_password_sha2 = VOTRE_HASH_SHA256
Configurer l’interface web et l’accès à OpenSearch

Pour que l’interface web soit accessible depuis n’importe quelle IP, modifiez :

plaintext
Copier
Modifier
http_bind_address = 0.0.0.0:9000
Indiquez l’adresse de votre instance OpenSearch :

plaintext
Copier
Modifier
elasticsearch_hosts = http://127.0.0.1:9200
Activer et démarrer Graylog

bash
Copier
Modifier
sudo systemctl daemon-reload
sudo systemctl enable --now graylog-server
5️⃣ Vérification et accès
Accéder à l’interface web de Graylog
Ouvrez votre navigateur et rendez-vous sur :

cpp
Copier
Modifier
http://<IP_DE_VOTRE_SERVEUR>:9000
Connexion
Connectez-vous avec le compte admin et le mot de passe que vous avez configuré.

go
Copier
Modifier

Vous pouvez sauvegarder ce contenu dans un fichier avec l’extension `.md` (par exemple, `installation_graylog.md`).






