import pyodbc

class DBConnUtil:
    __connection = None

    def getConnection():
        connection_string = (
        "DRIVER={SQL Server};" 
        "SERVER=HARSHU\\SQLEXPRESS;" 
        "DATABASE=TechShop;"
        "UID=sa;" 
        "PWD=Harshu@17;")
        try:
            DBConnUtil.__connection = pyodbc.connect(connection_string)
            return DBConnUtil.__connection
        except:
            print("Error")
            return None

    @staticmethod
    def close_connection():
        if DBConnUtil.__connection:
            DBConnUtil.__connection.close()
            print("Connection closed.")
            DBConnUtil.__connection = None
