-- =============================================================
-- Zoo Database: Sample Data
-- Author: William Wellington
-- Fictional sample data, designed so every query in queries.sql
-- returns a meaningful result (including edge cases).
-- Run schema.sql first.
-- =============================================================

INSERT INTO Zoo (ZooName, City, AnnualNoVisitors, CountryLoc) VALUES
('Whipsnade',        'Dunstable', 600000,  'England'),
('Riverdale',        'Toronto',   250000,  'Canada'),
('Assiniboine Park', 'Winnipeg',  400000,  'Canada'),
('Woodland Park',    'Seattle',   1300000, 'USA'),
('San Diego',        'San Diego', 4000000, 'USA'),
('Beijing',          'Beijing',   6000000, 'China'),
('Small Farm',       'Guelph',    20000,   'Canada');

INSERT INTO Species (Species, Status, EstNoInWild) VALUES
('Lion',         'V', 23000),
('Tiger',        'E', 4500),
('Panda',        'V', 1864),
('Gorilla',      'E', 300000),
('Red Panda',    'E', 10000),
('Snow Leopard', 'V', 4000),
('Amur Leopard', 'E', 100),
('Elephant',     'E', 415000),
('Penguin',      'C', 2500000);

INSERT INTO Employee (EmpNo, EmpName, Species, ZooName, Salary, Gender) VALUES
('E001', 'John',   'Lion',    'Whipsnade',        72000, 'M'),
('E002', 'Jane',   'Lion',    'Riverdale',        45000, 'F'),
('E003', 'Priya',  'Tiger',   'Riverdale',        52000, 'F'),
('E004', 'Marcus', 'Lion',    'Small Farm',       41000, 'M'),
('E005', 'Mei',    'Panda',   'Beijing',          68000, 'F'),
('E006', 'Wei',    'Panda',   'Beijing',          64000, 'M'),
('E007', 'Carlos', 'Panda',   'San Diego',        70000, 'M'),
('E008', 'Amara',  NULL,      'Whipsnade',        58000, 'F'),
('E009', 'Jamal',  'Gorilla', 'Woodland Park',    61000, 'M'),
('E010', 'Sofia',  'Tiger',   'Whipsnade',        66000, 'F'),
('E011', 'Liam',   'Lion',    'Riverdale',        38000, 'M'),
('E012', 'Noah',   'Penguin', 'Assiniboine Park', 49000, 'M');

INSERT INTO Animal (AnimalId, Species, ZooName, DateOfBirth, Gender) VALUES
('A1001', 'Lion',         'Whipsnade',        '2000-09-15', 'M'),
('A1002', 'Lion',         'Whipsnade',        '2001-03-02', 'F'),
('A1013', 'Tiger',        'Whipsnade',        NULL,         'M'),
('A1004', 'Gorilla',      'Whipsnade',        '1999-05-20', 'F'),
('A1015', 'Elephant',     'Whipsnade',        '2000-01-10', 'F'),
('A1006', 'Amur Leopard', 'Whipsnade',        NULL,         'M'),
('A2011', 'Lion',         'Riverdale',        '2000-11-30', 'M'),
('A2002', 'Penguin',      'Riverdale',        '2005-06-01', 'F'),
('A2003', 'Tiger',        'Riverdale',        '2000-09-01', 'F'),
('A3011', 'Tiger',        'Assiniboine Park', '2002-07-07', 'M'),
('A4001', 'Panda',        'Beijing',          '2001-08-08', 'M'),
('A4002', 'Panda',        'Beijing',          '2003-09-12', 'F'),
('A4013', 'Panda',        'Beijing',          NULL,         'F'),
('A4004', 'Red Panda',    'Beijing',          '2000-09-30', 'M'),
('A5001', 'Panda',        'San Diego',        '2005-08-23', 'M'),
('A5002', 'Panda',        'San Diego',        '2009-07-29', 'F'),
('A5013', 'Lion',         'San Diego',        '2010-02-14', 'M'),
('A5004', 'Snow Leopard', 'San Diego',        NULL,         'F'),
('A6001', 'Gorilla',      'Woodland Park',    '2000-12-31', 'M'),
('A6012', 'Lion',         'Woodland Park',    '2000-04-04', 'F'),
('A7001', 'Penguin',      'Small Farm',       '2012-01-01', 'M');
