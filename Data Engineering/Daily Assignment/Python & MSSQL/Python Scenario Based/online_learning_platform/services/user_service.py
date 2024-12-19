import pyodbc
from database.db_connection import connect_db
from models.user import *
import hashlib

class UserService:
    @staticmethod
    def hash_password(password):
        return hashlib.sha256(password.encode()).hexdigest()

    @staticmethod
    def register_user(name, email, password):
        hashed_password = UserService.hash_password(password)
        conn = connect_db()
        if conn:
            cursor = conn.cursor()
            try:
                cursor.execute("""
                    INSERT INTO Users (name, email, password)
                    VALUES (?, ?, ?)
                """, (name, email, hashed_password))
                conn.commit()
                print(f"User {name} registered successfully.")
            except pyodbc.IntegrityError:
                print("Email already exists.")
            finally:
                conn.close()

    @staticmethod
    def authenticate_user(email, password):
        hashed_password = UserService.hash_password(password)
        conn = connect_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT user_id, name FROM Users WHERE email = ? AND password = ?
            """, (email, hashed_password))
            row = cursor.fetchone()
            conn.close()
            if row:
                user = User(row[0], row[1], email, hashed_password)
                return user
        print("Invalid email or password.")
        return None
