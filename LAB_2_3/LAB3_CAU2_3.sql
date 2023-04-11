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