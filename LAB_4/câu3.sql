CREATE OR REPLACE TRIGGER trg_check_cthd
BEFORE INSERT OR UPDATE ON hoadon
FOR EACH ROW
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM CTHD WHERE SOHD = :NEW.SOHD;
  
  IF (v_count = 0) THEN
    RAISE_APPLICATION_ERROR(-20001, 'Mỗi hóa đơn phải có ít nhất một chi tiết hóa đơn!');
  END IF;
END;

+---------------+------+-----+---------+
| Tên ràng buột | THÊM | XÓA |   SỬA   |
+---------------+------+-----+---------+
| HOADON        |   +  |  -  | +(SOHD) |
+---------------+------+-----+---------+
| CTHD          |   -  |  +  |    -    |
+---------------+------+-----+---------+