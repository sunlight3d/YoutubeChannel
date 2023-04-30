import pyodbc

class Database:
    def __init__(self):
        self.server_name = 'localhost'
        self.database_name = 'StockApp'
        self.port = '1434'
        self.username = 'sa'
        self.password = 'Abc123456789@'
        self.driver= '{ODBC Driver 18 for SQL Server}'                
        self.connection_string = ('DRIVER={driver};'
                                  'SERVER={server_name},{port};'
                                  'DATABASE={database_name};'
                                  'UID={username};'
                                  'PWD={password};TrustServerCertificate=Yes').format(
                                        driver=self.driver,
                                        server_name=self.server_name,
                                        port=self.port,
                                        database_name=self.database_name,
                                        username=self.username,
                                        password=self.password
                                    )    
        self.conn = pyodbc.connect(self.connection_string)
        self.cursor = self.conn.cursor()    


    def execute_query(self, query, params):
        self.cursor.execute(query, params)
        self.conn.commit()

"""
MacOS:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
HOMEBREW_ACCEPT_EULA=Y brew install msodbcsql18 mssql-tools18

pip install faker
python insert_stocks.py
python insert_quotes.py
python insert_portfolios.py
python insert_watchlists.py
python insert_orders.py
python insert_etfs.py
python insert_etf_holdings.py 
"""