
CREATE OR REPLACE TRIGGER trg_updCuonSach
AFTER UPDATE ON cuon_sach
FOR EACH ROW

  DECLARE
    ma_tuasach_var DAUSACH.ma_tuasach%TYPE;
  BEGIN
    SELECT ma_tuasach INTO ma_tuasach_var
    FROM DAUSACH
    WHERE DAUSACH.isbn = :NEW.isbn;

    -- Cập nhật trạng thái của đầu sách dựa trên tình trạng cuốn sách mới
    UPDATE DAUSACH
    SET trangthai = :NEW.tinhtrang
    WHERE DAUSACH.ma_tuasach = ma_tuasach_var;
  END;
END;
/