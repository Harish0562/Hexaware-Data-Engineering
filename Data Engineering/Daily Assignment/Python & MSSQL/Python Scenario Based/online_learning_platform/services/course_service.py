from database.db_connection import connect_db
from models.course import *

class CourseService:
    @staticmethod
    def create_course(title, description, instructor):
        conn = connect_db()
        if conn:
            cursor = conn.cursor()
            try:
                cursor.execute("""
                    INSERT INTO Courses (title, description, instructor)
                    VALUES (?, ?, ?)
                """, (title, description, instructor))
                conn.commit()
                print(f"Course '{title}' created successfully.")
            finally:
                conn.close()

    @staticmethod
    def get_all_courses():
        conn = connect_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("SELECT course_id, title, description, instructor FROM Courses")
            courses = [Course(row[0], row[1], row[2], row[3]) for row in cursor.fetchall()]
            conn.close()
            return courses
        return []
