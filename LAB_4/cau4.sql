CREATE OR REPLACE TRIGGER TINH_TONG_TRIGIA
BEFORE INSERT OR UPDATE ON CTHD
FOR EACH ROW
DECLARE
    TOTAL_TRIGIA HOADON.TRIGIA%TYPE;
BEGIN
        SELECT :NEW.SL * GIA
        INTO TOTAL_TRIGIA
        FROM SANPHAM
        WHERE :NEW.MASP = SANPHAM.MASP;      
        UPDATE HOADON
        SET TRIGIA = TRIGIA+TOTAL_TRIGIA
        WHERE SOHD = :NEW.SOHD;
END;
/
CREATE OR REPLACE TRIGGER TINH_TONG_TRIGIA_DEL
AFTER DELETE ON CTHD
FOR EACH ROW
DECLARE 
    TOTAL_TRIGIA HOADON.TRIGIA%TYPE;
BEGIN 
    SELECT SUM(:OLD.SL * GIA)
        INTO TOTAL_TRIGIA
        FROM SANPHAM
        WHERE :OLD.MASP = SANPHAM.MASP ;
    UPDATE HOADON SET TRIGIA=TRIGIA-TOTAL_TRIGIA WHERE HOADON.SOHD=:OLD.SOHD;
END;
/*
+--------+-------+-----+-----------+
|  Bảng  | Thêm  | Xóa |    sửa    |
+--------+-------+-----+-----------+
| HOADON | +     |   - | +(TRIGIA) |
+--------+-------+-----+-----------+
*/