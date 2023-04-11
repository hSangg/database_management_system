CREATE TABLE COURSE (
  CourseNo INT PRIMARY KEY,
  Description VARCHAR(255),
  Cost DECIMAL(10,2),
  Prerequisite VARCHAR(255),
  CreatedBy INT,
  CreatedDate DATETIME,
  ModifiedBy INT,
  ModifiedDate DATETIME
);

CREATE TABLE STUDENT (
  StudentID INT PRIMARY KEY,
  Salutation VARCHAR(10),
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  Address VARCHAR(255),
  Phone VARCHAR(20),
  Employer VARCHAR(50),
  RegistrationDate DATETIME,
  CreatedBy INT,
  CreatedDate DATETIME,
  ModifiedBy INT,
  ModifiedDate DATETIME
);

CREATE TABLE CLASS (
  ClassID INT PRIMARY KEY,
  CourseNo INT,
  ClassNo INT,
  StartDateTime DATETIME,
  Location VARCHAR(255),
  InstructorID INT,
  Capacity INT,
  CreatedBy INT,
  CreatedDate DATETIME,
  ModifiedBy INT,
  ModifiedDate DATETIME,
  FOREIGN KEY (CourseNo) REFERENCES COURSE(CourseNo),
  FOREIGN KEY (InstructorID) REFERENCES INSTRUCTOR(InstructorID)
);

CREATE TABLE ENROLLMENT (
  StudentID INT,
  ClassID INT,
  EnrollDate DATETIME,
  FinalGrade VARCHAR(10),
  CreatedBy INT,
  CreatedDate DATETIME,
  ModifiedBy INT,
  ModifiedDate DATETIME,
  PRIMARY KEY (StudentID, ClassID),
  FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
  FOREIGN KEY (ClassID) REFERENCES CLASS(ClassID)
);

CREATE TABLE INSTRUCTOR (
  InstructorID INT PRIMARY KEY,
  Salutation VARCHAR(10),
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  Address VARCHAR(255),
  Phone VARCHAR(20),
  CreatedBy INT,
  CreatedDate DATETIME,
  ModifiedBy INT,
  ModifiedDate DATETIME
);

CREATE TABLE GRADE (
  StudentID INT,
  ClassID INT,
  Grade VARCHAR(10),
  Comments VARCHAR(255),
  CreatedBy INT,
  CreatedDate DATETIME,
  ModifiedBy INT,
  ModifiedDate DATETIME,
  PRIMARY KEY (StudentID, ClassID),
  FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
  FOREIGN KEY (ClassID) REFERENCES CLASS(ClassID)
);
