CREATE DATABASE TestDB;
USE TestDB;
CREATE TABLE tblStudent(
    studentId INT IDENTITY(1, 1),
    studentName NVARCHAR(100),
    age int CHECK(age > 0)
);
SELECT * FROM tblStudent;
INSERT INTO tblStudent(studentName, age)
VALUES('Nguyen Duc Hoang', 44);
