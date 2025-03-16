DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS dependent;

CREATE TABLE employee (
    ssn TEXT PRIMARY KEY,
    fname TEXT,
    lname TEXT
);
CREATE TABLE dependent (
    essn TEXT,
    dependent_name TEXT,
    relationship TEXT,
    FOREIGN KEY (essn) REFERENCES employee(ssn)
);

INSERT INTO employee (ssn, fname, lname) VALUES
('123456789', 'John', 'Doe'),
('987654321', 'Jane', 'Smith'),
('112233445', 'Alice', 'Lee'),
('222222222', 'Maha', 'Mih'),
('111111111', 'Meow', 'LLLL');


INSERT INTO dependent (essn, dependent_name, relationship) VALUES
('123456789', 'Mike', 'Son'),
('987654321', 'Lily', 'Daughter'),
('111111111', 'Meow', 'Daugther');

SELECT fname, lname
FROM employee

WHERE NOT EXISTS (
    SELECT * 
    FROM dependent
    WHERE essn = ssn
);


with recursive dep(essn,supssn) as
(select ssn, superssn from employee where superssn is not null
union
select ssn,supssn from employee join dep on superssn=essn) select * from dep
order by essn;