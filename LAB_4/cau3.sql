CREATE OR REPLACE TRIGGER "TRG_CTHD_MINIMUM"
BEFORE INSERT ON "HOADON"
FOR EACH ROW
DECLARE
  v_count NUMBER(10);
  v_hoadon_exists NUMBER(1);
BEGIN
  SELECT COUNT(*) INTO v_count FROM CTHD WHERE SOHD = :NEW.SOHD;
  IF (v_count = 0) THEN
    SELECT COUNT(*) INTO v_hoadon_exists FROM HOADON WHERE SOHD = :NEW.SOHD;
    IF (v_hoadon_exists > 0) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Mỗi một hóa đơn phải có ít nhất một chi tiết hóa đơn!');
    END IF;
  END IF;
END;
/

/*
+--------+-------+-----+-----------+
|  Bảng  | Thêm  | Xóa |    sửa    |
+--------+-------+-----+-----------+
| HOADON | +     |   - | +(TRIGIA) |
+--------+-------+-----+-----------+
*/