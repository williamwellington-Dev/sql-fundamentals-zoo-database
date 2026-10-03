-- =============================================================
-- Zoo Database: Queries
-- Author: William Wellington
-- Dialect: Microsoft SQL Server (T-SQL)
-- Run schema.sql and sample_data.sql first.
-- =============================================================


-- -------------------------------------------------------------
-- 1. Filtering and Sorting
-- -------------------------------------------------------------

-- 1.1 Show the ID, zoo, and species of every animal
SELECT AnimalId, ZooName, Species FROM Animal;

-- 1.2 Show the ID, zoo, and species of every male animal
SELECT AnimalId, ZooName, Species FROM Animal
WHERE Gender = 'M';

-- 1.3 Show zoos with between 30,000 and 6,000,000 annual visitors (inclusive)
SELECT ZooName, City, AnnualNoVisitors FROM Zoo
WHERE AnnualNoVisitors >= 30000 AND AnnualNoVisitors <= 6000000;

-- 1.4 Show lion experts who earn more than $40,000
SELECT * FROM Employee
WHERE Species = 'Lion' AND Salary > 40000;

-- 1.5 Show employees who are experts in lions or tigers
SELECT * FROM Employee
WHERE Species = 'Lion' OR Species = 'Tiger';

-- 1.6 Show lion or tiger experts who work at Riverdale
SELECT * FROM Employee
WHERE ZooName = 'Riverdale' AND (Species = 'Tiger' OR Species = 'Lion');

-- 1.7 Show every animal that is not a lion or a tiger
SELECT * FROM Animal
WHERE Species <> 'Lion' AND Species <> 'Tiger';

-- 1.8 Show all lions, sorted by zoo, then by gender within each zoo
SELECT * FROM Animal
WHERE Species = 'Lion'
ORDER BY ZooName, Gender;

-- 1.9 Show endangered species with fewer than 10,000 left in the wild, highest estimate first
SELECT * FROM Species
WHERE Status = 'E' AND EstNoInWild < 10000
ORDER BY EstNoInWild DESC;

-- 1.10 Show male lions and pandas, sorted by species, then by zoo
-- Note: the parentheses matter. Without them, AND binds tighter than OR
-- and the query returns ALL lions plus only the male pandas.
SELECT * FROM Animal
WHERE (Species = 'Lion' OR Species = 'Panda') AND Gender = 'M'
ORDER BY Species, ZooName;


-- -------------------------------------------------------------
-- 2. Pattern Matching and Dates
-- -------------------------------------------------------------

-- 2.1 Show zoos with "Park" anywhere in the name
SELECT * FROM Zoo
WHERE ZooName LIKE '%Park%';

-- 2.2 Show employees whose name starts with "J"
SELECT * FROM Employee
WHERE EmpName LIKE 'J%';

-- 2.3 Show animals whose ID has "1" as the 4th character
SELECT * FROM Animal
WHERE AnimalId LIKE '___1%';

-- 2.4 Show animals born after the end of September 2000
SELECT * FROM Animal
WHERE DateOfBirth > '2000-09-30';

-- 2.5 Show animals born during September 2000
SELECT * FROM Animal
WHERE DateOfBirth >= '2000-09-01' AND DateOfBirth <= '2000-09-30';


-- -------------------------------------------------------------
-- 3. Aggregate Functions
-- -------------------------------------------------------------

-- 3.1 Count the lions born in 2000
SELECT COUNT(*) AS "Number Of Lions" FROM Animal
WHERE Species = 'Lion' AND DateOfBirth >= '2000-01-01' AND DateOfBirth <= '2000-12-31';

-- 3.2 Count the different species held at Whipsnade
-- COUNT(DISTINCT ...) counts each species once, not each animal.
SELECT COUNT(DISTINCT Species) AS "Number Of Different Species" FROM Animal
WHERE ZooName = 'Whipsnade';

-- 3.3 Count the employees who are experts in a species
-- NULL is not a value, so use IS NOT NULL. (!= 'NULL' compares to the text "NULL".)
SELECT COUNT(*) AS "Number Of Experts" FROM Employee
WHERE Species IS NOT NULL;

-- 3.4 Find the lowest wild population estimate among endangered species
SELECT MIN(EstNoInWild) AS "Lowest Estimate" FROM Species
WHERE Status = 'E';

-- 3.5 Find the average salary of a lion expert
SELECT AVG(Salary) AS "Average Salary" FROM Employee
WHERE Species = 'Lion';

-- 3.6 Count the animals born in captivity (they have a date of birth)
SELECT COUNT(*) AS "Born In Captivity" FROM Animal
WHERE DateOfBirth IS NOT NULL;

-- 3.7 Count the animals born in the wild (no date of birth)
SELECT COUNT(*) AS "Born In The Wild" FROM Animal
WHERE DateOfBirth IS NULL;


-- -------------------------------------------------------------
-- 4. Grouping (GROUP BY / HAVING)
-- -------------------------------------------------------------

-- 4.1 Total expert salary per species, highest total first
SELECT SUM(Salary) AS "Total Salary", Species FROM Employee
WHERE Species IS NOT NULL
GROUP BY Species
ORDER BY SUM(Salary) DESC;

-- 4.2 Average salary per zoo, only where the average is at least $65,000
SELECT AVG(Salary) AS "Average Salary", ZooName FROM Employee
GROUP BY ZooName
HAVING AVG(Salary) >= 65000;

-- 4.3 Zoos that have more than 2 pandas
SELECT COUNT(Species) AS "Number Of Pandas", ZooName FROM Animal
WHERE Species = 'Panda'
GROUP BY ZooName
HAVING COUNT(Species) > 2;

-- 4.4 Species that have more than 2 experts
SELECT COUNT(*) AS "Number Of Experts", Species FROM Employee
WHERE Species IS NOT NULL
GROUP BY Species
HAVING COUNT(*) > 2;


-- -------------------------------------------------------------
-- 5. Joins
-- -------------------------------------------------------------

-- 5.1 Endangered species held at Whipsnade (each species listed once)
SELECT DISTINCT Species.* FROM Species
INNER JOIN Animal ON Species.Species = Animal.Species
WHERE Animal.ZooName = 'Whipsnade' AND Species.Status = 'E';

-- 5.2 Canadian zoos that hold at least one endangered animal (each zoo listed once)
SELECT DISTINCT Zoo.* FROM Zoo
INNER JOIN Animal  ON Zoo.ZooName = Animal.ZooName
INNER JOIN Species ON Species.Species = Animal.Species
WHERE Species.Status = 'E' AND Zoo.CountryLoc = 'Canada';

-- 5.3 Lion experts who work at a zoo that has lions (each employee listed once)
-- The join must match on zoo as well as species. Otherwise a lion expert
-- at a zoo with no lions still matches lions held at other zoos.
SELECT DISTINCT Employee.* FROM Employee
INNER JOIN Animal ON Employee.Species = Animal.Species
                 AND Employee.ZooName = Animal.ZooName
WHERE Employee.Species = 'Lion';

-- 5.4 Experts who work at a zoo holding animals of their species,
--     sorted by zoo, then species, then employee name
SELECT DISTINCT Employee.* FROM Employee
INNER JOIN Animal ON Employee.Species = Animal.Species
                 AND Employee.ZooName = Animal.ZooName
ORDER BY Employee.ZooName, Employee.Species, Employee.EmpName;

-- 5.5 Species held at the zoo where John works (each species listed once)
SELECT DISTINCT Species.* FROM Species
INNER JOIN Animal   ON Species.Species = Animal.Species
INNER JOIN Employee ON Animal.ZooName = Employee.ZooName
WHERE Employee.EmpName = 'John';


-- -------------------------------------------------------------
-- 6. Data Modification (INSERT / UPDATE / DELETE)
-- -------------------------------------------------------------

-- 6.1 Add a new employee
INSERT INTO Employee (EmpNo, EmpName, Species, ZooName, Salary, Gender)
VALUES ('E013', 'Alex', 'Penguin', 'Riverdale', 50000, 'M');

-- 6.2 Change their expertise and give them a 10% raise
UPDATE Employee
SET Species = 'Gorilla',
    Salary  = Salary * 1.10
WHERE EmpNo = 'E013';

-- 6.3 Remove the employee added above
DELETE FROM Employee
WHERE EmpNo = 'E013';
