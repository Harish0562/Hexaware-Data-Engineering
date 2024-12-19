use Python_Scenario_Based;

CREATE TABLE Users (
    user_id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL
);

CREATE TABLE Courses (
    course_id INT IDENTITY PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    instructor NVARCHAR(255) NOT NULL
);

CREATE TABLE Enrollments (
    enrollment_id INT IDENTITY PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    course_id INT FOREIGN KEY REFERENCES Courses(course_id)
);

CREATE TABLE Submissions (
    submission_id INT IDENTITY PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES Users(user_id) ON DELETE CASCADE,
    course_id INT FOREIGN KEY REFERENCES Courses(course_id) ON DELETE CASCADE,
    content NVARCHAR(MAX) NOT NULL,
    feedback NVARCHAR(MAX)
);

Select * from Users;
Select * from Courses;
Select * from Submissions;

DELETE FROM Users WHERE user_id=1;
DELETE FROM Courses WHERE course_id=1;
DELETE FROM Submissions WHERE course_id=1;