-- =============================================================
-- Zoo Database: Schema
-- Author: William Wellington
-- Dialect: Microsoft SQL Server (T-SQL)
-- Creates the four tables and their primary/foreign keys.
-- =============================================================

DROP TABLE IF EXISTS Animal;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Species;
DROP TABLE IF EXISTS Zoo;

CREATE TABLE Zoo (
    ZooName          VARCHAR(20) NOT NULL,
    City             VARCHAR(18) NOT NULL,
    AnnualNoVisitors INT         NULL,
    CountryLoc       CHAR(12)    NULL,
    CONSTRAINT PK_Zoo PRIMARY KEY (ZooName)
);

CREATE TABLE Species (
    Species     VARCHAR(15) NOT NULL,
    Status      CHAR(1)     NULL,      -- E = Endangered, V = Vulnerable, C = Least Concern
    EstNoInWild BIGINT      NULL,
    CONSTRAINT PK_Species PRIMARY KEY (Species)
);

CREATE TABLE Employee (
    EmpNo    CHAR(4)      NOT NULL,
    EmpName  VARCHAR(10)  NOT NULL,
    Species  VARCHAR(15)  NULL,        -- species of expertise; NULL = not an expert
    ZooName  VARCHAR(20)  NOT NULL,
    Salary   DECIMAL(8,2) NOT NULL,
    Gender   CHAR(1)      NOT NULL,
    CONSTRAINT PK_Employee PRIMARY KEY (EmpNo),
    CONSTRAINT FK_Employee_Species FOREIGN KEY (Species) REFERENCES Species (Species),
    CONSTRAINT FK_Employee_Zoo     FOREIGN KEY (ZooName) REFERENCES Zoo (ZooName)
);

CREATE TABLE Animal (
    AnimalId    CHAR(5)     NOT NULL,
    Species     VARCHAR(15) NOT NULL,
    ZooName     VARCHAR(20) NOT NULL,
    DateOfBirth DATE        NULL,      -- NULL = born in the wild
    Gender      CHAR(1)     NULL,
    CONSTRAINT PK_Animal PRIMARY KEY (AnimalId),
    CONSTRAINT FK_Animal_Species FOREIGN KEY (Species) REFERENCES Species (Species),
    CONSTRAINT FK_Animal_Zoo     FOREIGN KEY (ZooName) REFERENCES Zoo (ZooName)
);
