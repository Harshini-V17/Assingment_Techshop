from util.DBConnUtil import DBConnUtil
import pyodbc

class PaymentProcessingSystem:

    def record_payment(self, order_id, payment_method, amount):
        try:
            connection = DBConnUtil.getConnection()
            cursor = connection.cursor()
            sql_query = """
                        INSERT INTO payments (OrderID, PaymentMethod, Amount)
                        VALUES (?, ?, ?)
                        """
            cursor.execute(sql_query, (order_id, payment_method, amount))
            connection.commit()

            print("Payment recorded successfully")
        except pyodbc.Error as e:
            print("Error recording payment:", e)
            connection.rollback()  # Rollback in case of error
        finally:
            connection.close()

    def validate_payment(self, order_id, payment_method, amount):
        # Implement payment validation logic here
        # For example, check if payment method is valid, amount is greater than 0, etc.
        return True  # For demonstration purposes, always return True
