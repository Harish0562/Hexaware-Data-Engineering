import pyodbc

def connect_db():
    """
    Establishes a connection to the MSSQL database.
    Returns the connection object or None in case of an error.
    """
    try:
        connection = pyodbc.connect('Driver={SQL Server};'
                      'Server=DESKTOP-OFHDUG6;'
                      'Database=Python_Scenario_Based;'
                      'Trusted_Connection=yes;')

        return connection
    except pyodbc.Error as e:
        print(f"Database connection error: {e}")
        return None

def setup_database():
    """
    Sets up the necessary tables for the online learning platform.
    """
    connection = connect_db()
    if connection:
        try:
            cursor = connection.cursor()
            
            # Create Users table
            cursor.execute('''
                IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Users' AND xtype='U')
                CREATE TABLE Users (
                    user_id INT IDENTITY PRIMARY KEY,
                    name NVARCHAR(255) NOT NULL,
                    email NVARCHAR(255) UNIQUE NOT NULL,
                    password NVARCHAR(255) NOT NULL
                )
            ''')
            
            # Create Courses table
            cursor.execute('''
                IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Courses' AND xtype='U')
                CREATE TABLE Courses (
                    course_id INT IDENTITY PRIMARY KEY,
                    title NVARCHAR(255) NOT NULL,
                    description NVARCHAR(MAX),
                    instructor NVARCHAR(255) NOT NULL
                )
            ''')
            
            # Create Enrollments table
            cursor.execute('''
                IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Enrollments' AND xtype='U')
                CREATE TABLE Enrollments (
                    enrollment_id INT IDENTITY PRIMARY KEY,
                    user_id INT FOREIGN KEY REFERENCES Users(user_id),
                    course_id INT FOREIGN KEY REFERENCES Courses(course_id)
                )
            ''')
            
            # Create Submissions table
            cursor.execute('''
                IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Submissions' AND xtype='U')
                CREATE TABLE Submissions (
                    submission_id INT IDENTITY PRIMARY KEY,
                    user_id INT FOREIGN KEY REFERENCES Users(user_id),
                    course_id INT FOREIGN KEY REFERENCES Courses(course_id),
                    content NVARCHAR(MAX) NOT NULL,
                    feedback NVARCHAR(MAX)
                )
            ''')
            
            connection.commit()
            print("Database setup completed successfully.")
        except Exception as e:
            print(f"Error setting up database: {e}")
        finally:
            connection.close()

