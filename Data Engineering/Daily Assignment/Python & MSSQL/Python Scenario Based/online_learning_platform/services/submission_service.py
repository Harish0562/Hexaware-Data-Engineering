from database.db_connection import connect_db
from models.submission import *

class SubmissionService:
    @staticmethod
    def submit_assignment(user_id, course_id, content):
        conn = connect_db()
        if conn:
            cursor = conn.cursor()
            try:
                cursor.execute("""
                    INSERT INTO Submissions (user_id, course_id, content)
                    VALUES (?, ?, ?)
                """, (user_id, course_id, content))
                conn.commit()
                print("Assignment submitted successfully.")
            except Exception as e:
                print(f"Error submitting assignment: {e}")
            finally:
                conn.close()

    @staticmethod
    def get_submissions_by_course(course_id):
        conn = connect_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT submission_id, user_id, course_id, content, feedback 
                FROM Submissions 
                WHERE course_id = ?
            """, (course_id,))
            submissions = [
                Submission(row[0], row[1], row[2], row[3], row[4])
                for row in cursor.fetchall()
            ]
            conn.close()
            return submissions

    @staticmethod
    def add_feedback(submission_id, feedback):
        conn = connect_db()
        if conn:
            cursor = conn.cursor()
            try:
                cursor.execute("""
                    UPDATE Submissions 
                    SET feedback = ?
                    WHERE submission_id = ?
                """, (feedback, submission_id))
                conn.commit()
                print("Feedback added successfully.")
            except Exception as e:
                print(f"Error adding feedback: {e}")
            finally:
                conn.close()
