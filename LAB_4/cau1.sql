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