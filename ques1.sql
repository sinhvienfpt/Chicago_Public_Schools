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
