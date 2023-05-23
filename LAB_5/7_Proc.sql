CREATE OR REPLACE PROCEDURE sp_ThemTuaSach (
  p_tuasach VARCHAR2,
  p_tacgia VARCHAR2,
  p_tomtat VARCHAR2
)
AS
  p_ma_tuasach NUMBER;  
  v_count NUMBER;
BEGIN
  SELECT MAX(ma_tuasach) + 1 INTO p_ma_tuasach 
  FROM TUASACH;
  SELECT COUNT(*) INTO v_count
  FROM TUASACH
  WHERE p_tuasach = tuasach AND p_tacgia = tacgia AND p_tomtat = tomtat;
  IF(v_count <= 0) THEN
    INSERT INTO TUASACH(ma_tuasach, tuasach, tacgia, tomtat) VALUES (p_ma_tuasach, p_tuasach, p_tacgia, p_tomtat);
  ELSE 
    RAISE_APPLICATION_ERROR(-20001, 'ERROR');
    RETURN;
  END IF;
END;