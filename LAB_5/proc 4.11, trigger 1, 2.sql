
--Trigger 1
CREATE OR REPLACE TRIGGER tg_delMuon 
ON Muon
AFTER DELETE
FOR EACH ROW
DECLARE
DEL_ISBN VARCHAR(10);   
DEL_MA_CUONSACH VARCHAR(10);
BELAGIN
BEGIN
DEL_ISBN = :OLD.isbn;
DEL_MA_CUONSACH = :OLD.ma_cuonsach;
UPDATE Cuonsach SET tinhtrang = 'yes'
WHERE isbn = DEL_ISBN
AND ma_cuonsach = DEL_MA_CUONSACH;
END;


--Trigger 2
CREATE OR REPLACE TRIGGER tg_insMuon 
ON Muon
AFTER INSERT
DECLARE 
INS_ISBN VARCHAR(10); 
INS_MA_CUONSACH VARCHAR(10);
BEGIN
INS_ISBN = :OLD.isbn;
INS_MA_CUONSACH = :OLD.ma_cuonsach;
UPDATE Cuonsach 
SET tinhtrang = 'no'
WHERE isbn = INS_ISBN
AND ma_cuonsach = INS_MA_CUON_SACH;
END;


--4.11
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE sp_XoaDocGia (
  ma_docgia IN NUMBER
) AS
BEGIN
  IF EXISTS (SELECT * FROM docgia WHERE ma_docgia = ma_docgia) THEN
    IF EXISTS (SELECT * FROM muon WHERE ma_docgia = ma_docgia) THEN
      DBMS_OUTPUT.PUT_LINE('Không th? xóa ??c gi? ???c.');
    ELSE
      IF EXISTS (SELECT * FROM nguoilon nl WHERE nl.ma_docgia = ma_docgia) THEN
        IF EXISTS (SELECT * FROM treem te WHERE te.ma_docgia_nguoilon = ma_docgia) THEN
          DELETE FROM treem WHERE ma_docgia_nguoilon = ma_docgia;
          DELETE FROM nguoilon WHERE ma_docgia = ma_docgia;
          DELETE FROM quatrinhmuon WHERE ma_docgia = ma_docgia;
          DELETE FROM dangky WHERE ma_docgia = ma_docgia;
          DELETE FROM docgia WHERE ma_docgia = ma_docgia;
        ELSE
          DELETE FROM nguoilon WHERE ma_docgia = ma_docgia;
          DELETE FROM quatrinhmuon WHERE ma_docgia = ma_docgia;
          DELETE FROM dangky WHERE ma_docgia = ma_docgia;
          DELETE FROM docgia WHERE ma_docgia = ma_docgia;
        END IF;
      END IF;
      
      IF EXISTS (SELECT * FROM treem te WHERE te.ma_docgia = ma_docgia) THEN
        DELETE FROM treem WHERE ma_docgia = ma_docgia;
        DELETE FROM quatrinhmuon WHERE ma_docgia = ma_docgia;
        DELETE FROM dangky WHERE ma_docgia = ma_docgia;
        DELETE FROM docgia WHERE ma_docgia = ma_docgia;
      END IF;
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Không t?n t?i ??c gi?.');
  END IF;
END;