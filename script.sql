-- Select all
SELECT * FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS;
GO;

-- 566x79



--All data types of columns in table
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tbl_CHICAGO_PUBLIC_SCHOOLS';
GO;

--Set [School_ID] as primary key (Add contraint not null and unique)
ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
ALTER COLUMN School_ID INT NOT NULL

ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
ADD CONSTRAINT PK_School_ID PRIMARY KEY (School_ID)


-- Drop derived column [location] (derived from latitude and longitude )
ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN location;

-- Drop [city] column (has only value 'Chicago') and create a var @city to save it 
ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN city;

DECLARE @city VARCHAR(10);
SET @city = 'Chicago'
PRINT @city

-- Drop [state] column (has only value 'IL') and create a var @state to save it
ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN state;

DECLARE @state VARCHAR(2);
SET @state = 'IL'
PRINT @state

-- Drop [RCDTS_Code] column (has only value '150000000000000') and create a var @RCDTS to save it
ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN RCDTS_Code;

DECLARE @RCDTS VARCHAR(15);
SET @RCDTS = '150000000000000'



-- Create a new table tbl_Address with columns: School_ID (FOREIGN KEY), Street_Address, ZIP_Code, X_COORDINATE, Y_COORDINATE, Latitude, Longitude, Ward, Police_District
CREATE TABLE tbl_Address
(
    School_ID INT FOREIGN KEY REFERENCES dbo.tbl_CHICAGO_PUBLIC_SCHOOLS(School_ID),
    Street_Adress NVARCHAR(255),
    ZIP_Code INT,
    X_COORDINATE FLOAT,
    Y_COORDINATE FLOAT,
    Latitude FLOAT,
    Longitude FLOAT,
    Ward TEXT,
    Police_District TEXT,
);

INSERT INTO tbl_Address
SELECT School_ID, Street_Address, ZIP_Code, X_COORDINATE, Y_COORDINATE, Latitude, Longitude, Ward, Police_District
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS

ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN Street_Address, ZIP_Code, X_COORDINATE, Y_COORDINATE, Latitude, Longitude, Ward, Police_District;



-- Create a new table tbl_Contact with columns: School_ID (FOREIGN KEY), Phone_Number, Link
CREATE TABLE tbl_Contact
(
    School_ID INT FOREIGN KEY REFERENCES dbo.tbl_CHICAGO_PUBLIC_SCHOOLS(School_ID),
    Phone_Number NVARCHAR(50),
    Link NVARCHAR(255)
);

INSERT INTO tbl_Contact
SELECT School_ID, Phone_Number, Link
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS

ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN Phone_Number, Link;


-- Create a new table tbl_Demographics with columns: Community_Area_Number, Community_Area_Name
CREATE TABLE tbl_Demographics
(
    Community_Area_Number INT PRIMARY KEY,
    Community_Area_Name NVARCHAR(50)
);

INSERT INTO tbl_Demographics
SELECT DISTINCT Community_Area_Number, Community_Area_Name
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS

ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN Community_Area_Name;
