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
('112233445', 'Alice', 'Lee');

INSERT INTO dependent (essn, dependent_name, relationship) VALUES
('123456789', 'Mike', 'Son'),
('987654321', 'Lily', 'Daughter');
SELECT fname, lname
FROM employee
WHERE NOT EXISTS (
    SELECT * 
    FROM dependent
    WHERE essn = ssn
);
