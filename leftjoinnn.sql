-- SELECT c.nopige AS "A", c.cadeau AS "R.B", p.nom AS "R.C", p.nopige AS "S.B", p.nom AS "S.C", NULL AS "D"
-- FROM cadeaux c
-- JOIN presences p ON (c.nopige <= p.nopige);

select * from cadeaux c
          LEFT OUTER JOIN presences p
          ON (1=1 and c.nopige=p.nopige);

