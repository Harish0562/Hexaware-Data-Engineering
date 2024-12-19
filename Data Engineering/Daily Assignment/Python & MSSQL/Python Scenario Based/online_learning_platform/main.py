from database.db_connection import setup_database
from services.course_service import *
from services.user_service import *
from services.submission_service import *

def main():

    setup_database()  # Ensure the database is set up

    print("Welcome to the Online Learning Platform!")
    while True:
        print("\n1. Register")
        print("2. Login")
        print("3. Create Course (Admin)")
        print("4. View All Courses")
        print("5. Exit")
        print("6. Submit Assignment")
        print("7. View Submissions (Admin)")
        print("8. Add Feedback to Submission (Admin)")
        choice = input("Select an option: ")

        if choice == "1":
            name = input("Enter your name: ")
            email = input("Enter your email: ")
            password = input("Enter your password: ")
            UserService.register_user(name, email, password)

        elif choice == "2":
            email = input("Enter your email: ")
            password = input("Enter your password: ")
            user = UserService.authenticate_user(email, password)
            if user:
                print(f"Welcome, {user.name}!")

        elif choice == "3":
            title = input("Enter course title: ")
            description = input("Enter course description: ")
            instructor = input("Enter instructor name: ")
            CourseService.create_course(title, description, instructor)

        elif choice == "4":
            courses = CourseService.get_all_courses()
            if courses:
                print("Available Courses:")
                for course in courses:
                    print(f"- {course.title} by {course.instructor}")
            else:
                print("No courses available.")

        elif choice == "5":
            print("Goodbye!")
            break


        elif choice == "6":
            user_id = int(input("Enter your user ID: "))
            course_id = int(input("Enter the course ID: "))
            content = input("Enter your assignment content: ")
            SubmissionService.submit_assignment(user_id, course_id, content)

        elif choice == "7":
            course_id = int(input("Enter the course ID to view submissions: "))
            submissions = SubmissionService.get_submissions_by_course(course_id)
            for submission in submissions:
                print(f"Submission ID: {submission.submission_id}")
                print(f"User ID: {submission.user_id}")
                print(f"Content: {submission.content}")
                print(f"Feedback: {submission.feedback or 'No feedback yet'}")
                print("-" * 20)

        elif choice == "8":
            submission_id = int(input("Enter the submission ID to add feedback: "))
            feedback = input("Enter feedback: ")
            SubmissionService.add_feedback(submission_id, feedback)
        else:
            print("Invalid choice. Try again.")

if __name__ == "__main__":
    main()
