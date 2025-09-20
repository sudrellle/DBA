
create table categorie(id int primary key,nom varchar)
create table produit(id int primary key,id_categorie int foreign key references categorie,nom_produit varchar,prix int,stock_initial int)
create table client(id int primary key,nom_client varchar,age int ,sexe varchar)
create table achat(id int primary key,id_produit int foreign key references produit,id_client int foreign key references client,quantite_achat int,date_achat date)