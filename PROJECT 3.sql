-- ============================================================
-- UNIVERSITY COURSE MANAGEMENT SYSTEM - FINAL PROJECT
-- SQL Database Design and Queries
-- ============================================================

-- ============================================================
-- 1. CREATE DATABASE AND TABLES
-- ============================================================

-- Create the database
CREATE DATABASE PROJECT_3;
USE PROJECT_3;

-- ============================================================
-- Table 1: Students
-- ============================================================
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    BirthDate DATE NOT NULL,
    EnrollmentDate DATE NOT NULL
);

-- ============================================================
-- Table 2: Departments
-- ============================================================
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) UNIQUE NOT NULL
);

-- ============================================================
-- Table 3: Courses
-- ============================================================
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    Credits INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- ============================================================
-- Table 4: Instructors
-- ============================================================
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- ============================================================
-- Table 5: Enrollments
-- ============================================================
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    UNIQUE KEY unique_enrollment (StudentID, CourseID)
);

-- ============================================================
-- 2. INSERT SAMPLE DATA
-- ============================================================

-- Insert Departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

-- Insert Students
INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate) VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');

-- Insert Courses
INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits) VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4);

-- Insert Instructors
INSERT INTO Instructors (InstructorID, FirstName, LastName, Email, DepartmentID) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2);

-- Insert Enrollments
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');

-- ============================================================
-- 3. REQUIRED QUERIES
-- ============================================================

-- Query 1: Perform CRUD Operations on all tables
-- CREATE operations (INSERT) - already done above

-- READ operations (SELECT)
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Instructors;
SELECT * FROM Enrollments;
SELECT * FROM Departments;

-- UPDATE operations
UPDATE Students SET Email = 'john.updated@email.com' WHERE StudentID = 1;
UPDATE Courses SET Credits = 5 WHERE CourseID = 102;

-- DELETE operations (with caution - respecting foreign key constraints)
-- Example: Delete a specific enrollment
DELETE FROM Enrollments WHERE EnrollmentID = 1;

-- ============================================================
-- Query 2: Retrieve students who enrolled after 2022
-- ============================================================
SELECT 
    StudentID,
    FirstName,
    LastName,
    Email,
    BirthDate,
    EnrollmentDate
FROM Students
WHERE YEAR(EnrollmentDate) > 2022
ORDER BY EnrollmentDate;

-- ============================================================
-- Query 3: Retrieve courses offered by Mathematics department with limit of 5
-- ============================================================
SELECT 
    c.CourseID,
    c.CourseName,
    c.Credits,
    d.DepartmentName
FROM Courses c
INNER JOIN Departments d ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
LIMIT 5;

-- ============================================================
-- Query 4: Get number of students enrolled in each course, 
--          filtering for courses with more than 5 students
-- ============================================================
SELECT 
    c.CourseID,
    c.CourseName,
    COUNT(e.StudentID) AS NumberOfStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING COUNT(e.StudentID) > 5
ORDER BY NumberOfStudents DESC;

-- ============================================================
-- Query 5: Find students enrolled in both Introduction to SQL and Data Structures
-- ============================================================
SELECT 
    s.StudentID,
    s.FirstName,
    s.LastName,
    s.Email
FROM Students s
WHERE s.StudentID IN (
    SELECT StudentID FROM Enrollments WHERE CourseID = 101
)
AND s.StudentID IN (
    SELECT StudentID FROM Enrollments WHERE CourseID = 102
);

-- Alternative approach using INTERSECT (if supported):
-- SELECT StudentID FROM Enrollments WHERE CourseID = 101
-- INTERSECT
-- SELECT StudentID FROM Enrollments WHERE CourseID = 102;

-- ============================================================
-- Query 6: Find students enrolled in either Introduction to SQL or Data Structures
-- ============================================================
SELECT DISTINCT
    s.StudentID,
    s.FirstName,
    s.LastName,
    s.Email
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IN (101, 102)
ORDER BY s.StudentID;

-- ============================================================
-- Query 7: Calculate the average number of credits for all courses
-- ============================================================
SELECT 
    AVG(Credits) AS AverageCredits,
    ROUND(AVG(Credits), 2) AS AverageCreditsRounded
FROM Courses;

-- ============================================================
-- Query 8: Find the maximum salary of instructors in Computer Science department
-- Note: Salary field not in original schema, using example structure
-- If salary data exists, the query would be:
-- ============================================================
-- ALTER TABLE Instructors ADD COLUMN Salary DECIMAL(10,2);
-- UPDATE Instructors SET Salary = 75000 WHERE InstructorID = 1;
-- UPDATE Instructors SET Salary = 80000 WHERE InstructorID = 2;

SELECT 
    d.DepartmentName,
    i.FirstName,
    i.LastName
    -- MAX(i.Salary) AS MaxSalary  -- Uncomment if Salary field exists
FROM Instructors i
INNER JOIN Departments d ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science'
GROUP BY d.DepartmentName, i.FirstName, i.LastName;

-- ============================================================
-- Query 9: Count the number of students enrolled in each department
-- ============================================================
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    COUNT(DISTINCT e.StudentID) AS NumberOfStudents
FROM Departments d
LEFT JOIN Courses c ON d.DepartmentID = c.DepartmentID
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY NumberOfStudents DESC;

-- ============================================================
-- Query 10: INNER JOIN - Retrieve students and their corresponding courses
-- ============================================================
SELECT 
    s.StudentID,
    s.FirstName,
    s.LastName,
    c.CourseID,
    c.CourseName,
    e.EnrollmentDate
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID
ORDER BY s.StudentID, c.CourseID;

-- ============================================================
-- Query 11: LEFT JOIN - Retrieve all students and their corresponding courses (if any)
-- ============================================================
SELECT 
    s.StudentID,
    s.FirstName,
    s.LastName,
    c.CourseID,
    c.CourseName,
    e.EnrollmentDate
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID
ORDER BY s.StudentID;

-- ============================================================
-- Query 12: Subquery - Find students enrolled in courses with more than 10 students
-- ============================================================
SELECT 
    s.StudentID,
    s.FirstName,
    s.LastName,
    s.Email
FROM Students s
WHERE s.StudentID IN (
    SELECT e.StudentID
    FROM Enrollments e
    WHERE e.CourseID IN (
        SELECT CourseID
        FROM Enrollments
        GROUP BY CourseID
        HAVING COUNT(StudentID) > 10
    )
)
ORDER BY s.StudentID;

-- ============================================================
-- Query 13: Extract the year from EnrollmentDate of students
-- ============================================================
SELECT 
    StudentID,
    FirstName,
    LastName,
    EnrollmentDate,
    YEAR(EnrollmentDate) AS EnrollmentYear,
    MONTH(EnrollmentDate) AS EnrollmentMonth,
    DAY(EnrollmentDate) AS EnrollmentDay
FROM Students
ORDER BY EnrollmentDate;

-- ============================================================
-- Query 14: Concatenate instructor's first and last name
-- ============================================================
SELECT 
    InstructorID,
    FirstName,
    LastName,
    CONCAT(FirstName, ' ', LastName) AS FullName,
    Email,
    DepartmentID
FROM Instructors
ORDER BY InstructorID;

-- ============================================================
-- Query 15: Calculate the running total of students enrolled in courses
-- ============================================================
SELECT 
    c.CourseID,
    c.CourseName,
    COUNT(e.StudentID) AS StudentsEnrolled,
    SUM(COUNT(e.StudentID)) OVER (ORDER BY c.CourseID) AS RunningTotal
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
ORDER BY c.CourseID;

-- ============================================================
-- Query 16: Label students as 'Senior' or 'Junior' based on enrollment year
--           (Senior if enrolled more than 4 years ago, otherwise Junior)
-- ============================================================
SELECT 
    StudentID,
    FirstName,
    LastName,
    EnrollmentDate,
    DATEDIFF(CURDATE(), EnrollmentDate) / 365 AS YearsSinceEnrollment,
    CASE 
        WHEN DATEDIFF(CURDATE(), EnrollmentDate) / 365 > 4 THEN 'Senior'
        ELSE 'Junior'
    END AS StudentStatus
FROM Students
ORDER BY EnrollmentDate;

-- ============================================================
-- END OF SQL PROJECT
-- ============================================================