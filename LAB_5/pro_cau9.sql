CREATE OR REPLACE PROCEDURE sp_ThemNguoilon(
  p_ho IN DOCGIA.ho%TYPE,
  p_tenlot IN DOCGIA.tenlot%TYPE,
  p_ten IN DOCGIA.ten%TYPE,
  p_ngaysinh IN DOCGIA.ngaysinh%TYPE,
  p_sonha IN NGUOILON.sonha%TYPE,
  p_duong IN NGUOILON.duong%TYPE,
  p_quan IN NGUOILON.quan%TYPE,
  p_dienthoai IN NGUOILON.dienthoai%TYPE,
  p_han_sd IN NGUOILON.han_sd%TYPE
)
IS
  v_ma_DocGia DOCGIA.ma_DocGia%TYPE;
  v_tuoi NUMBER;
BEGIN
  SELECT NVL(MAX(ma_DocGia), 0) + 1
    INTO v_ma_DocGia
    FROM DOCGIA;

  INSERT INTO DOCGIA (ma_DocGia, ho, tenlot, ten, ngaysinh)
  VALUES (v_ma_DocGia, p_ho, p_tenlot, p_ten, p_ngaysinh);

  SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p_ngaysinh)
    INTO v_tuoi
    FROM DUAL;

  IF v_tuoi < 18 THEN
    DBMS_OUTPUT.PUT_LINE('Doc gia chua du 18 tuoi. Khong the them!');
    RETURN;
  END IF;

  INSERT INTO NGUOILON (ma_DocGia, sonha, duong, quan, dienthoai, han_sd)
  VALUES (v_ma_DocGia, p_sonha, p_duong, p_quan, p_dienthoai, p_han_sd);

  DBMS_OUTPUT.PUT_LINE('Them doc gia nguoi lon thanh cong!');
END;
/

SET SERVEROUTPUT ON;
BEGIN
  sp_ThemNguoilon('Nguyen', 'V', 'A', TO_DATE('2003-01-01', 'YYYY-MM-DD'), '123', 'ABC', '12', '0123456789', TO_DATE('2025-12-31', 'YYYY-MM-DD'));
END;