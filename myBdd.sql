CREATE DATABASE e_commerce;
USE e_commerce;


CREATE TABLE Utilisateur (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL,
    adresse TEXT NOT NULL,
    telephone VARCHAR(15)
);


CREATE TABLE Categorie (
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    description TEXT
);


CREATE TABLE Produit (
    id_produit INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    description TEXT,
    prix DECIMAL(10, 2) NOT NULL,
    quantite_disponible INT NOT NULL,
    categorie_id INT,
    FOREIGN KEY (categorie_id) REFERENCES Categorie(id_categorie)
);


CREATE TABLE Commande (
    id_commande INT AUTO_INCREMENT PRIMARY KEY,
    date_commande DATETIME NOT NULL,
    statut ENUM('en attente', 'expédiée', 'livrée', 'annulée') NOT NULL,
    id_utilisateur INT,
    produit_ids TEXT, 
    quantites TEXT,  
    prix_totals TEXT,  
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
);


CREATE TABLE Panier (
    id_panier INT AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INT,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
);


CREATE TABLE Avis (
    id_avis INT AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INT,
    id_produit INT,
    note INT CHECK (note BETWEEN 1 AND 5),
    commentaire TEXT,
    date DATETIME NOT NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_utilisateur),
    FOREIGN KEY (id_produit) REFERENCES Produit(id_produit)
);

CREATE TABLE Paiement (
    id_paiement INT AUTO_INCREMENT PRIMARY KEY,
    id_commande INT,
    mode_paiement ENUM('carte', 'PayPal', 'virement', 'autre') NOT NULL,
    montant DECIMAL(10, 2) NOT NULL,
    date_paiement DATETIME NOT NULL,
    FOREIGN KEY (id_commande) REFERENCES Commande(id_commande)
);
