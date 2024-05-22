-- Select all
SELECT * FROM dbo.tbl_CHICAGO_PUBLIC_SCHOOLS

-- Drop derived column [location] (derived from latitude and longitude )
ALTER TABLE dbo.tbl_CHICAGO_PUBLIC_SCHOOLS
DROP COLUMN location;