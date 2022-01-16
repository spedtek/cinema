CREATE DATABASE THEATER


CREATE TABLE Cinéma (
    Id_Cinéma INT (10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Ville VARCHAR (200) NOT NULL,
    Code_postal VARCHAR(5) NOT NULL,
    Nombre_salles INT NULL check (Nombre_salles BETWEEN 10 AND 49 )
)engine=INNODB;

INSERT INTO Cinéma (Id_Cinéma, Nom, Ville, Code_postal, Nombre_salles)
VALUES 
	(1, 'Pathé Charpennes', 'Villeurbanne', 69100, 19), 
	(2, 'UGC Bron', 'Bron', 69500, 21), 
	(3, 'Pathé Part Dieu', 'Lyon', 69003, 40), 
	(4, 'Ciné-Cité Carré de Soie', 'Vaulx en Velin', 69120, 34);

CREATE TABLE Salles (
    Id_Salle INT (10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Date_séance DATE NOT NULL,
    Capacité INT NOT NULL,
    Id_Cinéma INT (10) NOT NULL,
  	FOREIGN KEY (Id_Cinéma) REFERENCES Cinéma (Id_Cinéma)
)engine=INNODB;

insert into Salles (Id_Salle, Date_séance, Capacité, Id_Cinéma) 
values 
	(1, DATE '2021/01/28', 50, '1'),
	(2, DATE '2021/01/31', 50, '3'),
	(3, DATE '2021/01/30', 50, '2'),
	(4, DATE '2021/01/29', 50, '3'),
	(5, DATE '2021/01/30', 50,'4');


CREATE TABLE Film (
    Id_film INT (10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(100) NOT NULL,
    Date_Sortie DATE NULL,
    Id_Salle INT (10) NOT NULL,
  	Id_Client INT (10) NOT NULL REFERENCES Clients (Id_Client),
    FOREIGN KEY (Id_Salle) REFERENCES Salles (Id_Salle)
)engine=INNODB; 

insert into Film (Id_film, Nom, Date_Sortie, Id_Salle, Id_Client) 
values 
	(1, 'Spider Man', DATE '2021/01/20', '1', '4'),
	(2, '355', DATE '2021/01/21', '2', '1'),
	(3, 'Tous en Scène 2', DATE '2021/01/20', '4', '3'),
	(4, 'Les Tuches 4', DATE '2021/01/19', '3', '2');

CREATE TABLE Clients (
    Id_Client INT (10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Prénom VARCHAR(50) NOT NULL,
    Ville VARCHAR(250) NOT NULL,
    Code_postal VARCHAR(5) NOT NULL,
  	Date_naissance DATE,
  	Age INT (99),
  	Etudiant VARCHAR(3) not null default 'Non',
  	Paiement VARCHAR(20) NULL default 'Sur place',
    Id_tarif INT (10) NOT NULL REFERENCES Tarif (Id_tarif),
    Id_Salle INT (10) NOT NULL,
	FOREIGN KEY (Id_Salle) REFERENCES Salles (Id_Salle)
)engine=INNODB;

insert into Clients (Id_Client, Nom, Prénom, Ville, Code_postal, Date_naissance, Age, Etudiant, Id_tarif, id_Salle) 
values 
	(1, 'Charmane', 'Fader', 'Lyon', 69007, DATE '2010/01/02', 11, 'non', 1, 4),
    (2, 'Robb', 'Rubinshtein', 'Villeurbanne', 69100, DATE '1991/05/12', 30, 'non', 1, 2),
	(3, 'Nikoletta', 'Janusz', 'Villeurbanne', 69100,  DATE '1987/09/20', 34, 'non', 1, 3),
	(4, 'Raven', 'Hopkyns', 'Lyon', 69003, DATE '2000/10/02', 21, 'oui', 2, 1),
	(5, 'Rollo', 'Cawkill', 'Miribel', 38200, DATE '2015/12/10', 6, 'non', 3, 5),
	(6, 'Hildy', 'Jobbins', 'Lyon', 69001, DATE '2003/11/03', 19, 'oui', 2, 2);

UPDATE Clients
SET Id_tarif = 3
WHERE Age < 14 ;


CREATE TABLE Tarif (
    Id_tarif INT (10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Prix DECIMAL (5,2) NOT NULL, 
  	Description VARCHAR(50) NOT NULL
)engine=INNODB;

insert into Tarif (Id_tarif, Prix, Description) 
values
	(1, 9.20, 'Plein tarif'),
    (2, 7.60, 'Tarif étudiant'),
	(3, 5.90, 'Moins de 14ans');

CREATE TABLE Personnel (
    Id_personnel INT (10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Prénom VARCHAR(50) NOT NULL,
  	Mot_de_passe VARCHAR(250) NULL,
  	Option_administrateur VARCHAR(3) NULL default 'NON',
    Id_tarif INT (10) NOT NULL REFERENCES Tarif (Id_tarif),
    Id_Salle INT (10) NOT NULL REFERENCES Salles (Id_Salle),
    Id_Cinéma INT (10) NOT NULL,
    Foreign KEY (Id_Cinéma) REFERENCES Cinéma (Id_Cinéma)
)engine=INNODB;

insert into Personnel (Id_personnel, Nom, Prénom, Mot_de_passe, Id_tarif, Id_Salle, Id_Cinéma) 
values 
	(1, 'Ari', 'Grice', '$2y$10$1RVvl4Mq7qpA4RV6YGxVTOLru8JV.CCNSOrwS0QMM9ReOqJtV3NsK', 5, 1, 1),
	(2, 'Elbertina', 'Harriday', '$2y$10$QZjidLyjO2ZAJvNa76KL4elRNoHk.2Sz.eiQeszOJQLwdg3wsyZp', 5, 1, 1),
	(3, 'Dare', 'Strathe', '$2y$10$KYbpykzFnsBz5KZFDgbvoeYUtc9rfXwE75JnnYzktKwaAzhjDUd/.', 3, 4, 4),
	(4, 'Klemens', 'Rapsey', '$2y$10$vTnJhJFqWcqZoLCYuvQBsOJdZFPfWhd5uEpPpQm6xHdkLDeo2rQuO', 3, 2, 4),
	(5, 'Borden', 'Diggin', '$2y$10$dAJ2lhEUCIjBjAP4sQlF/uvHDY./FAfcw/DZSy226Gql8en.cvyOa', 1, 5, 1),
	(6, 'Christin', 'Tipper', '$2y$10$QIs27SQx08U3nZm1zpXTFu8BB1TcwGfoDAExF6sM14CcL1PO05Xe.', 5, 1, 1),
	(7, 'Pieter', 'Growcock', '$2y$10$StJbcnrYYyARJZI5/LuCleYVbks7nY4fijRkPP6suWzYNEVL.Ybna', 3, 5, 1),
	(8, 'Austin', 'Heskin', '$2y$10$n81fMO/q9ZtWkkJYCeg4M.g04xJGQ9qhBGcSXs3sZU2rhymgcGEtK', 3, 1, 3);

   
UPDATE Personnel
SET Option_administrateur = 'OUI'  
WHERE Id_Salle = 1 ;
