-- Chọn ra 5 trường có điểm trung bình ISAT cao nhất và lấy thông tin trường đó bằng hàm get_school_info
WITH tmp AS
(
    SELECT TOP 5 School_ID, AVG(ISAT_Exceeding_Math + ISAT_Exceeding_Reading + ISAT_Value_Add_Math + ISAT_Value_Add_Read) AS AVG_ISAT
    FROM dbo.tbl_ISAT
    GROUP BY School_ID
    ORDER BY AVG_ISAT DESC
) 
SELECT *
FROM tmp
CROSS APPLY get_school_info(tmp.School_ID)
ORDER BY AVG_ISAT DESC;

-- Chọn ra 5 trường an toàn để học nhất dựa vào các tiêu chí 
-- safety_score cao nhất, healthy_schools_certified = 'Yes' và Rate_of_Misconducts_per_100_students thấp nhất
WITH tmp AS
(
    SELECT TOP 5 ss.School_ID, safety_score, healthy_schools_certified, Rate_of_Misconducts_per_100_students
    FROM dbo.tbl_School_Survey ss
    JOIN dbo.tbl_Student_Performance sp
    ON ss.School_ID = sp.School_ID
    WHERE Healthy_Schools_Certified = 'Yes'
    ORDER BY safety_score DESC, Rate_of_Misconducts_per_100_students ASC
)
SELECT * FROM tmp
CROSS APPLY get_school_info(tmp.School_ID)