# University Course Management System - SQL Final Project

## Project Overview

The **University Course Management System** is a comprehensive database design and query execution project that synthesizes and applies SQL concepts through a functional database system. This project focuses on working with various types of SQL operations (CRUD, joins, subqueries, string and date manipulation) to create a University Course Management System.

## Author Information

**Course**: SQL Final Project  
**Institution**: Red & White Skill Education  
**Project Type**: Database Design and Implementation

---

## Table of Contents

- [Project Objective](#project-objective)
- [Database Schema](#database-schema)
- [Installation & Setup](#installation--setup)
- [Database Tables](#database-tables)
- [Queries Implemented](#queries-implemented)
- [How to Run](#how-to-run)
- [Assumptions](#assumptions)
- [Project Structure](#project-structure)
- [Technologies Used](#technologies-used)
- [Future Enhancements](#future-enhancements)
- [License](#license)

---

## Project Objective

The primary objective of this project is to design and implement a complete database system with tables related to students, courses, instructors, enrollments, and departments. The project demonstrates proficiency in:

- Database design and normalization
- Complex SQL queries including CRUD operations
- Aggregation functions and filtering
- Various types of joins (INNER, LEFT)
- Subqueries and advanced SQL functions
- Window functions and the SQL CASE expression
- String and date manipulation functions

---

## Database Schema

The University Course Management System consists of **5 interconnected tables**:

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│  Students   │────▶│ Enrollments  │◀────│   Courses   │
└─────────────┘     └──────────────┘     └─────────────┘
                                                 │
                                                 ▼
┌─────────────┐                          ┌─────────────┐
│ Instructors │◀─────────────────────────│ Departments │
└─────────────┘                          └─────────────┘
```

### Entity Relationships

- **Students** ↔ **Enrollments**: One-to-Many (One student can enroll in multiple courses)
- **Courses** ↔ **Enrollments**: One-to-Many (One course can have multiple students)
- **Departments** ↔ **Courses**: One-to-Many (One department offers multiple courses)
- **Departments** ↔ **Instructors**: One-to-Many (One department has multiple instructors)

---

## Installation & Setup

### Prerequisites

- MySQL Server 5.7+ or MariaDB 10.3+
- MySQL Workbench (optional, for GUI)
- Command-line MySQL client

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/university-course-management.git
   cd university-course-management
   ```

2. **Start MySQL Server**
   ```bash
   # On Linux/Mac
   sudo systemctl start mysql
   
   # On Windows
   net start MySQL
   ```

3. **Login to MySQL**
   ```bash
   mysql -u root -p
   ```

4. **Run the SQL script**
   ```sql
   source university_course_management.sql;
   ```

   OR

   ```bash
   mysql -u root -p < university_course_management.sql
   ```

---

## Database Tables

### 1. Students Table

Stores information about students enrolled at the university.

| Field | Type | Description |
|-------|------|-------------|
| StudentID | INT (PK) | Unique identifier for each student |
| FirstName | VARCHAR(50) | Student's first name |
| LastName | VARCHAR(50) | Student's last name |
| Email | VARCHAR(100) | Student's email address (unique) |
| BirthDate | DATE | Student's date of birth |
| EnrollmentDate | DATE | Date when student enrolled |

**Sample Data:**
| StudentID | FirstName | LastName | Email | BirthDate | EnrollmentDate |
|-----------|-----------|----------|----------------------|------------|----------------|
| 1 | John | Doe | john.doe@email.com | 2000-01-15 | 2022-08-01 |
| 2 | Jane | Smith | jane.smith@email.com | 1999-05-25 | 2021-08-01 |

---

### 2. Departments Table

Contains details of academic departments within the university.

| Field | Type | Description |
|-------|------|-------------|
| DepartmentID | INT (PK) | Unique identifier for each department |
| DepartmentName | VARCHAR(100) | Name of the department (unique) |

**Sample Data:**
| DepartmentID | DepartmentName |
|--------------|------------------|
| 1 | Computer Science |
| 2 | Mathematics |

---

### 3. Courses Table

Stores details of courses available at the university.

| Field | Type | Description |
|-------|------|-------------|
| CourseID | INT (PK) | Unique identifier for each course |
| CourseName | VARCHAR(100) | Name of the course |
| DepartmentID | INT (FK) | Reference to Departments table |
| Credits | INT | Number of credits for the course |

**Sample Data:**
| CourseID | CourseName | DepartmentID | Credits |
|----------|----------------------|--------------|---------|
| 101 | Introduction to SQL | 1 | 3 |
| 102 | Data Structures | 2 | 4 |

---

### 4. Instructors Table

Contains information about course instructors.

| Field | Type | Description |
|-------|------|-------------|
| InstructorID | INT (PK) | Unique identifier for each instructor |
| FirstName | VARCHAR(50) | Instructor's first name |
| LastName | VARCHAR(50) | Instructor's last name |
| Email | VARCHAR(100) | Instructor's email address (unique) |
| DepartmentID | INT (FK) | Reference to Departments table |

**Sample Data:**
| InstructorID | FirstName | LastName | Email | DepartmentID |
|--------------|-----------|----------|-------------------------|--------------|
| 1 | Alice | Johnson | alice.johnson@univ.com | 1 |
| 2 | Bob | Lee | bob.lee@univ.com | 2 |

---

### 5. Enrollments Table

Manages which students are enrolled in which courses.

| Field | Type | Description |
|-------|------|-------------|
| EnrollmentID | INT (PK) | Unique identifier for each enrollment |
| StudentID | INT (FK) | Reference to Students table |
| CourseID | INT (FK) | Reference to Courses table |
| EnrollmentDate | DATE | Date of enrollment |

**Sample Data:**
| EnrollmentID | StudentID | CourseID | EnrollmentDate |
|--------------|-----------|----------|----------------|
| 1 | 1 | 101 | 2022-08-01 |
| 2 | 2 | 102 | 2021-08-01 |

---

## Queries Implemented

### Basic Operations

1. **CRUD Operations**: Perform CREATE, READ, UPDATE, and DELETE operations on all tables
2. **Retrieve Students Enrolled After 2022**: Filter students based on enrollment date
3. **Mathematics Department Courses**: Retrieve courses from specific department with limit

### Aggregation & Filtering

4. **Student Count per Course**: Count students in each course, filter courses with >5 students
5. **Average Credits**: Calculate average number of credits across all courses
6. **Student Count per Department**: Count total students enrolled in each department

### Joins

10. **INNER JOIN**: Retrieve students and their corresponding courses
11. **LEFT JOIN**: Retrieve all students and their courses (including students without enrollments)

### Set Operations & Subqueries

5. **Students in Both Courses**: Find students enrolled in both Introduction to SQL AND Data Structures
6. **Students in Either Course**: Find students enrolled in Introduction to SQL OR Data Structures
12. **Subquery**: Find students enrolled in courses that have more than 10 students

### String & Date Functions

13. **Extract Year from EnrollmentDate**: Use date functions to extract year, month, and day
14. **Concatenate Names**: Combine instructor's first and last name into full name

### Advanced SQL

15. **Running Total**: Calculate cumulative total of students enrolled in courses using window functions
16. **Conditional Labeling**: Label students as 'Senior' or 'Junior' based on years since enrollment (>4 years = Senior)

### Additional Queries

- View all enrollments with complete details
- Find courses with no enrollments
- Find instructors with the most students

---

## How to Run

### Run All Queries

```bash
mysql -u root -p UniversityCourseManagement < university_course_management.sql
```

### Run Individual Queries

```sql
-- Login to MySQL
mysql -u root -p

-- Select the database
USE UniversityCourseManagement;

-- Example: Run Query 2 (Students enrolled after 2022)
SELECT 
    StudentID,
    FirstName,
    LastName,
    EnrollmentDate
FROM Students
WHERE YEAR(EnrollmentDate) > 2022;
```

### Verify Results

```sql
-- Check table contents
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
SELECT * FROM Instructors;
SELECT * FROM Departments;
```

---

## Assumptions

Based on the project requirements and instructions provided, the following assumptions have been made:

1. **Data Integrity**: All foreign key constraints are enforced to maintain referential integrity
2. **Unique Constraints**: Email addresses for students and instructors are unique
3. **Enrollment Logic**: A student cannot enroll in the same course twice (unique constraint on StudentID + CourseID)
4. **Date Format**: All dates follow the YYYY-MM-DD format
5. **Current Date**: Queries using CURDATE() will calculate based on system date
6. **Salary Field**: Query 8 references instructor salary, which is not in the original schema. The query structure is provided for reference if salary data is added
7. **Sample Data**: The provided sample data is minimal; additional data can be inserted for more comprehensive testing

---

## Project Structure

```
university-course-management/
│
├── README.md                           # This file
├── university_course_management.sql    # Main SQL script with all tables and queries
├── sample_data.sql                     # Additional sample data (optional)
│
└── documentation/
    ├── schema_diagram.png              # Database schema diagram
    ├── query_results.pdf               # Sample query outputs
    └── project_requirements.pdf        # Original project requirements
```

---

## Technologies Used

- **Database Management System**: MySQL 8.0 / MariaDB 10.5+
- **SQL**: DDL (Data Definition Language), DML (Data Manipulation Language)
- **Query Types**: 
  - SELECT, INSERT, UPDATE, DELETE
  - INNER JOIN, LEFT JOIN
  - Subqueries
  - Aggregate Functions (COUNT, AVG, SUM, MAX)
  - Window Functions (OVER, ORDER BY)
  - String Functions (CONCAT)
  - Date Functions (YEAR, MONTH, DAY, DATEDIFF, CURDATE)
  - CASE expressions
  - GROUP BY, HAVING, ORDER BY, LIMIT

---

## Future Enhancements

Potential improvements and features for future versions:

1. **Additional Tables**:
   - Grades table (to track student performance)
   - Assignments table (to manage course assignments)
   - Attendance table (to track student attendance)
   - Semesters table (to organize courses by term)

2. **Enhanced Functionality**:
   - Stored procedures for common operations
   - Triggers for automatic date updates
   - Views for frequently accessed data combinations
   - Indexes for performance optimization

3. **Advanced Queries**:
   - GPA calculation for students
   - Course prerequisites tracking
   - Instructor workload analysis
   - Department performance metrics

4. **Security Features**:
   - User roles and permissions
   - Encrypted sensitive data
   - Audit logs for data changes

5. **API Integration**:
   - REST API for external applications
   - Web interface for database management
   - Mobile app connectivity

---

## Sample Query Outputs

### Query 2: Students Enrolled After 2022
```
+------------+-----------+----------+----------------+
| StudentID  | FirstName | LastName | EnrollmentDate |
+------------+-----------+----------+----------------+
| 3          | Michael   | Brown    | 2023-01-15     |
| 4          | Sarah     | Davis    | 2023-08-20     |
+------------+-----------+----------+----------------+
```

### Query 14: Concatenated Instructor Names
```
+--------------+-----------+----------+------------------+
| InstructorID | FirstName | LastName | FullName         |
+--------------+-----------+----------+------------------+
| 1            | Alice     | Johnson  | Alice Johnson    |
| 2            | Bob       | Lee      | Bob Lee          |
+--------------+-----------+----------+------------------+
```

---

## Testing

To test the database system:

1. **Verify Table Creation**:
   ```sql
   SHOW TABLES;
   DESCRIBE Students;
   ```

2. **Check Foreign Keys**:
   ```sql
   SHOW CREATE TABLE Enrollments;
   ```

3. **Test Data Insertion**:
   ```sql
   INSERT INTO Students VALUES (3, 'Test', 'User', 'test@email.com', '2001-01-01', '2023-08-01');
   ```

4. **Run Sample Queries**: Execute each query from the project requirements and verify output

---

## Contributing

This is an academic project. However, suggestions and improvements are welcome:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Create a Pull Request

---

## Academic Integrity

This project is submitted as part of the SQL Final Project for Red & White Skill Education. All code and content are original work, properly attributed to appropriate sources where applicable. 

**No Copying Policy**: This project adheres to strict academic integrity guidelines. All code and content are original and properly attributed. Plagiarism is strictly prohibited and can result in severe academic penalties.

---

## Contact

For questions, issues, or suggestions regarding this project:

- **Email**: your.email@example.com
- **GitHub**: [@yourusername](https://github.com/yourusername)
- **LinkedIn**: [Your Name](https://linkedin.com/in/yourprofile)

---

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## Acknowledgments

- **Red & White Skill Education** for providing the project framework and requirements
- **SQL Documentation** and community resources for query optimization techniques
- **Database Design Principles** from academic coursework and industry best practices

---

**BRING ON YOUR CODING ATTITUDE** 🚀

*Last Updated: November 2025*
