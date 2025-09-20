create view detail_tranche_26_40 as
with select_tranche as(select case when age between 15 and 25 then '15-25ans'
when age between 26 and 40 then '26-40ans'
when age between 41 and 60 then '41-60ans'
else '60+ans' end as tranche from client)
select distinct cat.nom,count(distinct cat.nom) nombre_categorie, cli.sexe,s.tranche, sum(a.quantite_achat) somme_quantite,sum(p.prix*a.quantite_achat) revenu_generer
from select_tranche s,client cli,categorie cat,achat a,produit p
where a.id_produit=p.id  and a.id_client=cli.id and cat.id=p.id_categorie
and s.tranche='26-40ans'
group by cat.nom,cli.sexe,s.tranche

select * from detail_tranche_26_40
select * from stock_restant
select sum(stock_initial),p.nom_produit
from categorie cat,produit p
where cat.id=p.id_categorie and cat.nom='fruit'
group by p.nom_produit
select sum(stock_initial),p.nom_produit
from categorie cat,produit p
where cat.id=p.id_categorie and cat.nom='maquillage'
group by p.nom_produit

CREATE VIEW produit_non_vendu AS
SELECT p.nom_produit, p.stock_initial
FROM produit p
LEFT JOIN achat a ON p.id = a.id_produit
WHERE a.id_produit IS NULL;



select * from produit_non_vendu