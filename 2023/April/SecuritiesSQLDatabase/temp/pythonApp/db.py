import pyodbc

def create_connection():
    server = 'localhost,1434'
    database = 'StockApp'
    username = 'sa'
    password = 'Abc123456789@'
    driver= '{ODBC Driver 18 for SQL Server}'
    connection = pyodbc.connect(f'DRIVER={driver};SERVER={server};DATABASE={database};UID={username};PWD={password};TrustServerCertificate=Yes')
    return connection
