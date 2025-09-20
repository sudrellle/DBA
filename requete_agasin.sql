select * from achat
alter table achat drop column id;
EXEC sp_rename 'achat', 'achat_old';
CREATE TABLE achat (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_produit INT,
    id_client INT,
    quantite_achat INT NOT NULL,
    date_achat DATE NOT NULL
)
SET IDENTITY_INSERT achat ON;

INSERT INTO achat (id, id_produit, id_client, quantite_achat, date_achat)
SELECT id, id_produit, id_client, quantite_achat, date_achat
FROM achat_old;

SET IDENTITY_INSERT achat OFF
DROP TABLE achat_old;
ALTER TABLE achat NOCHECK CONSTRAINT ALL;
EXEC sp_rename 'client', 'client_old';
CREATE TABLE client (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nom_client VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    sexe VARCHAR(1) NOT NULL
);

SET IDENTITY_INSERT client ON;

INSERT INTO client (id, nom_client, age, sexe)
SELECT id, nom_client, age, sexe FROM client_old;

SET IDENTITY_INSERT client OFF;
DROP TABLE client_old

EXEC sp_rename 'produit', 'produit_old';
CREATE TABLE produit (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_categorie INT,
    nom_produit VARCHAR(90) NOT NULL,
    prix INT NOT NULL,
    stock_initial INT NOT NULL
);
SET IDENTITY_INSERT produit ON;

INSERT INTO produit (id, id_categorie, nom_produit, prix, stock_initial)
SELECT id, id_categorie, nom_produit, prix, stock_initial FROM produit_old;

SET IDENTITY_INSERT produit OFF;
DROP TABLE produit_old;

EXEC sp_rename 'categorie', 'categorie_old';

CREATE TABLE categorie (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

SET IDENTITY_INSERT categorie ON;

INSERT INTO categorie (id, nom)
SELECT id, nom FROM categorie_old;

SET IDENTITY_INSERT categorie OFF;

DROP TABLE categorie_old
ALTER TABLE achat WITH CHECK CHECK CONSTRAINT ALL;