-- Select all
SELECT *
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS;
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
ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLSSchool_Type
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


-- Create a new table tbl_Family_Engagement_Environment with columns: School_ID (FOREIGN KEY),Family_Involvement_Icon,Family_Involvement_Score Parent_Engagement_Icon, Parent_Engagement_Score, Parent_Environment_Icon, Parent_Environment_Score
CREATE TABLE tbl_Family_Engagement_Environment
(
    School_ID INT FOREIGN KEY REFERENCES dbo.tbl_CHICAGO_PUBLIC_SCHOOLS(School_ID),
    Family_Involvement_Icon NVARCHAR(50),
    Family_Involvement_Score NVARCHAR(50),
    Parent_Engagement_Icon NVARCHAR(50),
    Parent_Engagement_Score NVARCHAR(50),
    Parent_Environment_Icon NVARCHAR(50),
    Parent_Environment_Score NVARCHAR(50)
);

INSERT INTO tbl_Family_Engagement_Environment
SELECT School_ID, Family_Involvement_Icon, Family_Involvement_Score, Parent_Engagement_Icon, Parent_Engagement_Score, Parent_Environment_Icon, Parent_Environment_Score
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS

ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN Family_Involvement_Icon, Family_Involvement_Score, Parent_Engagement_Icon, Parent_Engagement_Score, Parent_Environment_Icon, Parent_Environment_Score;

SELECT *
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS


-- Create table tbl_ISAT with columns: School_ID (FOREIGN KEY), ISAT_Exceeding_Math,ISAT_Exceeding_Reading,ISAT_Value_Add_Math,ISAT_Value_Add_Read,ISAT_Value_Add_Color_Math,ISAT_Value_Add_Color_Read

CREATE TABLE tbl_ISAT
(
    School_ID INT FOREIGN KEY REFERENCES dbo.tbl_CHICAGO_PUBLIC_SCHOOLS(School_ID),
    ISAT_Exceeding_Math FLOAT,
    ISAT_Exceeding_Reading FLOAT,
    ISAT_Value_Add_Math FLOAT,
    ISAT_Value_Add_Read FLOAT,
    ISAT_Value_Add_Color_Math NVARCHAR(50),
    ISAT_Value_Add_Color_Read NVARCHAR(50)
);

INSERT INTO tbl_ISAT
SELECT School_ID, ISAT_Exceeding_Math, ISAT_Exceeding_Reading, ISAT_Value_Add_Math, ISAT_Value_Add_Read, ISAT_Value_Add_Color_Math, ISAT_Value_Add_Color_Read
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS

ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN ISAT_Exceeding_Math, ISAT_Exceeding_Reading, ISAT_Value_Add_Math, ISAT_Value_Add_Read, ISAT_Value_Add_Color_Math, ISAT_Value_Add_Color_Read;



-- Create table tbl_Teachers with columns: School_ID (FOREIGN KEY), Teachers_Icon, Teachers_Score, Average_Teacher_Attendance
CREATE TABLE tbl_Teachers
(
    School_ID INT FOREIGN KEY REFERENCES dbo.tbl_CHICAGO_PUBLIC_SCHOOLS(School_ID),
    Teachers_Icon NVARCHAR(50),
    Teachers_Score NVARCHAR(50),
    Average_Teacher_Attendance FLOAT
);

INSERT INTO tbl_Teachers
SELECT School_ID, Teachers_Icon, Teachers_Score, Average_Teacher_Attendance
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS

ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN Teachers_Icon, Teachers_Score, Average_Teacher_Attendance;

-- Create table tbl_Leaders with columns: School_ID (FOREIGN KEY), Leaders_Icon, Leaders_Score
CREATE TABLE tbl_Leaders
(
    School_ID INT FOREIGN KEY REFERENCES dbo.tbl_CHICAGO_PUBLIC_SCHOOLS(School_ID),
    Leaders_Icon NVARCHAR(50),
    Leaders_Score NVARCHAR(50)
);

INSERT INTO tbl_Leaders
SELECT School_ID, Leaders_Icon, Leaders_Score
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS

ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN Leaders_Icon, Leaders_Score;

-- Create table tbl_Instruction with columns: School_ID (FOREIGN KEY), Instructors_Icon, Instructors_Score
CREATE TABLE tbl_Instruction
(
    School_ID INT FOREIGN KEY REFERENCES dbo.tbl_CHICAGO_PUBLIC_SCHOOLS(School_ID),
    Instruction_Icon NVARCHAR(50),
    Instruction_Score NVARCHAR(50)
);

INSERT INTO tbl_Instruction
SELECT School_ID, Instruction_Icon, Instruction_Score
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS

ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS 
DROP COLUMN Instruction_Icon, Instruction_Score;

-- Create table tbl_School_Survey with columns: School_ID (FOREIGN KEY), Safety_Icon, Safety_Score, Environment_Icon, Environment_Score, CPS_Performance_Policy_Status, CPS_Performance_Policy_Level, Healthy_School_Certified
CREATE TABLE tbl_School_Survey
(
    School_ID INT FOREIGN KEY REFERENCES dbo.tbl_CHICAGO_PUBLIC_SCHOOLS(School_ID),
    Safety_Icon NVARCHAR(50),
    Safety_Score NVARCHAR(50),
    Environment_Icon NVARCHAR(50),
    Environment_Score NVARCHAR(50),
    CPS_Performance_Policy_Status NVARCHAR(50),
    CPS_Performance_Policy_Level NVARCHAR(50),
    Healthy_Schools_Certified NVARCHAR(50),
    Adequate_Yearly_Progress_Made NVARCHAR(50),
    Individualized_Education_Program_Compliance_Rate FLOAT
);

INSERT INTO tbl_School_Survey
SELECT School_ID, Safety_Icon, Safety_Score, Environment_Icon, Environment_Score, CPS_Performance_Policy_Status, CPS_Performance_Policy_Level, Healthy_Schools_Certified, Adequate_Yearly_Progress_Made, Individualized_Education_Program_Compliance_Rate
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS

ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN Safety_Icon, Safety_Score, Environment_Icon, Environment_Score, CPS_Performance_Policy_Status, CPS_Performance_Policy_Level, Healthy_Schools_Certified,Adequate_Yearly_Progress_Made,Individualized_Education_Program_Compliance_Rate;


-- Create table tbl_Academic_Performance 
CREATE TABLE tbl_Academic_Performance
(
    School_ID INT FOREIGN KEY REFERENCES dbo.tbl_CHICAGO_PUBLIC_SCHOOLS(School_ID),
    Pk_2_Literacy NVARCHAR(50),
    Pk_2_Math NVARCHAR(50),
    Gr3_5_Grade_Level_Math NVARCHAR(50),
    Gr3_5_Grade_Level_Read NVARCHAR(50),
    Gr3_5_Keep_Pace_Read NVARCHAR(50),
    Gr3_5_Keep_Pace_Math NVARCHAR(50),
    Gr6_8_Grade_Level_Math NVARCHAR(50),
    Gr6_8_Grade_Level_Read NVARCHAR(50),
    Gr6_8_Keep_Pace_Math NVARCHAR(50),
    Gr6_8_Keep_Pace_Read NVARCHAR(50),
    Gr_8_Explore_Math NVARCHAR(50),
    Gr_8_Explore_Read NVARCHAR(50),
    Students_Taking_Algebra NVARCHAR(50),
    Students_Passing_Algebra NVARCHAR(50),
    _9th_Grade_EXPLORE_2009 NVARCHAR(50),
    _9th_Grade_EXPLORE_2010 NVARCHAR(50),
    _10th_Grade_PLAN_2009 NVARCHAR(50),
    _10th_Grade_PLAN_2010 NVARCHAR(50),
    Net_Change_EXPLORE_and_PLAN NVARCHAR(50),
    _11th_Grade_Average_ACT_2011 NVARCHAR(50),
    Net_Change_PLAN_and_ACT NVARCHAR(50)
);

INSERT INTO tbl_Academic_Performance
SELECT School_ID, Pk_2_Literacy, Pk_2_Math, Gr3_5_Grade_Level_Math, Gr3_5_Grade_Level_Read, Gr3_5_Keep_Pace_Read, Gr3_5_Keep_Pace_Math, Gr6_8_Grade_Level_Math, Gr6_8_Grade_Level_Read, Gr6_8_Keep_Pace_Math, Gr6_8_Keep_Pace_Read, Gr_8_Explore_Math, Gr_8_Explore_Read, Students_Taking_Algebra, Students_Passing_Algebra, _9th_Grade_EXPLORE_2009, _9th_Grade_EXPLORE_2010, _10th_Grade_PLAN_2009, _10th_Grade_PLAN_2010, Net_Change_EXPLORE_and_PLAN, _11th_Grade_Average_ACT_2011, Net_Change_PLAN_and_ACT
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS

ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN Pk_2_Literacy, Pk_2_Math, Gr3_5_Grade_Level_Math, Gr3_5_Grade_Level_Read, Gr3_5_Keep_Pace_Read, Gr3_5_Keep_Pace_Math, Gr6_8_Grade_Level_Math, Gr6_8_Grade_Level_Read, Gr6_8_Keep_Pace_Math, Gr6_8_Keep_Pace_Read, Gr_8_Explore_Math, Gr_8_Explore_Read, Students_Taking_Algebra, Students_Passing_Algebra, _9th_Grade_EXPLORE_2009, _9th_Grade_EXPLORE_2010, _10th_Grade_PLAN_2009, _10th_Grade_PLAN_2010, Net_Change_EXPLORE_and_PLAN, _11th_Grade_Average_ACT_2011, Net_Change_PLAN_and_ACT;

-- Create table tbl_Graduation_Enrollment with columns: School_ID (FOREIGN KEY), College_Eligibility, Graduation_Rate, College_Enrollment_Rate, College_Enrollment_number_of_students, Freshman_on_Track_Rate
CREATE TABLE tbl_Graduation_Enrollment
(
    School_ID INT FOREIGN KEY REFERENCES dbo.tbl_CHICAGO_PUBLIC_SCHOOLS(School_ID),
    College_Eligibility NVARCHAR(50),
    Graduation_Rate NVARCHAR(50),
    College_Enrollment_Rate NVARCHAR(50),
    College_Enrollment_number_of_students NVARCHAR(50),
    Freshman_on_Track_Rate NVARCHAR(50)
);

INSERT INTO tbl_Graduation_Enrollment
SELECT School_ID, College_Eligibility, Graduation_Rate, College_Enrollment_Rate, College_Enrollment_number_of_students, Freshman_on_Track_Rate
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS

ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN College_Eligibility, Graduation_Rate, College_Enrollment_Rate, College_Enrollment_number_of_students, Freshman_on_Track_Rate;

--CREATE TABLE tbl_Student_Performance columns School_ID (FOREIGN KEY), Student_Attendance,Rate_of_Misconducts_per_100_students
CREATE TABLE tbl_Student_Performance
(
    School_ID INT FOREIGN KEY REFERENCES dbo.tbl_CHICAGO_PUBLIC_SCHOOLS(School_ID),
    Average_Student_Attendance FLOAT,
    Rate_of_Misconducts_per_100_students FLOAT
);

INSERT INTO tbl_Student_Performance
SELECT School_ID, Average_Student_Attendance, Rate_of_Misconducts_per_100_students

FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS

ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN Average_Student_Attendance, Rate_of_Misconducts_per_100_students;

-- Tạo hàm để truy vấn tên trường, địa chỉ và số điện thoại , link của trường dựa trên School_ID
CREATE FUNCTION get_school_info(@School_ID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
    cps.School_ID,
    cps.Name_of_School,
    'Chiago' as City,
    'IL' as State,
    a.ZIP_Code,
    a.Street_Adress,
    c.Phone_Number,
    c.Link
FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS cps
    JOIN dbo.tbl_Address a ON cps.School_ID = a.School_ID
    JOIN dbo.tbl_Contact c ON cps.School_ID = c.School_ID
WHERE cps.School_ID = @School_ID
);




