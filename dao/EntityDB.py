from dao.BaseDB import BaseDB

class EntityDB(BaseDB):
    def __init__(self, table_name):
        super().__init__()
        self.table_name = table_name

    def get_entity_details(self, sql_query):
        # Use the provided SQL query to get entity details
        entity_data = self.execute_query(sql_query)
        if entity_data:
            print(f"{self.get_entity_name()} Details:", entity_data)
        else:
            print(f"{self.get_entity_name()} not found.")

    def get_entity_name(self):
        # Assuming the entity name is the same as the table name (capitalize it)
        return self.table_name.capitalize()

    def get_entity_id_column(self):
        # Assuming the ID column is 'ID' (or adjust as needed)
        return "ID"