--1--Chọn ra 5 trường có điểm trung bình cao nhất và lấy thông tin trường đó bằng hàm get_school_infor
WITH tmp AS
(
    SELECT TOP 5 School_ID, AVG(ISAT_Exceeding_Math + ISAT_Exceeding_Reading + ISAT_Value_Add_Math + ISAT_Value_Add_Read) AS AVG_ISAT
    FROM tbl_ISAT
    GROUP BY School_ID
    ORDER BY AVG_ISAT DESC 
)
SELECT * 
FROM tmp 
CROSS APPLY get_school_info(tmp.School_ID)
ORDER BY AVG_ISAT DESC;



--2-- Chọn ra 10 trường học có tỷ lệ học sinh đi học trung bình cao nhất và lấy thông tin trường đó bằng hàm get_school_infor
WITH tmp AS
(
    SELECT TOP 10 School_ID, Average_Student_Attendance
    FROM tbl_Student_Performance
    ORDER BY Average_Student_Attendance DESC
)
SELECT * 
FROM tmp CROSS APPLY get_school_info(tmp.School_ID)
ORDER BY Average_Student_Attendance DESC;



--3-- Chọn ra 10 trường học có tỷ lệ sự hiện diện giáo viên đến trường trung bình cao nhất và lấy thông tin trường đó bằng hàm get_school_infor
WITH tmp AS
(
    SELECT TOP 10 School_ID, Average_Teacher_Attendance
    FROM tbl_Teachers
    ORDER BY Average_Teacher_Attendance DESC
)
SELECT * 
FROM tmp 
CROSS APPLY get_school_info(tmp.School_ID)
ORDER BY Average_Teacher_Attendance DESC;




--4-- Chọn ra trường học có số lượng học sinh đăng ký vào đại học cao nhất và lấy thông tin trường đó bằng hàm get_school_infor
WITH tmp AS
(
SELECT TOP 1 School_ID, MAX(College_Enrollment_number_of_students) AS Max_College_Enrollment_number_of_students
FROM tbl_Graduation_Enrollment
GROUP BY School_ID
ORDER BY Max_College_Enrollment_number_of_students DESC  
)
SELECT * 
FROM tmp 
CROSS APPLY get_school_info(tmp.School_ID)
ORDER BY Max_College_Enrollment_number_of_students DESC;




--5-- Chọn tỷ lệ đăng ký vào đại học,tỷ lệ tốt nghiệp đại học của 50 trường học cao nhất và lấy thông tin trường đó bằng hàm get_school_infor
WITH tmp AS 
(
    SELECT TOP 50
        School_ID,
        College_Enrollment_Rate,
        Graduation_Rate
    FROM tbl_Graduation_Enrollment
    ORDER BY College_Enrollment_Rate DESC
)
SELECT *
FROM tmp 
CROSS APPLY get_school_info(tmp.School_ID) 
ORDER BY College_Enrollment_Rate DESC;



--6-- Chọn các trường có biểu tượng an toàn vô cùng mạnh và lấy thông tin trường đó bằng hàm get_school_infor
WITH tmp AS
(
    SELECT School_ID, Safety_Icon
    FROM tbl_School_Survey
    WHERE Safety_Icon = 'Very Strong'
)
SELECT *
FROM tmp 
CROSS APPLY get_school_info(tmp.School_ID)
ORDER BY Safety_Icon;



--7-- Chọn các trường học có "Tỷ lệ đủ điều kiện vào đại học" trên 70% và lấy thông tin trường đó bằng hàm get_school_infor
WITH tmp AS
(
    SELECT School_ID, College_Eligibility
    FROM tbl_Graduation_Enrollment 
    WHERE   TRY_CAST(College_Eligibility AS DECIMAL (5,2)) > 70
)
SELECT * 
FROM tmp 
CROSS APPLY get_school_info(tmp.School_ID)
ORDER BY TRY_CAST(College_Eligibility AS DECIMAL (5,2));



--8-- Chọn ra các trường học có lịch trình theo dõi là tiêu chuẩn và lấy thông tin trường đó bằng hàm get_school_infor
WITH tmp AS
(
SELECT School_ID, Track_Schedule
FROM tbl_CHICAGO_PUBLIC_SCHOOLS
WHERE Track_Schedule = 'Standard'
)
SELECT * 
FROM tmp 
CROSS APPLY get_school_info(tmp.School_ID)
ORDER BY Track_Schedule;



--9-- Chọn ra các trường học có điểm môi trường lớn hơn 50 và lấy thông tin trường đó bằng hàm get_school_infor
WITH tmp AS
(
    SELECT School_ID, Environment_Score
    FROM tbl_School_Survey
    WHERE Environment_Score > 50
)
SELECT *
FROM tmp 
CROSS APPLY get_school_info(tmp.School_ID)
ORDER BY Environment_Score;



--10-- Chọn ra các trường có tỷ lệ vượt qua môn toán lớn hơn 60 và lấy thông tin trường đó bằng hàm get_school_infor 
WITH tmp AS
(
    SELECT School_ID, ISAT_Exceeding_Math
    FROM tbl_ISAT
    WHERE  ISAT_Exceeding_Math > 60
)
SELECT *
FROM tmp 
CROSS APPLY get_school_info(tmp.School_ID)
ORDER BY ISAT_Exceeding_Math;








