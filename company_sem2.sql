-- Fichier company2.txt (fichier sql)
-- Selon Elmasri Navathe
--   pour postgres
-- Usage:
--   psql -h postgres          -- sur arcade ou 1340
--   \i company2.txt           -- dans postgres

begin transaction;

drop schema if exists company2 cascade;
create schema company2;
set search_path to company2;

create domain dom_dnum as integer   -- standard SQL
  check (value > 0 and value < 21); 

create table department (
  dname varchar(20) not null,
  dnumber dom_dnum not null,  
  mgrssn char(9) not null default '88866555',   
  mgrstartdate date not null, 
  constraint deptpk primary key (dnumber),  
  constraint deptsk unique (dname)
);

create table employee (
  fname char(10) not null,
  lname char(20) not null,
  ssn char(9),
  bdate date not null,
  address char(30) not null,
  sex char(1) not null,
  salary numeric(5) not null,
  superssn char(9),
  dno dom_dnum not null default 1,
  constraint emppk 
     primary key(ssn),
  constraint empdepfk
     foreign key(dno) references department(dnumber)
         on delete set default  on update cascade
); 

create table project (
  pname char(20) not null,
  pnumber numeric(2) not null,  
  plocation char(20) not null,
  dnum dom_dnum not null default 1, 
  primary key (pnumber), 
  unique (pname), 
  foreign key (dnum) references department(dnumber)
     on delete set default on update cascade
); 

create table works_on (
  essn char(9) not null,  
  pno numeric(2) not null, 
  hours numeric(5,1),  
  primary key (essn, pno), 
  foreign key (essn) references employee(ssn),
  foreign key (pno) references project(pnumber)
); 

create table dependent (
  essn char(9) not null,  
  dependent_name char(10) not null,
  sex char(1) not null,
  bdate date not null,
  relationship char(30) not null,
  primary key (essn, dependent_name),
  foreign key (essn) references employee(ssn)
); 

create table dept_locations (
  dnumber dom_dnum not null,
  dlocation char (15) not null,
  primary key (dnumber, dlocation), 
  foreign key (dnumber) references department(dnumber)
     on delete cascade   on update cascade
);

insert into department values 
 ('Research',5,333445555,'1988-05-22'),
 ('Administration',4,987654321,'1995-01-01'),
 ('Headquarters',1,888665555,'1981-06-19');

insert into employee values 
 ('John','Smith',123456789,'1965-01-09','731 Fondren, Houston TX','M',30000,333445555,5),
 ('Franklin','Wong',333445555,'1965-12-08','638 Voss, Houston TX','M',40000,888665555,5),
 ('Alicia','Zelaya',999887777,'1968-01-19','3321 Castle, Spring TX','F',25000,987654321,4),
 ('Jennifer','Wallace',987654321,'1941-06-20','291 Berry, Bellaire TX','F',43000,888665555,4),
 ('Ramesh','Narayan',666884444,'1962-09-15','975 Fire Oak, Humble TX','M',38000,333445555,5),
 ('Joyce','English',453453453,'1972-07-31','5631 Rice, Houston TX','F',25000,333445555,5),
 ('Ahmad','Jabbar',987987987,'1969-03-29','980 Dallas, Houston TX','M',25000,987654321,4),
 ('James','Borg',888665555,'1937-11-10','450 Stone, Houston TX','M',55000,null,1);

insert into project values 
 ('ProductX',1,'Bellaire',5),
 ('ProductY',2,'Sugarland',5),
 ('ProductZ',3,'Houston',5),
 ('Computerization',10,'Stafford',4),
 ('Reorganization',20,'Houston',1),
 ('Newbenefits',30,'Stafford',4);

insert into works_on values 
 (123456789,1,32.5),
 (123456789,2,7.5),
 (666884444,3,40.0),
 (453453453,1,20.0),
 (453453453,2,20.0),
 (333445555,2,10.0),
 (333445555,3,10.0),
 (333445555,10,10.0),
 (333445555,20,10.0),
 (999887777,30,30.0),
 (999887777,10,10.0),
 (987987987,10,35.0),
 (987987987,30,5.0),
 (987654321,30,20.0),
 (987654321,20,15.0),
 (888665555,20,null);

insert into dependent values 
 (333445555,'Alice','F','1986-04-04','Daughter'),
 (333445555,'Theodore','M','1983-10-25','Son'),
 (333445555,'Joy','F','1958-05-03','Spouse'),
 (987654321,'Abner','M','1942-02-28','Spouse'),
 (123456789,'Michael','M','1988-01-04','Son'),
 (123456789,'Alice','F','1988-12-30','Daughter'),
 (123456789,'Elizabeth','F','1967-05-05','Spouse');

insert into dept_locations values
 (1,'Houston'),
 (4,'Stafford'),
 (5,'Bellaire'),
 (5,'Sugarland'),
 (5,'Houston');

alter table department 
 add constraint deptmgrfk
   foreign key (mgrssn) references employee(ssn)
     on delete set default  on update cascade;

alter table employee   
add constraint empsuperfk
  foreign key (superssn) references employee(ssn)
     on delete set NULL    on update cascade;
commit;