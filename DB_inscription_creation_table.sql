/* DDL:Commande de declaration des données->creation des tables*/
create table annee_academique(id int identity(1,1) primary key,id_acad as ('acad'+right('000'+cast(id as varchar(10)),4)) persisted,libelle varchar(30) not null);
create table tuteur (id int identity(1,1) primary key,id_tuteur as ('TUT'+right('000'+cast(id as varchar(10)),4)) persisted  ,nom varchar(40) not null,prenom varchar(60) not null,contact varchar(35) not null,profession varchar(80) not null);
create table cycle(id int identity (1,1) primary key,id_cycle as ('CYCLE'+right('000'+cast(id as varchar(10)),4)) persisted ,libelle varchar(30) not null,montant_min decimal(10,2) not null,montant_max decimal(10,2) not null);
create table classe (id int identity(1,1) primary key,id_classe as ('CLS'+right('000'+cast(id as varchar(10)),4)) ,libelle varchar(30) not null,id_cycle int foreign key references cycle);
create table eleves(id int identity(1,1) primary key,id_eleve as ('ELV'+right('000'+cast(id as varchar(10)),4)),nom varchar(30) not null,prenom varchar(40),lieu_naissance varchar(30) not null,date_nais date not null,id_tuteur int not null foreign key references tuteur(id));
create table inscription (id  int identity(1,1) primary key,id_ins as ('INS'+right('000'+cast(id as varchar(10)),4)),date_ins date not null,id_anne int not null foreign key references annee_academique(id),id_eleve int not null foreign key references eleves(id),id_classe int not null foreign key references classe(id),id_cycle int not null foreign key references cycle(id),montant float not null);
CREATE TABLE roles (
    id_role INT PRIMARY KEY IDENTITY(1,1),
    nom_role NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE utilisateurs (
    id_user INT PRIMARY KEY IDENTITY(1,1),
    username NVARCHAR(50) NOT NULL UNIQUE,
    nom NVARCHAR(100) NOT NULL,
    mot_de_passe NVARCHAR(255) NOT NULL,
    id_role INT NOT NULL,
    FOREIGN KEY (id_role) REFERENCES roles(id_role));
alter table annee_academique add constraint c_unique unique(libelle)
alter table tuteur add constraint const_contact unique(contact)
alter table eleves add genre varchar(1) not null;
alter table eleves add constraint chk_genre check (upper(genre)in ('F','M'));
alter table tuteur add constraint validator_contact check (contact like '+24205[0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
or contact like '+24206[0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or contact like '+24204[0-9][0-9][0-9][0-9][0-9][0-9][0-9]');
alter table eleves add id_classe int not null foreign key references classe(id)
alter table eleves drop constraint FK__eleves__id_class__6383C8BA
alter table eleves drop column id_classe
alter table tuteur add statut varchar(35) default 'parent' ;
alter table tuteur alter column statut varchar(35) default 'parent' ;
alter table tuteur add constraint validation_tutteur check (lower(statut) in ('parent','tuteur legal','responsable familiale'))
alter table tuteur drop constraint DF__tuteur__statut__6FE99F9F
alter table tuteur drop column statut
alter table eleves drop constraint FK__eleves__id_tuteu__403A8C7D
alter table eleves drop column id_tuteur
CREATE TABLE statut (
    statut_id INT identity(1,1) PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE eleve_tuteur (
    id INT identity(1,1) primary key,
      id_eleve int,
     id_tuteur int ,
    statut_id INT,
    actif BIT DEFAULT 1
    FOREIGN KEY (id_eleve) REFERENCES eleves(id),
    FOREIGN KEY (id_tuteur) REFERENCES tuteur(id),
    FOREIGN KEY (statut_id) REFERENCES statut(statut_id),
    CONSTRAINT uniq_student_tutor UNIQUE (id_eleve, actif)
);

ALTER TABLE statut 
ALTER COLUMN nom VARCHAR(50) COLLATE Latin1_General_CI_AS;
ALTER TABLE statut 
ADD CONSTRAINT uq_statut_nom UNIQUE (nom);





/* DDL:Commande de declaration des données->creation des procedures*/
INSERT INTO roles (nom_role) VALUES 
('Administrateur'),
('Gestionnaire');

INSERT INTO utilisateurs (username, nom, mot_de_passe, id_role) VALUES
('admin2', 'Alice Mbemba', 'motdepasseadmin2', 1),
('admin3', 'Yves Lemba', 'motdepasseadmin3', 1);

-- Utilisateurs Gestionnaires
INSERT INTO utilisateurs (username, nom, mot_de_passe, id_role) VALUES
('gest2', 'Pauline Kanza', 'motdepassegest2', 2),
('gest3', 'David Tamba', 'motdepassegest3', 2),
('gest4', 'Sarah Mayoko', 'motdepassegest4', 2);










/*table:classe*/
create procedure
sp_ajout_classe
      @libelle varchar(30),
	  @id_cycle int
As
begin
  begin try
    insert into classe(libelle,id_cycle) values (@libelle,@id_cycle)
	print('classe ajouté avec succès')
  end try
  begin catch
     print('erreur lors de l''ajout de la claase'+ERROR_MESSAGE())

  end catch
end

/*table:année_academique*/
create PROCEDURE
sp_ajout_anne_academique
                @nom varchar(30)
				
As
begin 
  begin try
    insert annee_academique(libelle) values(@nom);
	print('annee academique ajouté avec succès');
  end try
  begin catch 
    print('erreur  lors de l''ajout de l''année academique:'+ERROR_MESSAGE());
  end catch
end;

/*table:cycle*/

create PROCEDURE
sp_ajout_cycle
                @nom varchar(30),
				@montant_min decimal(10,2),
				@montant_max decimal(10,2)
As
begin 
  begin try
    insert into cycle(libelle,montant_min,montant_max) values(@nom,@montant_min,@montant_max);
	print('cycle ajouté avec succès');
  end try
  begin catch 
    print('erreur  lors de l''ajout cycle:'+ERROR_MESSAGE());
  end catch
end;
/*tuteur*/
create procedure
sp_ajout_tuteur
       @nom varchar(30),
	   @prenom varchar(50),
	   @contact varchar(20),
	   @profession varchar(50)
as
begin
  begin try
    insert into tuteur(nom,prenom,contact,profession)values(@nom,@prenom,@contact,@profession)
	print('Le tuteur a été ajouté avec succès')
  end try
  begin catch 
    print('erreur  lors de l''ajout du tuteur:'+ERROR_MESSAGE());
  end catch
end;
/*eleve*/
create procedure 
sp_ajout_eleve 
  @nom varchar(30),
  @prenom varchar(40),
  @lieu_naissance varchar(25),
  @date_nais date,
  @genre varchar(1)
as
begin
  begin try
    insert into eleves (nom,prenom,lieu_naissance,date_nais,genre) values(@nom,@prenom,@lieu_naissance,@date_nais,@genre)
	print'l''enregistrement de l''eleve'+@nom+' '+@prenom+'s''est effectué avec succès'
  end try
  begin catch
    print('Erreur lors de l''ajout de l''eleve:'+ERROR_MESSAGE())
  end catch
end  
/*status*/
CREATE PROCEDURE sp_ajout_status 
    @nom VARCHAR(50)
AS
BEGIN
    BEGIN TRY

        INSERT INTO statut (nom) VALUES (@nom);

        PRINT 'Le statut ' + @nom + ' a été ajouté avec succès';
    END TRY
    BEGIN CATCH
        -- Récupération de l'erreur et affichage
        PRINT 'Erreur lors de l''ajout du statut '+@nom+':'+ERROR_MESSAGE()
    END CATCH
END;
/*Creation des procedures*/
create procedure sp_ajout_statut
                  @id_eleve int,
				  @id_tuteur int,
				  @statut_id int
As
Begin 
   begin try
      insert into eleve_tuteur(id_eleve,id_tuteur,statut_id) values(@id_eleve,@id_tuteur,@statut_id)
	  print ('l''enregistrement a été fait avec succès' )


     

exec sp_ajout_status 'parent'
exec sp_ajout_status 'tuteur legal'
exec sp_ajout_status 'Responsable familiale'


/*Appel des procedures:->table cycle*/
exec sp_ajout_cycle 'primaire',2000,6000
exec sp_ajout_cycle 'collège',3000,6000

/*Appel des procedures:->table annee_academique*/
exec sp_ajout_anne_academique '2024-2025'

/*Appel des procedures:->table tuteur*/

exec sp_ajout_tuteur 'Arthur','KAZA','+242068745205','Data scientiste'
exec sp_ajout_tuteur 'François','LeBlanc','+242064200336','Enseignant';
exec sp_ajout_tuteur 'Keren','Paris','+242068745205','Docteur en psychanalyse';
exec sp_ajout_tuteur 'ZARA','willa','+242048745205','Docteur en entreprise';
exec sp_ajout_tuteur 'KIZUA','Magnifique','+242068745205','Menuisier';
exec sp_ajout_tuteur 'KAMPA','Glen','+242058745205','UI designer';
exec sp_ajout_tuteur 'Cesarine','Ozuié','+242065745205','Marchande';
exec sp_ajout_tuteur 'DZON','KAZA','+242068744205','Homme d''affaire';
exec sp_ajout_tuteur 'MEZUI','adonai','+242048245205','chantre';
exec sp_ajout_tuteur 'BOUBATH','Anna','+242068145205','Developpeuse';
exec sp_ajout_tuteur 'LEPRES','William','+242066745205','createur de contenu';
exec sp_ajout_tuteur 'HAMPOUALA','Elohim','+242058745205','Technicien';

/*execution de la procedure->classe*/
exec sp_ajout_classe 'P1',2;
exec sp_ajout_classe 'P2',2;
exec sp_ajout_classe 'P3',2;
exec sp_ajout_classe 'cours preparatoire niveau1(CP1)',1;
exec sp_ajout_classe 'cours preparatoire niveau2(CP2)',1;
exec sp_ajout_classe 'cours elementaire niveau1(CE1)',1;
exec sp_ajout_classe 'cours elementaire niveau2(CE2)',1;
exec sp_ajout_classe 'cours manuel niveau1(CM1)',1;
exec sp_ajout_classe 'cours manuel niveau2(CM2)',1;
exec sp_ajout_classe '6e',3;
exec sp_ajout_classe '5e',3;
exec sp_ajout_classe '4e',3;
exec sp_ajout_classe '3e',3
/**/

exec sp_ajout_eleve'KAMPA','ARMELLE','brazzaville','2015-08-13','M'
exec sp_ajout_eleve 'BOUBATH', 'Melody', 'Dolisie', '2012-03-05', 'F';
exec sp_ajout_eleve 'ZARA', 'Jordan', 'Brazzaville', '2011-07-09', 'M';
exec sp_ajout_eleve 'DZON', 'Isaac', 'Ouesso', '2009-12-25', 'M';
exec sp_ajout_eleve 'KAMPA', 'Junior', 'Brazzaville', '2013-02-14', 'M';
exec sp_ajout_eleve 'Ozuié', 'Estelle', 'Pointe-Noire', '2011-08-17', 'F';
exec sp_ajout_eleve 'KAZA', 'Alain', 'Brazzaville', '2008-09-03', 'M';
exec sp_ajout_eleve 'Adonai', 'Eloise', 'Dolisie', '2010-06-21', 'F';
exec sp_ajout_eleve 'MEZUI', 'Matthieu', 'Ouesso', '2012-01-10', 'M';
exec sp_ajout_eleve 'LeBlanc', 'Julien', 'Pointe-Noire', '2008-11-19', 'M';
exec sp_ajout_eleve 'NGOMA', 'Rachelle', 'Sibiti', '2010-10-20', 'F';
exec sp_ajout_eleve 'NDOLO', 'Gregory', 'Madingou', '2009-03-11', 'M';
exec sp_ajout_eleve 'MBA', 'Claire', 'Brazzaville', '2015-07-06', 'F';
exec sp_ajout_eleve 'LOUKAKA', 'Yves', 'Dolisie', '2012-11-02', 'M';
exec sp_ajout_eleve 'KIMBEMBE', 'Prisca', 'Ouesso', '2011-12-12', 'F';
exec sp_ajout_eleve 'KOUMBA', 'Adrien', 'Pointe-Noire', '2008-02-22', 'M';
exec sp_ajout_eleve 'NGAZA', 'Théophile', 'Brazzaville', '2007-08-18', 'M';
exec sp_ajout_eleve 'BOULI', 'Agnès', 'Sibiti', '2009-05-27', 'F';

exec add_or_replace_tutor 11,22,1,'ajout'


/*DDL:creation des vues*/
create view repartition_classe as( 
select c.libelle,cy.libelle as nom_cycle from classe c,cycle cy where c.id_cycle=cy.id group by cy.libelle ,c.libelle)

create view metrique_nb_classe_cycle as
select cy.libelle,count(cy.libelle) nb_classe from classe c,cycle cy where c.id_cycle=cy.id group by cy.libelle

create view repartition_tuteur_eleves as select t.nom+' '+t.prenom as 'nom complet tuteur',e.nom+' '+e.prenom nom_complet_eleve from tuteur t,eleves e where e.id_tuteur=t.id group by t.nom+' '+t.prenom,e.nom+' '+e.prenom

/*DML:langage de manipulation des données*/
update classe set id_cycle=2 where id between 4 and 9
update classe set id_cycle=1 where id between 1 and 3
select * from classe
select * from tuteur
select * from cycle
select * from repartition_classe
select * from eleves;
select * from tuteur;
select * from eleve_tuteur
select * from statut;
select * from metrique_nb_classe_cycle
select *from repartition_tuteur_eleves
select * from annee_academique
select * from cycle
delete from annee_academique where id=2
delete from eleve_tuteur
select * from inscription

exec sp_help eleves
exec sp_help tuteur
exec sp_help classe
exec sp_help inscription
exec sp_help statut
exec sp_help eleve_tuteur
exec sp_help cycle


SELECT e.id, e.nom, e.prenom, e.date_nais, e.genre, 
                   cla.libelle, c.libelle, a.libelle,
                   t.nom AS nom_tuteur, t.contact
            FROM eleves e
            JOIN inscription i ON e.id = i.id_eleve
            join classe cla on i.id_classe=cla.id
            join cycle c on i.id_cycle=c.id
            join annee_academique a on a.id=i.id_anne
            JOIN eleve_tuteur et ON e.id = et.id_eleve
            JOIN tuteur t ON et.id_tuteur = t.id