### **🖥️ Graylog**



## Installation de Graylog sur Debian 🚀

---

### 1️⃣ Préparer la configuration et le système

- **Mettre à jour votre système**

  - Ouvrez un terminal et exécutez la commande suivante pour mettre à jour vos paquets :
    ```bash
    sudo apt-get update && sudo apt-get upgrade -y
    ```

- **Installer les outils nécessaires**

  - Installez `curl`, `lsb-release`, `ca-certificates`, `gnupg2` et `pwgen` :
    ```bash
    sudo apt-get install curl lsb-release ca-certificates gnupg2 pwgen -y
    ```

---

### 2️⃣ Installation de MongoDB

Graylog utilise MongoDB pour stocker ses métadonnées (utilisateurs, dashboards, etc.).

- **Ajouter la clé GPG de MongoDB**

  ```bash
  curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor
  ```

- **Ajouter le dépôt MongoDB**

  ```bash
  echo "deb [signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] http://repo.mongodb.org/apt/debian bullseye/mongodb-org/6.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
  ```

- **Mettre à jour le cache et installer MongoDB**

  ```bash
  sudo apt-get update
  sudo apt-get install -y mongodb-org
  ```

- **(Optionnel) Installer libssl1.1 si nécessaire**

  ```bash
  wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.23_amd64.deb
  sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2.23_amd64.deb
  ```

- **Activer et démarrer MongoDB**

  ```bash
  sudo systemctl daemon-reload
  sudo systemctl enable mongod
  sudo systemctl restart mongod
  ```

---

### 3️⃣ Installation d’OpenSearch

Graylog utilise OpenSearch comme moteur d’indexation pour stocker et rechercher les logs.

- **Ajouter la clé GPG d’OpenSearch**

  ```bash
  curl -o- https://artifacts.opensearch.org/publickeys/opensearch.pgp | sudo gpg --dearmor --batch --yes -o /usr/share/keyrings/opensearch-keyring
  ```

- **Ajouter le dépôt OpenSearch**

  ```bash
  echo "deb [signed-by=/usr/share/keyrings/opensearch-keyring] https://artifacts.opensearch.org/releases/bundle/opensearch/2.x/apt stable main" | sudo tee /etc/apt/sources.list.d/opensearch-2.x.list
  ```

- **Mettre à jour et installer OpenSearch**

  ```bash
  sudo apt-get update
  sudo env OPENSEARCH_INITIAL_ADMIN_PASSWORD=VotreMotDePasseFort apt-get install opensearch
  ```

- **Configurer OpenSearch pour un nœud unique**

  ```bash
  sudo nano /etc/opensearch/opensearch.yml
  ```

  Ajoutez ou modifiez les lignes suivantes :

  ```yaml
  cluster.name: graylog
  node.name: ${HOSTNAME}
  path.data: /var/lib/opensearch
  path.logs: /var/log/opensearch
  discovery.type: single-node
  network.host: 127.0.0.1
  action.auto_create_index: false
  plugins.security.disabled: true
  ```

- **(Optionnel) Ajuster la mémoire via la JVM**

  ```bash
  sudo nano /etc/opensearch/jvm.options
  ```

  Remplacez :

  ```plaintext
  -Xms1g
  -Xmx1g
  ```

  par :

  ```plaintext
  -Xms4g
  -Xmx4g
  ```

- **Redémarrer OpenSearch**

  ```bash
  sudo systemctl daemon-reload
  sudo systemctl enable opensearch
  sudo systemctl restart opensearch
  ```

---

### 4️⃣ Installation de Graylog

- **Ajouter le dépôt Graylog**

  ```bash
  wget https://packages.graylog2.org/repo/packages/graylog-6.1-repository_latest.deb
  sudo dpkg -i graylog-6.1-repository_latest.deb
  sudo apt-get update
  ```

- **Installer Graylog**

  ```bash
  sudo apt-get install graylog-server -y
  ```

- **Configurer Graylog**

  ```bash
  sudo nano /etc/graylog/server/server.conf
  ```

- **Générer une clé secrète**

  ```bash
  pwgen -N 1 -s 96
  ```

  Copiez la valeur générée et remplacez la ligne :

  ```plaintext
  password_secret = VOTRE_CLE_GENEREE
  ```

- **Définir le mot de passe de l’administrateur**

  ```bash
  echo -n "PuitsDeLogs@" | shasum -a 256
  ```

  Copiez le hash obtenu et remplacez la ligne :

  ```plaintext
  root_password_sha2 = VOTRE_HASH_SHA256
  ```

- **Configurer l’interface web et l’accès à OpenSearch**

  ```plaintext
  http_bind_address = 0.0.0.0:9000
  elasticsearch_hosts = http://127.0.0.1:9200
  ```

- **Activer et démarrer Graylog**

  ```bash
  sudo systemctl daemon-reload
  sudo systemctl enable --now graylog-server
  ```

---

### 5️⃣ Vérification et accès

- **Accéder à l’interface web de Graylog**

  ```
  http://<IP_DE_VOTRE_SERVEUR>:9000
  ```

- **Connexion**

  - Utilisez le compte `admin` et le mot de passe défini précédemment.

---

Vous pouvez enregistrer ce guide sous forme de fichier avec l’extension `.md`, par exemple : `installation_graylog.md`.





