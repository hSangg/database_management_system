SET SERVEROUTPUT ON;
SELECT * FROM GRADE;
DECLARE
  student_code STUDENT.STUDENTID%TYPE;
  class_code CLASS.CLASSID%TYPE;
  grade_ CHAR(1);
BEGIN
  -- nhap ma sinh vien va ma lop
  student_code := '&Nhap_STUDENTID';
  class_code := '&Nhap_CLASSID';
  
  -- lay diem chu dua tren ma sinh vien va ma lop
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

  -- In ra ?i?m ch?
  DBMS_OUTPUT.PUT_LINE('Diem chu cua sinh vien ' || student_code || ' trong lop ' || class_code || ' la ' || grade_);
  
EXCEPTION
  -- ngoai le
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('khong tim thay du lieu cua sinh vien ' || student_code || ' trong lop ' || class_code);
    
  -- Xu li ngoai le khi gap loi
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('loi: ' || SQLERRM);
END;