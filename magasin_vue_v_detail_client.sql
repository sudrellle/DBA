select * from achat;
select * from produit;
select * from client;
select * from dbo.affiche_information
select * from dbo.repartition_quantité_categorie
select * from dbo.Repartition_revenu_categorie
select * from dbo.nb_tranche_age
select * from dbo.Revenu_Genre
select * from dbo.Nb_client_tranche_age
select * from dbo.information_vente
select * from dbo.stock_restant2
select * from dbo.stock_restant
select * from dbo.produit_non_vendu
select * from  dbo.groupement;
insert into achat (id,id_produit,id_client,quantite_achat,date_achat) values (24,1,4,2,'2025-02-17')
select * from dbo.Top_5_client_revenu
select * from dbo.Top_5_meilleur_client_revenu

CREATE VIEW V_detail_client AS
WITH achats_clients AS (
    SELECT 
        c.nom_client,
        COUNT(a.id_client) AS nombre_achat,
        SUM(a.quantite_achat) AS total_quantite,
        SUM(p.prix * a.quantite_achat) AS total_depense
    FROM achat a
    JOIN client c ON a.id_client = c.id
    JOIN produit p ON a.id_produit = p.id
    GROUP BY c.nom_client
	
)
SELECT 
    nom_client,
    nombre_achat,
    total_quantite,
    total_depense,
    RANK() OVER (ORDER BY total_quantite DESC) AS rang_somme_quantite,
    RANK() OVER (ORDER BY nombre_achat DESC) AS rang_fidelisation,
	RANK () OVER(ORDER BY total_depense DESC) as rang_revenu
FROM achats_clients;


select * from dbo.V_detail_client order by total_depense desc