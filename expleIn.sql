SELECT DISTINCT essn
FROM works_on
WHERE (pno, hours) IN 
    (SELECT pno, hours FROM works_on WHERE essn = '123456789');
