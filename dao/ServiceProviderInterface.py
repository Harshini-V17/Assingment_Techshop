import sys
import os
from abc import ABC, abstractmethod

# Append the parent directory to sys.path for module accessibility
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

class Interface(ABC):
    @abstractmethod
    def calculate_total_orders(self):
        """Calculate the total number of orders."""
        pass

    @abstractmethod
    def update_customer_info(self, customer):
        """Update the information of a customer."""
        pass

    @abstractmethod
    def get_customer_details(self, customer_id):
        """Retrieve details of a specific customer."""
        pass

    @abstractmethod
    def get_product_details(self, product_id):
        """Retrieve details of a specific product."""
        pass

    @abstractmethod
    def update_product_info(self, product):
        """Update product information."""
        pass

    @abstractmethod
    def is_product_in_stock(self, product_id):
        """Check if a specific product is in stock."""
        pass

    @abstractmethod
    def calculate_total_amount(self, order_id):
        """Calculate the total amount for a specific order."""
        pass

    @abstractmethod
    def get_order_details(self, order_id):
        """Retrieve details of a specific order."""
        pass

    @abstractmethod
    def update_order_status(self, order_id, status):
        """Update the status of a specific order."""
        pass

    @abstractmethod
    def cancel_order(self, order_id):
        """Cancel a specific order."""
        pass

    @abstractmethod
    def calculate_subtotal(self, order_detail_id):
        """Calculate the subtotal for a specific order detail."""
        pass

    @abstractmethod
    def get_order_detail_info(self, order_detail_id):
        """Retrieve information of a specific order detail."""
        pass

    @abstractmethod
    def update_quantity(self, order_detail_id, new_quantity):
        """Update the quantity of a specific order detail."""
        pass

    @abstractmethod
    def add_discount(self, order_detail_id, discount_percentage):
        """Apply a discount to a specific order detail."""
        pass

    @abstractmethod
    def get_product(self, product_id):
        """Retrieve a specific product."""
        pass

    @abstractmethod
    def update_stock_quantity(self, product_id, quantity):
        """Update the stock quantity for a specific product."""
        pass

    @abstractmethod
    def is_product_available(self, product_id, quantity):
        """Check if a specific product is available."""
        pass

    @abstractmethod
    def remove_from_inventory(self, product_id):
        """Remove a specific product from inventory."""
        pass

    @abstractmethod
    def insert_customer(self, customer):
        """Insert a new customer."""
        pass

    @abstractmethod
    def delete_customer(self, customer_id):
        """Delete a specific customer."""
        pass

    @abstractmethod
    def get_quantity_in_stock(self, product_id):
        """Get the quantity in stock for a specific product."""
        pass

    @abstractmethod
    def insert_orders(self, order):
        """Insert a new order."""
        pass

    @abstractmethod
    def insert_products(self, product):
        """Insert a new product."""
        pass

    @abstractmethod
    def insert_inventory(self, product_id, quantity_in_stock, last_stock_update):
        """Insert a new inventory item."""
        pass
