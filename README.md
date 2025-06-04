# Projet d'Interaction Base de Données : SQL Server, PowerShell & Power BI

Ce projet démontre un flux de travail complet pour la création, la manipulation et la visualisation de données en utilisant SQL Server, PowerShell et Power BI. L'objectif principal est de montrer comment ces outils peuvent interagir pour gérer et analyser des données d'un magasin fictif.

## Aperçu du Projet

Le projet se déroule en plusieurs étapes clés :

1.  **Création de la Base de Données et des Structures de Données** : Mise en place de la base de données `magasin` avec ses tables, vues et fonctions à l'aide de scripts SQL.
2.  **Visualisation des Données avec Power BI** : Connexion de Power BI à la base de données SQL Server pour créer des rapports et des tableaux de bord interactifs.
3.  **Interaction et Manipulation des Données via PowerShell** : Utilisation de PowerShell pour se connecter à SQL Server, insérer ou modifier des données, et observer l'impact de ces changements en temps réel sur la base de données et, par conséquent, sur les visualisations Power BI.

---

## 1. Création de la Base de Données (`magasin`)

La première étape a consisté à définir et à créer la base de données `magasin` sur SQL Server.

-   **Scripts SQL** : Tous les scripts nécessaires (création de la base de données, des tables, des vues analytiques et des fonctions) sont regroupés dans le notebook Jupyter `script/script.ipynb`.
    -   **Tables Principales** :
        -   `categorie` : Contient les catégories de produits.
        -   `produit` : Contient les informations sur les produits (prix, stock, etc.).
        -   `client` : Contient les informations sur les clients.
        -   `achat` : Contient l'historique des achats.
    -   **Vues Analytiques** : De nombreuses vues (par exemple, `vw_top_produits`, `Information_Mensuel`, `Revenu_Genre`, etc.) ont été créées pour faciliter l'analyse des ventes, des clients et des produits.
    -   **Fonctions** : Une fonction `fn_stock_restant` a été créée pour calculer le stock restant d'un produit.

---

## 2. Visualisation des Données avec Power BI

Une fois la base de données structurée, Power BI a été utilisé pour visualiser les données et obtenir des informations exploitables.

-   **Connexion** : Power BI a été connecté directement à la base de données SQL Server `magasin`.
    -   Des exemples de configuration de cette connexion et du schéma relationnel tel qu'il apparaît dans Power BI sont visibles dans les captures d'écran du répertoire `image/connexion_sqlserver_powerbi/`.
-   **Tableaux de Bord et Rapports** :
    -   Des visualisations ont été créées pour analyser les tendances de ventes, le comportement des clients, la performance des produits, etc.
    -   Des exemples de ces visualisations sont disponibles sous forme de captures d'écran dans le répertoire `image/visualisation/`.
    -   Le fichier source complet du tableau de bord Power BI est `visualisation/Interactivité_sql_server.pbix`. Celui-ci peut être ouvert avec Power BI Desktop pour explorer les rapports de manière interactive.

---

## 3. Interaction avec PowerShell

Pour démontrer l'aspect dynamique et l'interaction programmatique avec la base de données, PowerShell a été utilisé.

-   **Connexion PowerShell à SQL Server** : Des scripts PowerShell ont été utilisés pour établir une connexion à l'instance SQL Server hébergeant la base de données `magasin`.
-   **Manipulation de Données** :
    -   PowerShell a permis d'exécuter des requêtes SQL pour, par exemple, insérer de nouvelles données (simulant de nouvelles ventes ou de nouveaux produits) ou mettre à jour des informations existantes.
    -   L'objectif était de montrer comment des actions externes (ici, via PowerShell) peuvent modifier la base de données.
-   **Impact sur Power BI** : Les modifications effectuées via PowerShell sur les données SQL Server sont ensuite reflétées dans les tableaux de bord Power BI lors de leur actualisation, illustrant la connectivité de bout en bout.
-   **Captures d'Écran** : Le processus de connexion et d'interaction avec SQL Server via PowerShell est documenté par des captures d'écran dans le répertoire `image/connexion_powershell_sqlserver/`.

---

## Fichiers Complémentaires

-   **`rapport/Interactivité_sql_server.pdf`**: Ce document PDF fournit probablement une analyse plus approfondie ou un résumé des observations et des interactions réalisées dans le cadre de ce projet.

---

## Comment Reproduire/Utiliser

1.  **Prérequis** :
    -   Une instance SQL Server.
    -   SQL Server Management Studio (SSMS) ou un outil similaire pour exécuter les scripts SQL (ou un noyau SQL pour Jupyter).
    -   Power BI Desktop.
    -   PowerShell.
2.  **Base de Données** : Exécutez les scripts SQL du notebook `script/script.ipynb` pour créer la base de données `magasin`, ses tables, vues et fonctions.
3.  **Peuplement des Données** : Insérez des données initiales dans les tables. (Le notebook `script.ipynb` se concentre sur la création du schéma).
4.  **Power BI** :
    -   Ouvrez `visualisation/Interactivité_sql_server.pbix` avec Power BI Desktop.
    -   Configurez la source de données pour pointer vers votre instance SQL Server et la base de données `magasin`.
    -   Explorez les visualisations.
5.  **PowerShell** :
    -   Adaptez les exemples de scripts PowerShell (non fournis directement dans ce dépôt, mais dont les résultats sont visibles dans `image/connexion_powershell_sqlserver/`) pour vous connecter à votre base de données.
    -   Exécutez des commandes pour interagir avec les données et observez les mises à jour dans SQL Server et Power BI.
