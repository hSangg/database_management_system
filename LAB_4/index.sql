--cau 1--
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

--cau 3--
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

--cau 4--
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

--V
/**
Trigger mutating thường được sử dụng trong các trường hợp như kiểm tra ràng
 buộc liên quan đến cả bảng gốc và bảng tham chiếu, hoặc tính toán giá 
 trị dựa trên các dòng được cập nhật hoặc xóa. Tuy nhiên, để giải quyết 
 vấn đề xung đột dữ liệu, bạn cần phải sử dụng các giải pháp đặc biệt 
 như sử dụng biến tạm thời (temporary variables), hoặc sử dụng các compound trigger.

Compound Trigger
Compound Trigger là một trigger mới được giới thiệu trong Oracle 11g, 
cho phép kết hợp các hành động của các trigger khác nhau vào trong một 
trigger duy nhất. Compound Trigger được sử dụng để thay thế các trigger 
đơn lẻ (single triggers) khi các trigger này gây ra tình trạng xung đột dữ liệu.

Ví dụ, trong một bảng có chứa các trường date_created, 
date_modified, ta muốn tự động cập nhật trường date_modified
 với giá trị ngày hiện tại mỗi khi có bản ghi được cập nhật. 
 Trong trường hợp này, ta có thể sử dụng một compound trigger
  để thực hiện nhiều hành động, bao gồm cả before update và after update.






















*/