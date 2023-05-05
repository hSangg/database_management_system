-------------------- TH 2--------------------------
-------------------- TH2.3-------------------------
CREATE TABLE COURSE (
    CourseNo NUMBER(8,0) PRIMARY KEY,
    Description VARCHAR2(50),
    Cost NUMBER(9,2),
    Prerequisite NUMBER(8,0),
    CreatedBy VARCHAR2(30),
    CreatedDate DATE,
    ModifiedBy VARCHAR2(30),
    ModifiedDate DATE
);

CREATE TABLE STUDENT (
    StudentID NUMBER(8,0) PRIMARY KEY,
    Salutation VARCHAR2(5),
    FirstName VARCHAR2(25),
    LastName VARCHAR2(25),
    Address VARCHAR2(50),
    Phone VARCHAR2(15),
    Employer VARCHAR2(50),
    RegistrationDate DATE,
    CreatedBy VARCHAR2(30),
    CreatedDate DATE,
    ModifiedBy VARCHAR2(30),
    ModifiedDate DATE
);

CREATE TABLE CLASS (
    ClassID NUMBER(8,0) PRIMARY KEY,
    CourseNo NUMBER(8,0),
    ClassNo NUMBER(3),
    StartDateTime DATE,
    Location VARCHAR2(50),
    InstructorID NUMBER(8,0),
    Capacity NUMBER(3,0),
    CreatedBy VARCHAR2(30),
    CreatedDate DATE,
    ModifiedBy VARCHAR2(30),
    ModifiedDate DATE,
    CONSTRAINT fk_course_class FOREIGN KEY (CourseNo) REFERENCES COURSE(CourseNo),
    CONSTRAINT fk_instructor_class FOREIGN KEY (InstructorID) REFERENCES INSTRUCTOR(InstructorID)
);

CREATE TABLE ENROLLMENT (
    StudentID NUMBER(8,0),
    ClassID NUMBER(8,0),
    EnrollDate DATE,
    FinalGrade NUMBER(3,0),
    CreatedBy VARCHAR2(30),
    CreatedDate DATE,
    ModifiedBy VARCHAR2(30),
    ModifiedDate DATE,
    CONSTRAINT pk_enrollment PRIMARY KEY (StudentID, ClassID),
    CONSTRAINT fk_student_enrollment FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
    CONSTRAINT fk_class_enrollment FOREIGN KEY (ClassID) REFERENCES CLASS(ClassID)
);

CREATE TABLE INSTRUCTOR (
    InstructorID NUMBER(8,0) PRIMARY KEY,
    Salutation VARCHAR2(5),
    FirstName VARCHAR2(25),
    LastName VARCHAR2(25),
    Address VARCHAR2(50),
    Phone VARCHAR2(15),
    CreatedBy VARCHAR2(30),
    CreatedDate DATE,
    ModifiedBy VARCHAR2(30),
    ModifiedDate DATE
);

CREATE TABLE GRADE (
    StudentID NUMBER(8),
    ClassID NUMBER(8),
    Grade NUMBER(3),
    Comments VARCHAR2(2000),
    CreatedBy VARCHAR2(30),
    CreatedDate DATE,
    ModifiedBy VARCHAR2(30),
    ModifiedDate DATE,
    CONSTRAINT pk_grade PRIMARY KEY (StudentID, ClassID),
    CONSTRAINT fk_student_grade FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
    CONSTRAINT fk_class_grade FOREIGN KEY (ClassID) REFERENCES CLASS(ClassID)
);

-------------------- TH2.4-------------------------

DECLARE
  v_username VARCHAR2(30);
BEGIN
  
  FOR i IN 1..20 LOOP
    v_username := 'user' || TO_CHAR(i, 'FM00');
    EXECUTE IMMEDIATE 'CREATE USER ' || v_username || ' IDENTIFIED BY 123456';
  END LOOP;

  
  EXECUTE IMMEDIATE 'CREATE ROLE Role_QUANTRI';
  EXECUTE IMMEDIATE 'GRANT CREATE TABLE TO Role_QUANTRI';
  EXECUTE IMMEDIATE 'GRANT ALL PRIVILEGES TO Role_QUANTRI';
  EXECUTE IMMEDIATE 'CREATE ROLE Role_NGUOIDUNG';
  EXECUTE IMMEDIATE 'GRANT SELECT ANY TABLE TO Role_NGUOIDUNG';

 
  FOR i IN 1..10 LOOP
    v_username := 'user' || TO_CHAR(i, 'FM00');
    EXECUTE IMMEDIATE 'GRANT Role_QUANTRI TO ' || v_username;
  END LOOP;

  
  FOR i IN 11..20 LOOP
    v_username := 'user' || TO_CHAR(i, 'FM00');
    EXECUTE IMMEDIATE 'GRANT Role_NGUOIDUNG TO ' || v_username;
  END LOOP;

  
  FOR v_username IN ('user01', 'user03', 'user05') LOOP
    EXECUTE IMMEDIATE 'REVOKE Role_QUANTRI FROM ' || v_username;
  END LOOP;
END;




-------------------- TH 3--------------------------
-------------------- TH3.4-------------------------

DECLARE
    CURSOR Y IS
        SELECT
            DISTINCT COURSENO
        FROM
            COURSE;
    COURSE_ID     COURSE.COURSENO%TYPE;
    COURSE_NAME   COURSE.DESCRIPTION%TYPE;
    CLASS_ID      CLASS.CLASSID%TYPE;
    COUNT_STUDENT NUMBER;
    CURSOR X(COURSE_ID_INPUT COURSE.COURSENO%TYPE) IS
        (
            SELECT
                CLASS.CLASSID,
                CLASS.COURSENO,
                COUNT(CLASS.CLASSID) AS SO_LUONG_SINH_VIEN
            FROM
                CLASS,
                ENROLLMENT
            WHERE
                (CLASS.CLASSID = ENROLLMENT.CLASSID)
                AND (COURSENO = COURSE_ID_INPUT)
            GROUP BY
                CLASS.CLASSID,
                CLASS.COURSENO
        );
BEGIN
    OPEN Y;
    LOOP
        FETCH Y INTO COURSE_ID;
        EXIT WHEN Y%NOTFOUND;
        OPEN X(COURSE_ID);
        LOOP
            FETCH X INTO CLASS_ID, COURSE_ID, COUNT_STUDENT;
            SELECT
                COURSE.DESCRIPTION INTO COURSE_NAME
            FROM
                COURSE
            WHERE
                COURSE.COURSENO =COURSE_ID;
            DBMS_OUTPUT.PUT_LINE(COURSE_NAME
                ||COURSE_ID );
        END LOOP;
    END LOOP;
END;
-------------------- TH3.5-------------------------
CREATE OR REPLACE PROCEDURE find_sname (
    i_student_id IN NUMBER,
    o_first_name OUT VARCHAR2,
    o_last_name OUT VARCHAR2
)
AS
BEGIN
    SELECT FirstName, LastName 
    INTO o_first_name, o_last_name
    FROM STUDENT 
    WHERE StudentID = i_student_id;
END;

CREATE OR REPLACE PROCEDURE print_student_name (
    i_student_id IN NUMBER
)
AS
    first_name VARCHAR2(50);
    last_name VARCHAR2(50);
BEGIN
    find_sname(i_student_id, first_name, last_name);
    dbms_output.put_line('Student name: ' || first_name || ' ' || last_name);
END;


CREATE OR REPLACE PROCEDURE Discount
AS
BEGIN
    FOR course_rec IN (
        SELECT CourseNo, COUNT(*) AS num_students
        FROM ENROLLMENT 
        INNER JOIN CLASS ON ENROLLMENT.ClassID = CLASS.ClassID
        GROUP BY CourseNo
        HAVING COUNT(*) > 15
    )
    LOOP
        UPDATE COURSE 
        SET Cost = Cost * 0.95
        WHERE CourseNo = course_rec.CourseNo;
        dbms_output.put_line('Discount applied to course: ' || (SELECT Description FROM COURSE WHERE CourseNo = course_rec.CourseNo));
    END LOOP;
END;

CREATE OR REPLACE FUNCTION Total_cost_for_student(
    i_student_id IN NUMBER
)
RETURN NUMBER
AS
    total_cost NUMBER;
BEGIN
    SELECT SUM(Cost) 
    INTO total_cost
    FROM ENROLLMENT 
    INNER JOIN CLASS ON ENROLLMENT.ClassID = CLASS.ClassID
    INNER JOIN COURSE ON CLASS.CourseNo = COURSE.CourseNo
    WHERE StudentID = i_student_id;
    RETURN total_cost;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;

-------------------- TH3.6-------------------------
CREATE OR REPLACE TRIGGER trg_add_user_and_date
BEFORE INSERT OR UPDATE ON SCHEMA
FOR EACH ROW
BEGIN
    :NEW.modified_by := USER;
    :NEW.modified_date := SYSDATE;
    IF INSERTING THEN
        :NEW.created_by := USER;
        :NEW.created_date := SYSDATE;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_check_course_limit
BEFORE INSERT ON registration
FOR EACH ROW
DECLARE
    course_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO course_count
    FROM registration
    WHERE student_id = :NEW.student_id;
    
    IF course_count >= 4 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Khong the dang ki hon 4 khoa hoc');
    END IF;
END;
/
