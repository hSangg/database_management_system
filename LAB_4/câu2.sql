CREATE OR REPLACE TRIGGER CHECK_NGHD_EMP
BEFORE INSERT OR UPDATE ON HOADON
FOR EACH ROW
DECLARE
NGAY_VAO_LAM NHANVIEN.NGVL%TYPE;
BEGIN
    SELECT NGVL INTO NGAY_VAO_LAM FROM NHANVIEN WHERE NHANVIEN.MANV = :NEW.MANV;
    IF :NEW.NGHD < NGAY_VAO_LAM THEN
    RAISE_APPLICATION_ERROR(-20000,'Ngay ban hang phai sau ngay vao lam cua nhan vien');
    END IF;
END;


/*
+--------+------+-----+-----+
|  B?ng  | Thêm | Xóa | S?a |
+--------+------+-----+-----+
| HOADON | +    |   - | +   |
+--------+------+-----+-----+
*/