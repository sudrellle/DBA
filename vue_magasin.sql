select * from client
select * from produit_non_vendu
select * from stock_restant
CREATE VIEW repartition_categorie AS
SELECT 
    c.nom ,
    p.nom_produit,
    p.prix,
    p.stock_initial stock_initial,
    COALESCE(p.stock_initial - SUM(a.quantite_achat), p.stock_initial) AS stock_restant
FROM 
    produit p
JOIN 
    categorie c ON p.id_categorie = c.id
LEFT JOIN 
    achat a ON a.id_produit = p.id
GROUP BY 
    c.nom, p.nom_produit, p.prix, p.stock_initial;

select * from achat;

select count(*) from client;
select * from stock_restant
select sum(quantite_achat) from achat
select * from V_detail_client

select * from dbo.Top_5_client_revenu

select * from dbo.Top_5_meilleur_client_revenu