import pyodbc
from util.DBConnUtil import DBConnUtil

# Base class for database operations
class BaseDB:
    def __init__(self):
        self.db_connector = DBConnUtil()
        self.connection = self.db_connector.getConnection()
        self.cursor = self.connection.cursor()

    def execute_query(self, sql_query, params=None):
        try:
            self.__init__()
            if params:
                self.cursor.execute(sql_query, params)
            else:
                self.cursor.execute(sql_query)

            query_type = sql_query.strip().split()[0].upper()

            # Fetch and return rows for SELECT queries
            if query_type == 'SELECT':
                rows = self.cursor.fetchall()
                return rows
            else:
                return True  # Indicate success for other types of queries

        except pyodbc.Error as err:
            print("Error executing query: ", err)
            return None  # Indicate failure

        finally:
            self.connection.commit()
