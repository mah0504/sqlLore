SELECT c.nopige AS "A", c.cadeau AS "R.B", p.nom AS "R.C", p.nopige AS "S.B", p.nom AS "S.C", NULL AS "D"
FROM cadeaux c
JOIN presences p ON (c.nopige <= p.nopige);
