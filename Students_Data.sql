-- 1. Create Instructors Table
CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50)
);

-- 2. Create Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    instructor_id INT,
    credits INT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

-- 3. Create Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    enrollment_date DATE
);

-- 4. Create Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    grade DECIMAL(5,2),
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- 5. Insert Sample Data into Instructors Table
INSERT INTO Instructors (first_name, last_name, email, department) 
VALUES 
('Uma', 'Kant', 'umadaa@gmail.com', 'Electrical'),
('Birju', 'Daa', 'birjudaa@gmail.com', 'Electronics');

-- 6. Insert Sample Data into Courses Table
INSERT INTO Courses (course_name, instructor_id, credits)
VALUES 
('Electrical Machineries', 1, 3),
('Power Electronic', 2, 4);

-- 7. Insert Sample Data into Students Table
INSERT INTO Students (first_name, last_name, email, enrollment_date)
VALUES 
('Api', 'Sahu', 'apisahu.1@gmail,com', '2025-01-01'),
('Krishna', 'Sahoo', 'krishna101@gmail.com', '2025-01-01');

-- 8. Insert Sample Data into Enrollments Table
INSERT INTO Enrollments (student_id, course_id, grade, enrollment_date)
VALUES 
(1, 1, 92.5, '2025-01-05'),  -- Api enrolled in Programming
(1, 2, 88.0, '2025-01-05'),  -- Api enrolled in Calculus
(2, 1, 75.5, '2025-01-05');  -- Krishna enrolled in Programming

-- 9. Basic Queries

-- List all students
SELECT * FROM Students;

-- Find courses taught by a specific instructor
SELECT course_name 
FROM Courses 
WHERE instructor_id = 1;  -- Replace 1 with desired instructor_id

-- Show all enrollments with grades
SELECT 
    Students.first_name, 
    Students.last_name, 
    Courses.course_name, 
    Enrollments.grade 
FROM Enrollments
JOIN Students ON Enrollments.student_id = Students.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id;

-- 10. Advanced Queries

-- Calculate average grade per course
SELECT 
    Courses.course_name, 
    AVG(Enrollments.grade) AS average_grade 
FROM Enrollments
JOIN Courses ON Enrollments.course_id = Courses.course_id
GROUP BY Courses.course_name;

-- Find students enrolled in more than 1 course
SELECT 
    Students.first_name, 
    Students.last_name, 
    COUNT(Enrollments.course_id) AS total_courses
FROM Enrollments
JOIN Students ON Enrollments.student_id = Students.student_id
GROUP BY Students.student_id
HAVING total_courses > 1;

-- List instructors and their courses
SELECT 
    Instructors.first_name, 
    Instructors.last_name, 
    Courses.course_name 
FROM Instructors
JOIN Courses ON Instructors.instructor_id = Courses.instructor_id;

-- 11. Optional: Stored Procedure to Enroll a Student
DELIMITER //
CREATE PROCEDURE EnrollStudent(
    IN p_student_id INT, 
    IN p_course_id INT, 
    IN p_enrollment_date DATE
)
BEGIN
    INSERT INTO Enrollments (student_id, course_id, enrollment_date)
    VALUES (p_student_id, p_course_id, p_enrollment_date);
END //
DELIMITER ;

-- Example: Call the stored procedure to enroll a student
CALL EnrollStudent(2, 2, '2023-09-10');  -- Enroll Bob in Calculus

-- Verify the enrollment
SELECT * FROM Enrollments;

-- 12. Optional: Add Unique Constraint to Prevent Duplicate Enrollments
ALTER TABLE Enrollments 
ADD UNIQUE (student_id, course_id);

-- 13. Optional: Calculate GPA for Each Student
SELECT 
    Students.student_id,
    Students.first_name,
    Students.last_name,
    ROUND(SUM(Enrollments.grade * Courses.credits) / SUM(Courses.credits), 2) AS GPA
FROM Enrollments
JOIN Students ON Enrollments.student_id = Students.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id
GROUP BY Students.student_id;-- 1. Create Instructors Table
CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50)
);

-- 2. Create Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    instructor_id INT,
    credits INT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

-- 3. Create Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    enrollment_date DATE
);

-- 4. Create Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    grade DECIMAL(5,2),
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- 5. Insert Sample Data into Instructors Table
INSERT INTO Instructors (first_name, last_name, email, department) 
VALUES 
('Uma', 'Kant', 'umadaa@gmail.com', 'Electrical'),
('Birju', 'Daa', 'birjudaa@gmail.com', 'Electronics');

-- 6. Insert Sample Data into Courses Table
INSERT INTO Courses (course_name, instructor_id, credits)
VALUES 
('Electrical Machineries', 1, 3),
('Power Electronic', 2, 4);

-- 7. Insert Sample Data into Students Table
INSERT INTO Students (first_name, last_name, email, enrollment_date)
VALUES 
('Api', 'Sahu', 'apisahu.1@gmail,com', '2025-01-01'),
('Krishna', 'Sahoo', 'krishna101@gmail.com', '2025-01-01');

-- 8. Insert Sample Data into Enrollments Table
INSERT INTO Enrollments (student_id, course_id, grade, enrollment_date)
VALUES 
(1, 1, 92.5, '2025-01-05'),  -- Api enrolled in Programming
(1, 2, 88.0, '2025-01-05'),  -- Api enrolled in Calculus
(2, 1, 75.5, '2025-01-05');  -- Krishna enrolled in Programming

-- 9. Basic Queries

-- List all students
SELECT * FROM Students;

-- Find courses taught by a specific instructor
SELECT course_name 
FROM Courses 
WHERE instructor_id = 1;  -- Replace 1 with desired instructor_id

-- Show all enrollments with grades
SELECT 
    Students.first_name, 
    Students.last_name, 
    Courses.course_name, 
    Enrollments.grade 
FROM Enrollments
JOIN Students ON Enrollments.student_id = Students.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id;

-- 10. Advanced Queries

-- Calculate average grade per course
SELECT 
    Courses.course_name, 
    AVG(Enrollments.grade) AS average_grade 
FROM Enrollments
JOIN Courses ON Enrollments.course_id = Courses.course_id
GROUP BY Courses.course_name;

-- Find students enrolled in more than 1 course
SELECT 
    Students.first_name, 
    Students.last_name, 
    COUNT(Enrollments.course_id) AS total_courses
FROM Enrollments
JOIN Students ON Enrollments.student_id = Students.student_id
GROUP BY Students.student_id
HAVING total_courses > 1;

-- List instructors and their courses
SELECT 
    Instructors.first_name, 
    Instructors.last_name, 
    Courses.course_name 
FROM Instructors
JOIN Courses ON Instructors.instructor_id = Courses.instructor_id;

-- 11. Optional: Stored Procedure to Enroll a Student
DELIMITER //
CREATE PROCEDURE EnrollStudent(
    IN p_student_id INT, 
    IN p_course_id INT, 
    IN p_enrollment_date DATE
)
BEGIN
    INSERT INTO Enrollments (student_id, course_id, enrollment_date)
    VALUES (p_student_id, p_course_id, p_enrollment_date);
END //
DELIMITER ;

-- Example: Call the stored procedure to enroll a student
CALL EnrollStudent(2, 2, '2023-09-10');  -- Enroll Bob in Calculus

-- Verify the enrollment
SELECT * FROM Enrollments;

-- 12. Optional: Add Unique Constraint to Prevent Duplicate Enrollments
ALTER TABLE Enrollments 
ADD UNIQUE (student_id, course_id);

-- 13. Optional: Calculate GPA for Each Student
SELECT 
    Students.student_id,
    Students.first_name,
    Students.last_name,
    ROUND(SUM(Enrollments.grade * Courses.credits) / SUM(Courses.credits), 2) AS GPA
FROM Enrollments
JOIN Students ON Enrollments.student_id = Students.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id
GROUP BY Students.student_id;