from sortedcontainers import SortedList
from datetime import datetime
import pyodbc

class InventoryManager:
    def __init__(self, connection_string):
        self.inventory_list = SortedList()
        self.connection_string = connection_string

    def add_inventory(self, inventory):
        # Add inventory to the SortedList
        self.inventory_list.add((inventory.product.product_id, inventory))
        
        # Also add it to the SQL Server database
        self._insert_inventory_to_db(inventory)

    def _insert_inventory_to_db(self, inventory):
        try:
            with pyodbc.connect(self.connection_string) as connection:
                cursor = connection.cursor()
                sql_query = """
                INSERT INTO Inventory (ProductID, QuantityInStock)
                VALUES (?, ?)
                """
                cursor.execute(sql_query, (inventory.product.product_id, inventory.quantity_in_stock))
                connection.commit()
        except Exception as e:
            print("Error inserting inventory to database:", e)

    def remove_inventory(self, product_id):
        index = self._find_index_by_product_id(product_id)
        if index is not None:
            inventory = self.inventory_list[index][1]
            self._delete_inventory_from_db(inventory.product.product_id)
            del self.inventory_list[index]

    def _delete_inventory_from_db(self, product_id):
        try:
            with pyodbc.connect(self.connection_string) as connection:
                cursor = connection.cursor()
                sql_query = "DELETE FROM Inventory WHERE ProductID = ?"
                cursor.execute(sql_query, (product_id,))
                connection.commit()
        except Exception as e:
            print("Error deleting inventory from database:", e)

    def update_inventory_quantity(self, product_id, new_quantity):
        index = self._find_index_by_product_id(product_id)
        if index is not None:
            # Update quantity in the SortedList
            self.inventory_list[index][1].quantity_in_stock = new_quantity
            
            # Update quantity in the SQL Server database
            self._update_inventory_quantity_in_db(product_id, new_quantity)

    def _update_inventory_quantity_in_db(self, product_id, new_quantity):
        try:
            with pyodbc.connect(self.connection_string) as connection:
                cursor = connection.cursor()
                sql_query = """
                UPDATE Inventory
                SET QuantityInStock = ?
                WHERE ProductID = ?
                """
                cursor.execute(sql_query, (new_quantity, product_id))
                connection.commit()
        except Exception as e:
            print("Error updating inventory quantity in database:", e)

    def get_inventory_by_product_id(self, product_id):
        index = self._find_index_by_product_id(product_id)
        if index is not None:
            return self.inventory_list[index][1]
        return None

    def _find_index_by_product_id(self, product_id):
        for i, (key, inventory) in enumerate(self.inventory_list):
            if key == product_id:
                return i
        return None
