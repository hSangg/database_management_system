
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

CREATE OR REPLACE TRIGGER TG_2
AFTER UPDATE OR INSERT ON KHACHHANG
FOR EACH ROW 
DECLARE 
    NGHD1 HOADON.NGHD%TYPE;
    NGDK1 KHACHHANG.NGDK%TYPE;
    MAKH1 HOADON.MAKH%TYPE;
BEGIN
    SELECT NGHD INTO NGHD1 FROM HOADON WHERE MAKH=:NEW.MAKH;
    IF :NEW.NGDK>NGHD1 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Ngày mua hàng phải lớn hơn hoặc bằng ngày đăng ký thành viên.');
      END IF;
    END;
    --bang tam anh huong
/*
+-----------+------+-----+---------+
|   Bảng    | thêm | xóa |   sửa   |
+-----------+------+-----+---------+
| KHACHHANG | +    |   - | +(NGHD) |
| HOADON    | +    |   - | +(NGDK) |
+-----------+------+-----+---------+
*/
