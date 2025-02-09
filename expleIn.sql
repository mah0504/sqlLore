CREATE TABLE works_on (
    essn TEXT,
    pno INTEGER,
    hours INTEGER
);

SELECT DISTINCT essn
FROM works_on
WHERE (pno, hours) IN 
    (SELECT pno, hours FROM works_on WHERE essn = '123456789');
