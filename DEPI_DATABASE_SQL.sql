-- ============================================================
-- Project   : E-Commerce Graduation Project – DEPI
-- Team      : Team B
-- Members   : Ali Mohamed, Ahmed Amgad, Ganna Abdelaleem,
--             Roaa Mostafa, Hana Ahmed, Salma Ayman
-- Database  : TrelloTestingDB
-- Tool      : MySQL Workbench
-- Purpose   : Database Testing
-- How to use: Run each test case one by one.
--             Read the result and compare to Expected Result.
--             Write PASS or FAIL in your report.
-- ============================================================

CREATE DATABASE IF NOT EXISTS TrelloTestingDB;
USE TrelloTestingDB;

-- SCHEMA CREATION
CREATE TABLE Boards (
    BoardID     VARCHAR(100) PRIMARY KEY,
    BoardName   VARCHAR(255) NOT NULL,
    Description TEXT
);

CREATE TABLE Lists (
    ListID   VARCHAR(100) PRIMARY KEY,
    ListName VARCHAR(255) NOT NULL,
    BoardID  VARCHAR(100),
    FOREIGN KEY (BoardID) REFERENCES Boards(BoardID)
);

CREATE TABLE Cards (
    CardID      VARCHAR(100) PRIMARY KEY,
    CardName    VARCHAR(255) NOT NULL,
    Description TEXT,
    ListID      VARCHAR(100),
    Status      VARCHAR(50),
    FOREIGN KEY (ListID) REFERENCES Lists(ListID)
);

CREATE TABLE TestCases (
    TestCaseID     INT PRIMARY KEY AUTO_INCREMENT,
    Method         VARCHAR(10),
    Endpoint       TEXT,
    ExpectedResult VARCHAR(255),
    ActualResult   VARCHAR(255),
    StatusCode     INT,
    Status         VARCHAR(20)
);

-- SECTION 1 : SCHEMA VERIFICATION

-- DB_TC_01 : Verify all tables exist
-- Expected: Boards, Lists, Cards, TestCases all appear
SHOW TABLES;
-- DB_TC_02 : Verify Boards table has correct columns
-- Expected : BoardID (PK), BoardName (NOT NULL), Description
DESCRIBE Boards;
-- DB_TC_03 : Verify Lists table has correct columns
-- Expected    : ListID (PK), ListName (NOT NULL), BoardID (FK)
DESCRIBE Lists;
-- DB_TC_04 : Verify Cards table has correct columns
-- Expected : CardID (PK), CardName (NOT NULL), ListID (FK), Status
DESCRIBE Cards;
-- DB_TC_05 : Verify TestCases table has correct columns
-- Expected : TestCaseID (AUTO_INCREMENT PK), Method, Endpoint, StatusCode, Status
DESCRIBE TestCases;

-- SECTION 2 : INSERT TESTS (CREATE)

-- DB_TC_06 : Insert a valid Board
-- Expected : 1 row affected, no error
INSERT INTO Boards (BoardID, BoardName, Description)
VALUES ('S7XUjm6a', 'Project Trello', 'Testing CRUD operations');
-- DB_TC_07 : Insert a valid List linked to the Board above
-- Expected : 1 row affected, no error
INSERT INTO Lists (ListID, ListName, BoardID)
VALUES ('689006', 'List 1', 'S7XUjm6a');
-- DB_TC_08 : Insert a valid Card linked to the List above
-- Expected : 1 row affected, no error
INSERT INTO Cards (CardID, CardName, Description, ListID, Status)
VALUES ('69e88a5448999748ced21f8a', 'Test Card', 'Initial Description', '689006', 'Active');
-- DB_TC_09 : Insert a Card with an empty CardName
-- Expected : 1 row affected (empty string is not NULL, so DB allows it)
INSERT INTO Cards (CardID, CardName, Description, ListID, Status)
VALUES ('card_empty_name', '', 'Card with no name', '689006', 'Active');
-- DB_TC_10 : Insert a Card with special characters in CardName
-- Expected : 1 row affected, characters stored exactly as entered
INSERT INTO Cards (CardID, CardName, Description, ListID, Status)
VALUES ('card_special_chars', 'Card @#! & Test "One"', 'Special characters test', '689006', 'Active');
-- DB_TC_11 : Insert TestCase records for all API operations
-- Expected : 5 rows affected, no error
INSERT INTO TestCases (Method, Endpoint, ExpectedResult, ActualResult, StatusCode, Status)
VALUES
    ('POST',   '/cards',      '200 OK',        '200 OK',        200, 'Pass'),
    ('GET',    '/cards/{id}', '200 OK',        '200 OK',        200, 'Pass'),
    ('PUT',    '/cards/{id}', '200 OK',        '200 OK',        200, 'Pass'),
    ('DELETE', '/cards/{id}', '200 OK',        '200 OK',        200, 'Pass'),
    ('GET',    '/cards/{id}', '404 Not Found', '404 Not Found', 404, 'Pass');

-- SECTION 3 : CONSTRAINT VIOLATION TESTS
-- Run each one separately. These are EXPECTED to fail.
-- The error message you see IS the passing condition.

-- DB_TC_12 : Insert a Card with a duplicate CardID (same as DB_TC_08)
-- Expected : ERROR 1062 – Duplicate entry for PRIMARY KEY
INSERT INTO Cards (CardID, CardName, ListID, Status)
VALUES ('69e88a5448999748ced21f8a', 'Duplicate Card', '689006', 'Active');
-- DB_TC_13 : Insert a Card with NULL CardName
-- Expected : ERROR 1048 – Column CardName cannot be null
INSERT INTO Cards (CardID, CardName, ListID, Status)
VALUES ('card_null_test', NULL, '689006', 'Active');
-- DB_TC_14 : Insert a Card with a ListID that does not exist
-- Expected : ERROR 1452 – Foreign key constraint fails
INSERT INTO Cards (CardID, CardName, ListID, Status)
VALUES ('card_bad_list', 'Bad Card', 'INVALID_LIST_999', 'Active');
-- DB_TC_15 : Insert a List with a BoardID that does not exist
-- Expected : ERROR 1452 – Foreign key constraint fails
INSERT INTO Lists (ListID, ListName, BoardID)
VALUES ('list_bad_board', 'Bad List', 'INVALID_BOARD_999');
-- DB_TC_16 : Delete a List that still has Cards referencing it
-- Expected : ERROR 1451 – Cannot delete because Cards reference this List
DELETE FROM Lists
WHERE ListID = '689006';
-- DB_TC_17 : Delete a Board that still has Lists referencing it
-- Expected : ERROR 1451 – Cannot delete because Lists reference this Board
DELETE FROM Boards
WHERE BoardID = 'S7XUjm6a';

-- SECTION 4 : SELECT TESTS (READ)

-- DB_TC_18 : Retrieve all Cards
-- Expected : All inserted cards appear in the result
SELECT * FROM Cards;
-- DB_TC_19 : Retrieve one specific Card by its ID
-- Expected : Exactly 1 row returned for Test Card
SELECT * FROM Cards
WHERE CardID = '69e88a5448999748ced21f8a';
-- DB_TC_20 : Retrieve a Card that does not exist
-- Expected : 0 rows returned
SELECT * FROM Cards
WHERE CardID = 'NON_EXISTENT_CARD_999';
-- DB_TC_21 : Retrieve all passing TestCases
-- Expected : All 5 inserted TestCase rows returned
SELECT * FROM TestCases
WHERE Status = 'Pass';
-- DB_TC_22 : JOIN Cards with their List name
-- Expected : Each card row shows its correct ListName
SELECT c.CardID, c.CardName, l.ListName
FROM Cards c
JOIN Lists l ON c.ListID = l.ListID;
-- DB_TC_23 : Full hierarchy JOIN – Board > List > Card
-- Expected : BoardName, ListName, CardName shown together in one row
SELECT b.BoardName, l.ListName, c.CardName
FROM Boards b
JOIN Lists  l ON b.BoardID = l.BoardID
JOIN Cards  c ON l.ListID  = c.ListID;
-- DB_TC_24 : Count total Cards per List
-- Expected : ListID 689006 shows 3 cards
SELECT ListID, COUNT(*) AS TotalCards
FROM Cards
GROUP BY ListID;

-- SECTION 5 : UPDATE TESTS

-- DB_TC_25 : Update CardName to a new valid value
-- Expected : CardName becomes 'Grad Project'
UPDATE Cards
SET CardName = 'Grad Project'
WHERE CardID = '69e88a5448999748ced21f8a';
SELECT CardName FROM Cards
WHERE CardID = '69e88a5448999748ced21f8a';
-- DB_TC_26 : Update Description to a new value
-- Expected : Description updated correctly
UPDATE Cards
SET Description = 'This is my Grad Project description'
WHERE CardID = '69e88a5448999748ced21f8a';
SELECT Description FROM Cards
WHERE CardID = '69e88a5448999748ced21f8a';
-- DB_TC_27 : Update CardName to an empty string
-- Expected : CardName becomes empty string, no error
UPDATE Cards
SET CardName = ''
WHERE CardID = '69e88a5448999748ced21f8a';
SELECT CardName FROM Cards
WHERE CardID = '69e88a5448999748ced21f8a';
-- DB_TC_28 : Update a Card that does not exist
-- Expected : 0 rows affected, no error
UPDATE Cards
SET CardName = 'Ghost'
WHERE CardID = 'INVALID_ID_999';
-- DB_TC_29 : Update Status field only (partial update)
-- Expected : Status becomes 'Archived', other fields unchanged
UPDATE Cards
SET Status = 'Archived'
WHERE CardID = '69e88a5448999748ced21f8a';
SELECT * FROM Cards
WHERE CardID = '69e88a5448999748ced21f8a';
-- DB_TC_30 : Mark Card as soft-deleted before physical removal
-- Expected : Status becomes 'Deleted'
UPDATE Cards
SET Status = 'Deleted'
WHERE CardID = '69e88a5448999748ced21f8a';
SELECT Status FROM Cards
WHERE CardID = '69e88a5448999748ced21f8a';

-- SECTION 6 : DELETE TESTS

-- DB_TC_31 : Delete an existing Card
-- Expected : 1 row affected, no error
DELETE FROM Cards
WHERE CardID = '69e88a5448999748ced21f8a';
-- DB_TC_32 : Confirm the deleted Card no longer exists
-- Expected : 0 rows returned
SELECT * FROM Cards
WHERE CardID = '69e88a5448999748ced21f8a';
-- DB_TC_33 : Delete a Card that does not exist
-- Expected : 0 rows affected, no error
DELETE FROM Cards
WHERE CardID = '69fakeID123';

-- SECTION 7 : DATA INTEGRITY CHECKS

-- DB_TC_34 : Check for orphaned Cards (Cards with no matching List)
-- Expected : 0 rows – no broken references exist
SELECT c.CardID
FROM Cards c
LEFT JOIN Lists l ON c.ListID = l.ListID
WHERE l.ListID IS NULL;
-- DB_TC_35 : Check for orphaned Lists (Lists with no matching Board)
-- Expected : 0 rows – no broken references exist
SELECT l.ListID
FROM Lists l
LEFT JOIN Boards b ON l.BoardID = b.BoardID
WHERE b.BoardID IS NULL;
-- DB_TC_36 : Verify POST result stored correctly in TestCases
-- Expected : Method = POST, StatusCode = 200, Status = Pass
SELECT Method, StatusCode, Status
FROM TestCases
WHERE Method = 'POST';
-- DB_TC_37 : Verify DELETE result stored correctly in TestCases
-- Expected : Method = DELETE, StatusCode = 200, Status = Pass
SELECT Method, StatusCode, Status
FROM TestCases
WHERE Method = 'DELETE';
-- DB_TC_38 : Verify the 404 scenario stored correctly in TestCases
-- Expected : StatusCode = 404, Status = Pass
SELECT Method, StatusCode, Status
FROM TestCases
WHERE StatusCode = 404;

-- END OF DATABASE TEST SCRIPT 