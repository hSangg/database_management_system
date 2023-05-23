
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


