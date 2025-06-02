# Project DBA - Magasin

This project implements a SQL database for managing a store (magasin). It includes tables for products, categories, customers, and purchases. Several views and functions are provided to analyze sales data.

The `script.ipynb` notebook contains all the SQL statements necessary to create the database structure, tables, views, and functions.

## Database Schema

The database consists of the following tables:

### `categorie`
- Purpose: Stores product categories.
- Columns:
    - `id` (INT, Primary Key): Category ID.
    - `nom` (VARCHAR(50)): Category name.

### `produit`
- Purpose: Stores product information.
- Columns:
    - `id` (INT, Primary Key): Product ID.
    - `id_categorie` (INT, Foreign Key): ID of the category the product belongs to.
    - `nom_produit` (VARCHAR(90)): Product name.
    - `prix` (INT): Product price.
    - `stock_initial` (INT): Initial stock quantity.

### `client`
- Purpose: Stores customer information.
- Columns:
    - `id` (INT, Primary Key): Customer ID.
    - `nom_client` (VARCHAR(50)): Customer name.
    - `age` (INT): Customer age.
    - `sexe` (VARCHAR(1)): Customer gender (M/F).

### `achat`
- Purpose: Stores purchase information.
- Columns:
    - `id` (INT, Primary Key): Purchase ID.
    - `id_produit` (INT, Foreign Key): ID of the product purchased.
    - `id_client` (INT, Foreign Key): ID of the customer who made the purchase.
    - `quantite_achat` (INT): Quantity of the product purchased.
    - `date_achat` (DATE): Date of the purchase.

## Views

The database includes several views for data analysis:

- **`detail_tranche_26_40`**: Shows detailed purchase information for customers aged 26-40, including categories, gender, quantity, and revenue.
- **`produit_non_vendu`**: Lists products that have not been sold.
- **`stock_restant2`**: Displays the remaining stock for each category. (Note: There's also a `stock_restant` view, consider clarifying or merging if they are similar).
- **`vw_top_produits`**: Shows the top 10 best-selling products by revenue and quantity.
- **`vw_achats_par_mois`**: Displays total purchase amounts per month.
- **`V_detail_client`**: Provides detailed customer analysis, including purchase count, total quantity, total spending, and ranks for quantity, loyalty, and revenue.
- **`repartition_quantité_categorie`**: Shows the distribution of purchased quantities per category.
- **`affiche_information`**: Displays combined information about clients, products, categories, and purchases.
- **`nb_tranche_age`**: Shows the sum of quantities purchased and revenue generated per customer age group.
- **`Top_5_client_revenu`**: Lists the top 5 customers by revenue (ascending order - consider if this should be descending for "top").
- **`Top_5_meilleur_client_revenu`**: Lists the top 5 customers by revenue (descending order).
- **`groupement`**: Groups clients by purchase count and total quantity, providing ranks for both.
- **`information_vente`**: Shows sales information grouped by category and product name.
- **`stock_restant`**: Displays initial stock, quantity sold, and remaining stock for each product and category.
- **`topProduitMensuel`**: Shows the top product by quantity sold for each month.
- **`topProduitMensuelRevenu`**: Shows the top product by revenue generated for each month.
- **`RevenuQuantiteJournalier`**: Displays the number of purchases, total quantity sold, and revenue generated per day of the week.
- **`Nb_client_tranche_age`**: Shows the number of clients in each age group.
- **`Repartition_revenu_categorie`**: Displays the revenue generated per category.
- **`Information_Mensuel`**: Provides monthly sales information, including total revenue, average revenue, total quantity, and number of sales.
- **`detail_information_annuel_mensuel`**: Shows annual and monthly sales details, including turnover, average basket size, number of purchases, and distinct products sold.
- **`Revenu_Genre`**: Displays revenue generated, total quantity, and distinct products sold, grouped by customer gender and product category.

## Functions and Stored Procedures

The database includes the following functions and stored procedures:

### Functions

- **`fn_stock_restant(id_produit INT)`**: Returns the remaining stock for a given product ID.

*(Note: The provided script.ipynb primarily contains schema definitions and views. If there are other stored procedures or functions not explicitly listed in the notebook's SQL CREATE statements, they would need to be identified and documented separately.)*

## How to Use

1.  **Prerequisites**: Ensure you have a SQL Server instance running.
2.  **Database Creation**:
    *   Open the `script.ipynb` notebook using a Jupyter Notebook environment that supports SQL kernels (or copy the SQL statements into your preferred SQL management tool).
    *   Execute the SQL cells in the notebook sequentially. This will:
        *   Create the `magasin` database.
        *   Create the tables: `categorie`, `produit`, `client`, and `achat`.
        *   Create the defined views for data analysis.
        *   Create the `fn_stock_restant` function.
3.  **Data Population**: The script creates the schema but does not populate the tables with data. You will need to insert your own data into the tables to use the views and functions effectively.
4.  **Querying**: Once the database is set up and populated, you can query the tables and views using standard SQL statements.