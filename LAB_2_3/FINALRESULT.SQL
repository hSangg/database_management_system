--LAB2

--7)
SELECT
    LAST_NAME AS EMPLOYEE_NAME,
    SALARY    AS MONTHLY_SALARY
FROM
    S_EMP
WHERE
    DEPT_ID IN (31,
    42,
    50)
    AND SALARY >1350;

--8)
SELECT
    LAST_NAME,
    START_DATE
FROM
    S_EMP
WHERE
    EXTRACT(YEAR FROM START_DATE)=1991;

--9)
SELECT
    ID,
    LAST_NAME,
    COMMISSION_PCT
FROM
    S_EMP
WHERE
    COMMISSION_PCT=15;

--10)
SELECT
    LAST_NAME,
    START_DATE,
    TO_CHAR(ADD_MONTHS(TRUNC(START_DATE,
    'MM'),
    6)+8-MOD(TO_NUMBER(TO_CHAR(ADD_MONTHS(TRUNC(START_DATE,
    'MM'),
    6) + 8,
    'D')),
    7),
    'fmMonth DDth YYYY') AS NEXT_REVIEW_DATE
FROM
    S_EMP;


--12
SELECT
    LAST_NAME,
    FLOOR(MONTHS_BETWEEN(SYSDATE,
    START_DATE)) AS EXP
FROM
    S_EMP
ORDER BY
    EXP;

--13
SELECT
    COUNT(COUNT(*)) AS TOTAL_MANAGER
FROM
    S_EMP
GROUP BY
    MANAGER_ID
HAVING
    MANAGER_ID IS NOT NULL;

--14
SELECT
    MAX(TOTAL) AS HIGHEST,
    MIN(TOTAL) AS LOWEST
FROM
    S_ORD;

--15
SELECT
    PD.NAME,
    PD.ID,
    QUANTITY AS ORDERED
FROM
    S_PRODUCT PD,
    S_ORD     OD,
    S_ITEM    IT
WHERE
    IT.ORD_ID = OD.ID
    AND OD.ID = 101;

--16
SELECT
    S_CUSTOMER.ID,
    S_ORD.ID
FROM
    S_CUSTOMER
    LEFT JOIN S_ORD
    ON S_CUSTOMER.ID=S_ORD.CUSTOMER_ID
ORDER BY
    S_CUSTOMER.ID;

--LAB 3 _ BAI 1 _ CAU 2 _ 3

--cau 2
DECLARE
    v_n NUMBER := &p_n;
    v_count NUMBER := 0;
    v_i NUMBER := 2;
    v_is_prime BOOLEAN := TRUE;
BEGIN
    WHILE v_count < v_n LOOP
        v_is_prime := TRUE;
        FOR j IN 2..v_i-1 LOOP
            IF v_i MOD j = 0 THEN
                v_is_prime := FALSE;
                EXIT;
            END IF;
        END LOOP;
        
        IF v_is_prime THEN
            DBMS_OUTPUT.PUT_LINE(v_i);
            v_count := v_count + 1;
        END IF;
        
        v_i := v_i + 1;
    END LOOP;
END;

--cau 3
DECLARE
    v_a NUMBER := &p_a;
    v_b NUMBER := &p_b;
    v_c NUMBER := &p_c;
    v_delta NUMBER;
BEGIN
    -- Tính delta
    v_delta := v_b * v_b - 4 * v_a * v_c;
    
    IF v_delta < 0 THEN
        DBMS_OUTPUT.PUT_LINE('Phuong trinh vo nghiem');
    ELSIF v_delta = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Phuong trinh co nghiem kep x = ' || (-v_b/(2*v_a)));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Phuong trinh co 2 nghiem phan biet');
        DBMS_OUTPUT.PUT_LINE('x1 = ' || ((-v_b + sqrt(v_delta))/(2*v_a)));
        DBMS_OUTPUT.PUT_LINE('x2 = ' || ((-v_b - sqrt(v_delta))/(2*v_a)));
    END IF;
END;

--LAB3 _ BAI 2 _ CAU 3

-- cau 3.2
DECLARE
    v_student_id NUMBER;
    v_student_name VARCHAR2(50);
    v_class_count NUMBER;
BEGIN
    
    v_student_id := &p_student_id;
    
    
    SELECT FIRSTNAME || ' ' || LASTNAME INTO v_student_name
    FROM STUDENT
    WHERE STUDENTID = v_student_id;
    
    
    SELECT COUNT(*) INTO v_class_count
    FROM ENROLLMENT
    WHERE STUDENTID = v_student_id;
    
   
    DBMS_OUTPUT.PUT_LINE('Sinh viên ' || v_student_name || ' có mã số ' || v_student_id || ' đang học ' || v_class_count || ' lớp.');
EXCEPTION
    
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Sinh viên có mã số ' || v_student_id || ' chưa tồn tại.');
       
        v_student_name := '&p_student_firstname' || ' ' || '&p_student_lastname';
        INSERT INTO STUDENT (STUDENTID, FIRSTNAME, LASTNAME, ADDRESS)
        VALUES (v_student_id, '&p_student_firstname', '&p_student_lastname', '&p_student_address');
        DBMS_OUTPUT.PUT_LINE('Đã thêm mới sinh viên ' || v_student_name);
END;

-- LAB 3 _ BAI 3 _ CAU 2

SET SERVEROUTPUT ON;
SELECT * FROM GRADE;
DECLARE
  student_code STUDENT.STUDENTID%TYPE;
  class_code CLASS.CLASSID%TYPE;
  grade_ CHAR(1);
BEGIN
  
  student_code := '&Nhap_STUDENTID';
  class_code := '&Nhap_CLASSID';
  
 
  SELECT
    CASE
      WHEN GRADE >= 90 THEN 'A'
      WHEN GRADE >= 80 AND GRADE < 90 THEN 'B'
      WHEN GRADE >= 70 AND GRADE < 80 THEN 'C'
      WHEN GRADE >= 50 AND GRADE < 70 THEN 'D'
      ELSE 'F'
    END
  INTO grade_
  FROM GRADE
  WHERE student_code = STUDENTID AND CLASSID = class_code;


  DBMS_OUTPUT.PUT_LINE('Diem chu cua sinh vien ' || student_code || ' trong lop ' || class_code || ' la ' || grade_);
  
EXCEPTION
 
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('khong tim thay du lieu cua sinh vien ' || student_code || ' trong lop ' || class_code);
    
 
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('loi: ' || SQLERRM);
END;