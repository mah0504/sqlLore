BEGIN TRANSACTION;

CREATE TABLE notes (
    nom TEXT, 
    dev1 NUMERIC(4,1), 
    dev2 NUMERIC(4,1), 
    intra NUMERIC(4,1), 
    final NUMERIC(4,1)
);

INSERT INTO notes VALUES 
  ('Lise', 100, 100, 100, 100),
  ('Jean', 90, 90, NULL, 90),
  ('Frodo', 50, 60, 70, 80),
  ('Alf', NULL, NULL, NULL, NULL);

SELECT 
    nom, 
    COALESCE(dev1, 0) * 0.15 + 
    COALESCE(dev2, 0) * 0.15 + 
    COALESCE(intra, 0) * 0.30 + 
    COALESCE(final, 0) * 0.40 AS moy
FROM notes
ORDER BY nom;

WITH notes_calcul AS (
    SELECT nom, dev1 * 0.15 AS note FROM notes
    UNION ALL
    SELECT nom, dev2 * 0.15 FROM notes
    UNION ALL
    SELECT nom, intra * 0.30 FROM notes
    UNION ALL
    SELECT nom, final * 0.40 FROM notes
)
SELECT nom, SUM(note) AS moy 
FROM notes_calcul 
GROUP BY nom 
ORDER BY nom;

SELECT 
    nom, 
    CASE 
        WHEN COALESCE(dev1, 0) + COALESCE(dev2, 0) + COALESCE(intra, 0) + COALESCE(final, 0) = 0 THEN 'F*'
        ELSE COALESCE(dev1, 0) * 0.15 + 
             COALESCE(dev2, 0) * 0.15 + 
             COALESCE(intra, 0) * 0.30 + 
             COALESCE(final, 0) * 0.40
    END AS moy
FROM notes
ORDER BY nom;

ROLLBACK;
