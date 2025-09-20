create view RevenuQuantiteJournalier as
select DATENAME(DW,a.date_achat) AS jour_semaine,count(*) AS nb_achats,
sum(a.quantite_achat) SommeQuantiteVendu,sum((p.prix * a.quantite_achat)) AS Revenu_journalier
from achat a,produit p
where a.id_produit = p.id
group by DATENAME(DW,a.date_achat)

select *from RevenuQuantiteJournalier

create view Nb_client_tranche_age as
select case when (client.age between 15 and 25) then '15-25ans' when (client.age between 26 and 40) then '26-40ans'
when (client.age between 41 and 60) then '41-60' else '60+ans' end
AS trange_age,count(*) AS nb_client
from client
group by case when (client.age between 15 and 25) then '15-25ans' when (client.age between 26 and 40) then '26-40ans'
when (client.age between 41 and 60) then '41-60' else '60+ans' end 

select * from Nb_client_tranche_age


create view Repartition_revenu_categorie as
select cat.nom,sum(p.prix*a.quantite_achat) revenu_genere
from produit p,categorie cat,achat a
where p.id=a.id_produit and cat.id=p.id_categorie
group by cat.nom

select * from Repartition_revenu_categorie

create view Information_Mensuel as
select DateName(MONTH,a.date_achat) AS mois,sum((p.prix * a.quantite_achat)) AS Revenu_mensuel,avg((p.prix * a.quantite_achat)) AS Moyenne_revenu,
sum(a.quantite_achat) AS quantité_mensuel,count(a.id) AS nombre_vente
from produit p, achat a, categorie cat where p.id = a.id_produit and cat.Id = p.id_categorie
group by DateName(MONTH,a.date_achat)

select * from Information_Mensuel

create view detail_information_annuel_mensuel as
select Datename(YEAR,a.date_achat) AS annee,datename(MONTH,a.date_achat) AS mois,sum((p.prix * a.quantite_achat)) AS chiffre_affaire,
round((sum((p.prix * a.quantite_achat)) / count(a.id)),2) AS panier_moyen,count(a.id) AS nb_achats,count(distinct a.id_produit) AS nb_produit_distinct
from produit p ,achat a where a.id_produit = p.id
group by Datename(YEAR,a.date_achat),datename(MONTH,a.date_achat)

select * from detail_information_annuel_mensuel

create view information_client_15_25 as
with clients_par_tranche_15_25 as (select c.Id AS Id,c.nom_client AS nom_client,c.sexe AS sexe,c.age AS age,
(case when (c.age between 15 and 25) then '15-25ans' when (c.age between 26 and 40) then '26-40ans' when (c.age between 41 and 60) then '41-60ans' else '60+ans' end) AS tranche_age
from client c)
select c.tranche_age AS tranche_age,p.nom_produit AS nom_produit,cat.nom AS nom,sum(a.quantite_achat) AS total_quantité,sum((a.quantite_achat * p.prix)) AS revenu_genere
from (((clients_par_tranche_15_25 c  produit p,categorie cat, achat a
where ((c.Id = a.id_client) and (p.id = a.id_produit) and (cat.Id = p.id_categorie) and (c.tranche_age = '15-25ans'))
group by c.tranche_age,p.nom_produit,cat.nom order by total_quantité desc;

create view Revenu_Genre as
select cli.sexe,sum(p.prix*a.quantite_achat) RevenuGenere,sum(a.quantite_achat) total_quantite,c.nom,count(distinct  p.nom_produit) nb_produit_distinct
from client cli,produit p,achat a,categorie c
where p.id=a.id_produit and cli.id=a.id_client and c.id=p.id_categorie
group by c.nom,cli.sexe

select *from revenu_genre