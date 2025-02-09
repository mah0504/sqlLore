-- Supprimer la table 'presences' si elle existe
DROP TABLE IF EXISTS presences;

-- Supprimer la table 'cadeaux' si elle existe
DROP TABLE IF EXISTS cadeaux;
-- Création de la table 'presences'
CREATE TABLE presences (
    nopige INT,
    nom VARCHAR(50)
);

-- Création de la table 'cadeaux'
CREATE TABLE cadeaux (
    nopige INT,
    cadeau VARCHAR(50)
);
-- Insérer des données dans 'presences'
INSERT INTO presences (nopige, nom)
VALUES
(1, 'Alice'),
(1, 'Bob');

-- Insérer des données dans 'cadeaux'
INSERT INTO cadeaux (nopige, cadeau)
VALUES
(1, 'iPad'),
(2, 'Galaxy');

SELECT * 
FROM cadeaux c
LEFT OUTER JOIN presences p ON (1=1)
WHERE c.nopige = p.nopige;
