use db;

CREATE TABLE students(
    StudentID int not null AUTO_INCREMENT,
    FirstName varchar(100) NOT NULL,
    Surname varchar(100) NOT NULL,
    PRIMARY KEY (StudentID)
);

INSERT INTO students(FirstName, Surname)
VALUES("John", "Andersen"), ("Emma", "Smith");  
