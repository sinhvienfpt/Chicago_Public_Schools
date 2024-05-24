#ODBC (Includes Node.js) (SQL authentication)
f= open('./password.txt','r')
pw = f.read()
f.close()
s = "Driver={ODBC Driver 18 for SQL Server};Server=tcp:serverz.database.windows.net,1433;Database=DB_LAB03;Uid=tendangnhap;"+f"Pwd={pw};"+"Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;"


import pyodbc
import pandas as pd

## Connect to the database
conn = pyodbc.connect(s)
cursor = conn.cursor()

## Query
query = "SELECT * FROM dbo.tbl_ISAT"
df = pd.read_sql(query, conn)
print(df)