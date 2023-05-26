--4.1
CREATE OR REPLACE PROCEDURE sp_ThongTinDocGia (p_ma_docgia IN NUMBER) IS
  v_count_nguoilon NUMBER;
  v_count_treem NUMBER;
  v_ma_docgia_nguoilon NUMBER;
BEGIN
  -- Check if nguoilon exists
  SELECT COUNT(*)
  INTO v_count_nguoilon
  FROM nguoilon
  WHERE ma_docgia = p_ma_docgia;
  
  -- Check if treem exists
  SELECT COUNT(*)
  INTO v_count_treem
  FROM treem
  WHERE ma_docgia = p_ma_docgia;
  
  IF v_count_nguoilon > 0 THEN
   
    SELECT ma_docgia
    INTO v_ma_docgia_nguoilon
    FROM nguoilon
    WHERE ma_docgia = p_ma_docgia;
    
    FOR nguoilon_rec IN (
    SELECT dg.ma_docgia, dg.ho, dg.tenlot, dg.ten,dg.ngaysinh,n.sonha,n.duong,n.quan,n.dienthoai,n.han_sd
    FROM docgia dg inner join nguoilon n on dg.ma_docgia=n.ma_docgia
    WHERE dg.ma_docgia = v_ma_docgia_nguoilon
  ) LOOP

    DBMS_OUTPUT.PUT_LINE('Ma doc gia: ' || nguoilon_rec.ma_docgia);
    DBMS_OUTPUT.PUT_LINE('Ho: ' || nguoilon_rec.ho);
    DBMS_OUTPUT.PUT_LINE('Ten lot: ' || nguoilon_rec.tenlot);
    DBMS_OUTPUT.PUT_LINE('So nha: ' || nguoilon_rec.ten);
    DBMS_OUTPUT.PUT_LINE('Ngay sinh: ' || nguoilon_rec.ngaysinh);
    DBMS_OUTPUT.PUT_LINE('So nha: ' || nguoilon_rec.sonha);
    DBMS_OUTPUT.PUT_LINE('Duong: ' || nguoilon_rec.duong);
    DBMS_OUTPUT.PUT_LINE('Quan: ' || nguoilon_rec.quan);
    DBMS_OUTPUT.PUT_LINE('?ien thoai: ' || nguoilon_rec.dienthoai);
    DBMS_OUTPUT.PUT_LINE('Han_sd: ' || nguoilon_rec.han_sd);
  END LOOP;
  
  ELSIF v_count_treem > 0 THEN
    
    FOR treem_rec IN (SELECT dg.ma_docgia, dg.ho, dg.tenlot, dg.ten,te.ma_docgia_nguoilon
                      FROM docgia dg
                      INNER JOIN treem te ON te.ma_docgia = dg.ma_docgia
                      WHERE te.ma_docgia = p_ma_docgia) 
LOOP
 DBMS_OUTPUT.PUT_LINE('Ma doc gia: ' || treem_rec.ma_docgia);
    DBMS_OUTPUT.PUT_LINE('Ho: ' || treem_rec.ho);
    DBMS_OUTPUT.PUT_LINE('Ten lot: ' || treem_rec.tenlot);
    DBMS_OUTPUT.PUT_LINE('Ten: ' || treem_rec.ten);
      DBMS_OUTPUT.PUT_LINE('Ma doc gia cua nguoi lon: ' || treem_rec.ma_docgia_nguoilon);
    END LOOP;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Khong tim thay thong tin cho ?oc gia co ma: ' || p_ma_docgia);
  END IF;
END;

begin
sp_thongtindocgia(2);
end;

--4.3
CREATE OR REPLACE PROCEDURE sp_ThongtinNguoilonDangmuon
IS


    CURSOR cur_DocGiaNguoiLonDangMuon
    IS
        SELECT DISTINCT d.ma_DocGia, d.ho, d.tenlot, d.ten, d.NGAYSINH
        FROM DOCGIA d
        INNER JOIN NGUOILON nl ON d.ma_DocGia = nl.ma_DocGia
        INNER JOIN MUON m ON d.ma_DocGia = m.ma_DocGia;

    docgia_info DOCGIA%ROWTYPE;

BEGIN

    OPEN cur_DocGiaNguoiLonDangMuon;

    LOOP
        FETCH cur_DocGiaNguoiLonDangMuon INTO docgia_info;
        EXIT WHEN cur_DocGiaNguoiLonDangMuon%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Mã ??c gi?: ' || docgia_info.ma_DocGia);
        DBMS_OUTPUT.PUT_LINE('H? và tên: ' || docgia_info.ho || ' ' || docgia_info.tenlot || ' ' || docgia_info.ten);
        DBMS_OUTPUT.PUT_LINE('Ngày sinh: ' || TO_CHAR(docgia_info.ngaysinh));
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    END LOOP;


    CLOSE cur_DocGiaNguoiLonDangMuon;
END;
--4.5
CREATE OR REPLACE PROCEDURE sp_ThongtinNguoilonDangmuon
IS


    CURSOR cur_DocGiaNguoiLonDangMuon
    IS
        SELECT DISTINCT d.ma_DocGia, d.ho, d.tenlot, d.ten, d.NGAYSINH
        FROM DOCGIA d
        INNER JOIN NGUOILON nl ON d.ma_DocGia = nl.ma_DocGia
        INNER JOIN MUON m ON d.ma_DocGia = m.ma_DocGia;

    docgia_info DOCGIA%ROWTYPE;

BEGIN

    OPEN cur_DocGiaNguoiLonDangMuon;

    LOOP
        FETCH cur_DocGiaNguoiLonDangMuon INTO docgia_info;
        EXIT WHEN cur_DocGiaNguoiLonDangMuon%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Mã ??c gi?: ' || docgia_info.ma_DocGia);
        DBMS_OUTPUT.PUT_LINE('H? và tên: ' || docgia_info.ho || ' ' || docgia_info.tenlot || ' ' || docgia_info.ten);
        DBMS_OUTPUT.PUT_LINE('Ngày sinh: ' || TO_CHAR(docgia_info.ngaysinh));
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    END LOOP;


    CLOSE cur_DocGiaNguoiLonDangMuon;
END;

--4.7
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

--4.9
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
--4.11
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE sp_XoaDocGia (
  p_ma_docgia IN NUMBER
) AS
  v_exists_docgia NUMBER;
  v_exists_muon NUMBER;
  v_exists_nguoilon NUMBER;
  v_exists_treem NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_exists_docgia
  FROM docgia
  WHERE p_ma_docgia = ma_docgia;
  
  IF v_exists_docgia > 0 THEN
    SELECT COUNT(*) INTO v_exists_muon
    FROM muon
    WHERE p_ma_docgia = ma_docgia;
    
    IF v_exists_muon > 0 THEN
      DBMS_OUTPUT.PUT_LINE('Không th? xóa ??c gi? ???c.');
    ELSE
      SELECT COUNT(*) INTO v_exists_nguoilon
      FROM nguoilon nl
      WHERE nl.ma_docgia = p_ma_docgia;
      
      IF v_exists_nguoilon > 0 THEN
        SELECT COUNT(*) INTO v_exists_treem
        FROM treem te
        WHERE te.ma_docgia_nguoilon = p_ma_docgia;
        
        IF v_exists_treem > 0 THEN
          DELETE FROM treem WHERE ma_docgia_nguoilon = p_ma_docgia;
          DELETE FROM nguoilon WHERE ma_docgia = p_ma_docgia;
          DELETE FROM dangky WHERE ma_docgia = p_ma_docgia;
          DELETE FROM quatrinhmuon WHERE ma_docgia = p_ma_docgia;
          DELETE FROM docgia WHERE ma_docgia = p_ma_docgia;
        ELSE
          DELETE FROM nguoilon WHERE ma_docgia = p_ma_docgia;
          DELETE FROM dangky WHERE ma_docgia = p_ma_docgia;
          DELETE FROM quatrinhmuon WHERE ma_docgia = p_ma_docgia;
          DELETE FROM docgia WHERE ma_docgia = p_ma_docgia;
        END IF;
      END IF;
      SELECT COUNT(*) INTO v_exists_treem
        FROM treem te
        WHERE te.ma_docgia = p_ma_docgia;
      IF v_exists_treem > 0 THEN
        DELETE FROM treem WHERE ma_docgia = p_ma_docgia;
        DELETE FROM dangky WHERE ma_docgia = p_ma_docgia;
        DELETE FROM quatrinhmuon WHERE ma_docgia = p_ma_docgia;
        DELETE FROM docgia WHERE ma_docgia = p_ma_docgia;
      END IF;
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Không t?n t?i ??c gi?.');
  END IF;
END;

--4.6

CREATE OR REPLACE PROCEDURE sp_CapNhatTrangThaiDauSach (
  isbn IN NUMBER
) AS
  soluong NUMBER;
BEGIN
  SELECT COUNT(*) INTO soluong
  FROM dausach ds, cuonsach cs, tuasach ts
  WHERE ds.isbn = sp_CapNhatTrangThaiDauSach.isbn
  AND ds.ma_tuasach = ts.ma_tuasach
  AND ds.isbn = cs.isbn
  AND cs.tinhtrang = 'Y';
  
  IF soluong = 0 THEN
    UPDATE Dausach
    SET trangthai = 'N'
    WHERE isbn = sp_CapNhatTrangThaiDauSach.isbn;
  ELSE
    UPDATE Dausach
    SET trangthai = 'Y'
    WHERE isbn = sp_CapNhatTrangThaiDauSach.isbn;
  END IF;
END;
/

--4.13
CREATE OR REPLACE PROCEDURE sp_TraSach (
  isbn IN NUMBER,
  ma_cuonsach IN NUMBER,
  ma_docgia IN NUMBER
) AS
  ngayGio_muon smalldatetime;
  ngay_hethan smalldatetime;
  ngayGio_tra smalldatetime;
  tien_muon NUMBER;
  tien_datra NUMBER;
  tien_datcoc NUMBER;
  ghichu VARCHAR2(255);
  ngay_quahan NUMBER;
  tien_phat NUMBER;
BEGIN
  SELECT ngayGio_muon, ngay_hethan
  INTO ngayGio_muon, ngay_hethan
  FROM Muon
  WHERE isbn = sp_TraSach.isbn
  AND ma_cuonsach = sp_TraSach.ma_cuonsach
  AND ma_docgia = sp_TraSach.ma_docgia;
  
  tien_muon := 0;
  ngayGio_tra := SYSDATE;

  ngay_quahan := ngay_hethan - ngayGio_tra;

  IF ngay_quahan > 0 THEN
    tien_phat := 1000 * ngay_quahan;
  END IF;
  
  tien_muon := tien_muon + tien_phat;
  
  -- Them vao bang qua trinh muon
  INSERT INTO QuaTrinhMuon
  VALUES (isbn, ma_cuonsach, ngayGio_muon, ma_docgia, ngay_hethan, ngayGio_tra, tien_muon, tien_datra, tien_datcoc, ghichu);
  
  -- Xoa du lieu trong bang muon
  DELETE FROM Muon
  WHERE isbn = sp_TraSach.isbn
  AND ma_cuonsach = sp_TraSach.ma_cuonsach
  AND ma_docgia = sp_TraSach.ma_docgia;

  UPDATE CuonSach
  SET TinhTrang = 'N'
  WHERE isbn = sp_TraSach.isbn
  AND Ma_CuonSach = sp_TraSach.ma_cuonsach;
  
  -- Thực thi stored procedure sp_CapNhatTrangThaiDauSach
  EXEC sp_CapNhatTrangThaiDauSach(isbn);
END;
/

--Trigger 1
CREATE OR REPLACE TRIGGER tg_delMuon 
AFTER DELETE ON Muon

FOR EACH ROW
DECLARE
DEL_ISBN VARCHAR(10);   
DEL_MA_CUONSACH VARCHAR(10);

BEGIN
DEL_ISBN := :OLD.isbn;
DEL_MA_CUONSACH := :OLD.ma_cuonsach;
UPDATE Cuonsach SET tinhtrang = 'N'
WHERE isbn = DEL_ISBN
AND ma_cuonsach = DEL_MA_CUONSACH;
END;


--Trigger 2
CREATE OR REPLACE TRIGGER tg_insMuon 
BEFORE INSERT ON Muon
FOR EACH ROW
DECLARE 
INS_ISBN VARCHAR(10); 
INS_MA_CUONSACH VARCHAR(10);
BEGIN
INS_ISBN := :NEW.isbn;
INS_MA_CUONSACH := :NEW.ma_cuonsach;
UPDATE Cuonsach 
SET tinhtrang = 'Y'
WHERE isbn = INS_ISBN
AND ma_cuonsach = INS_MA_CUONSACH;
END;


--Trigger 3

CREATE OR REPLACE TRIGGER trg_updCuonSach
AFTER UPDATE ON cuonsach
FOR EACH ROW

  DECLARE
    ma_tuasach_var DAUSACH.ma_tuasach%TYPE;
  BEGIN
    SELECT ma_tuasach INTO ma_tuasach_var
    FROM DAUSACH
    WHERE DAUSACH.isbn = :NEW.isbn;
    -- C?p nh?t tr?ng thái c?a ??u sách d?a trên tình tr?ng cu?n sách m?i
    UPDATE DAUSACH
    SET trangthai = :NEW.tinhtrang
    WHERE DAUSACH.ma_tuasach = ma_tuasach_var;
END;
/
