# Projet DBA - Magasin

Ce projet implémente une base de données SQL pour la gestion d'un magasin. Il comprend des tables pour les produits, les catégories, les clients et les achats. Plusieurs vues et fonctions sont fournies pour analyser les données de vente.

Le notebook `script.ipynb` contient toutes les instructions SQL nécessaires pour créer la structure de la base de données, les tables, les vues et les fonctions.

## Schéma de la Base de Données

La base de données est constituée des tables suivantes :

### `categorie`
- Objectif : Stocke les catégories de produits.
- Colonnes :
    - `id` (INT, Clé Primaire) : ID de la catégorie.
    - `nom` (VARCHAR(50)) : Nom de la catégorie.

### `produit`
- Objectif : Stocke les informations sur les produits.
- Colonnes :
    - `id` (INT, Clé Primaire) : ID du produit.
    - `id_categorie` (INT, Clé Étrangère) : ID de la catégorie à laquelle le produit appartient.
    - `nom_produit` (VARCHAR(90)) : Nom du produit.
    - `prix` (INT) : Prix du produit.
    - `stock_initial` (INT) : Quantité initiale en stock.

### `client`
- Objectif : Stocke les informations sur les clients.
- Colonnes :
    - `id` (INT, Clé Primaire) : ID du client.
    - `nom_client` (VARCHAR(50)) : Nom du client.
    - `age` (INT) : Âge du client.
    - `sexe` (VARCHAR(1)) : Sexe du client (H/F).

### `achat`
- Objectif : Stocke les informations sur les achats.
- Colonnes :
    - `id` (INT, Clé Primaire) : ID de l'achat.
    - `id_produit` (INT, Clé Étrangère) : ID du produit acheté.
    - `id_client` (INT, Clé Étrangère) : ID du client ayant effectué l'achat.
    - `quantite_achat` (INT) : Quantité du produit acheté.
    - `date_achat` (DATE) : Date de l'achat.

## Vues

La base de données comprend plusieurs vues pour l'analyse des données :

- **`detail_tranche_26_40`**: Affiche des informations détaillées sur les achats des clients âgés de 26 à 40 ans, y compris les catégories, le sexe, la quantité et les revenus.
- **`produit_non_vendu`**: Liste les produits qui n'ont pas été vendus.
- **`stock_restant2`**: Affiche le stock initial pour chaque catégorie.
- **`vw_top_produits`**: Affiche les 10 produits les plus vendus en termes de revenus et de quantité.
- **`vw_achats_par_mois`**: Affiche les montants totaux des achats par mois.
- **`V_detail_client`**: Fournit une analyse détaillée des clients, y compris le nombre d'achats, la quantité totale, les dépenses totales et les classements par quantité, fidélité et revenus.
- **`repartition_quantité_categorie`**: Affiche la répartition des quantités achetées par catégorie.
- **`affiche_information`**: Affiche des informations combinées sur les clients, les produits, les catégories et les achats.
- **`nb_tranche_age`**: Affiche la somme des quantités achetées et des revenus générés par tranche d'âge des clients.
- **`Top_5_client_revenu`**: Liste les 5 meilleurs clients par revenus (ordre croissant - vérifiez si cela ne devrait pas être décroissant pour "top").
- **`Top_5_meilleur_client_revenu`**: Liste les 5 meilleurs clients par revenus (ordre décroissant).
- **`groupement`**: Regroupe les clients par nombre d'achats et quantité totale, en fournissant des classements pour les deux.
- **`information_vente`**: Affiche les informations de vente groupées par catégorie et nom de produit.
- **`stock_restant`**: Affiche le stock initial, la quantité vendue et le stock restant pour chaque produit et catégorie.
- **`topProduitMensuel`**: Affiche le produit le plus vendu en quantité pour chaque mois.
- **`topProduitMensuelRevenu`**: Affiche le produit le plus vendu en termes de revenus générés pour chaque mois.
- **`RevenuQuantiteJournalier`**: Affiche le nombre d'achats, la quantité totale vendue et les revenus générés par jour de la semaine.
- **`Nb_client_tranche_age`**: Affiche le nombre de clients dans chaque tranche d'âge.
- **`Repartition_revenu_categorie`**: Affiche les revenus générés par catégorie.
- **`Information_Mensuel`**: Fournit des informations mensuelles sur les ventes, y compris les revenus totaux, les revenus moyens, la quantité totale et le nombre de ventes.
- **`detail_information_annuel_mensuel`**: Affiche des détails sur les ventes annuelles et mensuelles, y compris le chiffre d'affaires, la taille moyenne du panier, le nombre d'achats et le nombre de produits distincts vendus.
- **`Revenu_Genre`**: Affiche les revenus générés, la quantité totale et le nombre de produits distincts vendus, groupés par sexe du client et catégorie de produit.

## Fonctions et Procédures Stockées

La base de données comprend les fonctions et procédures stockées suivantes :

### Fonctions

- **`fn_stock_restant(id_produit INT)`**: Retourne le stock restant pour un ID de produit donné.

*(Note : Le notebook `script.ipynb` fourni contient principalement des définitions de schéma et des vues. Si d'autres procédures stockées ou fonctions ne sont pas explicitement listées dans les instructions SQL CREATE du notebook, elles devront être identifiées et documentées séparément.)*

## Comment Utiliser

1.  **Prérequis**: Assurez-vous d'avoir une instance SQL Server en cours d'exécution.
2.  **Création de la Base de Données**:
    *   Ouvrez le notebook `script.ipynb` en utilisant un environnement Jupyter Notebook qui prend en charge les noyaux SQL (ou copiez les instructions SQL dans votre outil de gestion SQL préféré).
    *   Exécutez les cellules SQL du notebook séquentiellement. Cela va :
        *   Créer la base de données `magasin`.
        *   Créer les tables : `categorie`, `produit`, `client` et `achat`.
        *   Créer les vues définies pour l'analyse des données.
        *   Créer la fonction `fn_stock_restant`.
3.  **Peuplement des Données**: Le script crée le schéma mais ne peuple pas les tables avec des données. Vous devrez insérer vos propres données dans les tables pour utiliser efficacement les vues et les fonctions.
4.  **Interrogation**: Une fois la base de données configurée et peuplée, vous pouvez interroger les tables et les vues en utilisant des instructions SQL standard.
5.  ## Fichiers Complémentaires

Ce projet inclut également les répertoires et fichiers suivants pour aider à sa compréhension et à son utilisation :

-   **`image/`**: Ce répertoire contient des captures d'écran illustrant :
    -   La connexion à la base de données SQL Server en utilisant PowerShell.
    -   La configuration de la connexion entre SQL Server et Power BI.
    -   Des exemples de visualisations et de tableaux de bord créés avec Power BI.
-   **`rapport/Interactivité_sql_server.pdf`**: Un document PDF qui détaille potentiellement l'analyse des données, les interactions avec la base de données ou les conclusions du projet.
-   **`visualisation/Interactivité_sql_server.pbix`**: Le fichier source Power BI (`.pbix`) utilisé pour créer les visualisations et les tableaux de bord interactifs basés sur les données du magasin. Vous pouvez l'ouvrir avec Power BI Desktop pour explorer les données ou modifier les rapports.

