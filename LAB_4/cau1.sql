<<<<<<< HEAD
CREATE OR REPLACE TRIGGER "TRG_INSERT_NGHD"
BEFORE INSERT ON "HOADON"
FOR EACH ROW
DECLARE
  v_ngdk DATE;
BEGIN
  SELECT NGDK INTO v_ngdk FROM KHACHHANG WHERE MAKH = :NEW.MAKH;
  IF (v_ngdk IS NOT NULL AND :NEW.NGHD < v_ngdk) THEN
    RAISE_APPLICATION_ERROR(-20001, 'Ngày mua hàng phải lớn hơn hoặc bằng ngày đăng ký thành viên!');
  END IF;
END;
/

--bang tam anh huong
/*
+-----------+------+-----+---------+
|   Bảng    | thêm | xóa |   sửa   |
+-----------+------+-----+---------+
| HOADON    | +    |   - | +(NGHD) |
+-----------+------+-----+---------+
*/
=======

--1
CREATE OR REPLACE TRIGGER TG_1
AFTER UPDATE OR INSERT ON HOADON
FOR EACH ROW 
DECLARE 
    NGHD1 HOADON.NGHD%TYPE;
    NGDK1 KHACHHANG.NGDK%TYPE;
    MAKH1 HOADON.MAKH%TYPE;
BEGIN
    SELECT NGDK INTO NGDK1 FROM KHACHHANG WHERE MAKH=:NEW.MAKH;
    IF NGDK1>:NEW.NGHD THEN
      RAISE_APPLICATION_ERROR(-20001, 'Ngày mua hàng phải lớn hơn hoặc bằng ngày đăng ký thành viên.');
      END IF;
    END;


    --bang tam anh huong
/*
+-----------+------+-----+---------+
|   Bảng    | thêm | xóa |   sửa   |
+-----------+------+-----+---------+
| HOADON    | +    |   - | +(NGHD) |
+-----------+------+-----+---------+
*/
>>>>>>> 215e2c88b2d6be56608c6544915221ced0428b65
