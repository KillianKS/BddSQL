INSERT INTO Utilisateur (nom, prenom, email, mot_de_passe, adresse, telephone, role)
VALUES 
('Dupont', 'Jean', 'jean.dupont@mail.com', SHA2('mdp123', 256), '123 rue de Paris, 75000 Paris', '0123456789'),
('Martin', 'Alice', 'alice.martin@mail.com', SHA2('mdp456', 256), '456 rue de Lyon, 69000 Lyon', '0987654321'),
('Admin', 'Admin', 'admin@mail.com', SHA2('adminpass', 256), '789 rue de Bordeaux, 33000 Bordeaux', '0112233445');



INSERT INTO Categorie (nom, description)
VALUES 
('Vêtements', 'Vêtements pour homme et femme'),
('Électronique', 'Gadgets, téléphones et accessoires'),
('Maison', 'Décoration et accessoires pour la maison');


INSERT INTO Produit (nom, description, prix, quantite_disponible, categorie_id)
VALUES 
('T-shirt Homme', 'T-shirt en coton', 19.99, 100, 1),
('Smartphone', 'Smartphone dernière génération', 499.99, 50, 2),
('Lampe de table', 'Lampe LED pour bureau', 29.99, 200, 3);


INSERT INTO Commande (date_commande, statut, id_utilisateur, produit_ids, quantites, prix_totals)
VALUES 
(NOW(), 'en attente', 1, '1,2', '2,1', '39.98,499.99'),
(NOW(), 'expédiée', 2, '2,3', '1,2', '499.99,59.98');


INSERT INTO Panier (id_utilisateur, total)
VALUES 
(1, 69.98),
(2, 559.97);


INSERT INTO Avis (id_utilisateur, id_produit, note, commentaire, date)
VALUES 
(1, 1, 5, 'Excellent produit, très confortable !', NOW()),
(2, 2, 4, 'Bon téléphone, pas cher.', NOW());


INSERT INTO Paiement (id_commande, mode_paiement, montant, date_paiement)
VALUES 
(1, 'carte', 69.98, NOW()),
(2, 'PayPal', 559.97, NOW());


SELECT c.id_commande, c.date_commande, c.statut, 
       SUM(CASE WHEN FIND_IN_SET(p.id_produit, c.produit_ids) > 0 THEN 
                CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(c.prix_totals, ',', FIND_IN_SET(p.id_produit, c.produit_ids)), ',', -1) AS DECIMAL(10,2)) 
                ELSE 0 END) AS total_commande
FROM Commande c
JOIN Produit p ON FIND_IN_SET(p.id_produit, c.produit_ids) > 0
WHERE c.id_utilisateur = 1
GROUP BY c.id_commande;


SELECT p.nom, AVG(a.note) AS moyenne_notes
FROM Produit p
JOIN Avis a ON p.id_produit = a.id_produit
GROUP BY p.id_produit;


SELECT u.nom, u.prenom, c.id_commande, p.nom AS produit, 
       CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(c.quantites, ',', FIND_IN_SET(p.id_produit, c.produit_ids)), ',', -1) AS INT) AS quantite,
       CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(c.prix_totals, ',', FIND_IN_SET(p.id_produit, c.produit_ids)), ',', -1) AS DECIMAL(10, 2)) AS prix_total
FROM Utilisateur u
JOIN Commande c ON u.id_utilisateur = c.id_utilisateur
JOIN Produit p ON FIND_IN_SET(p.id_produit, c.produit_ids) > 0;

