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

        DBMS_OUTPUT.PUT_LINE('Mã độc giả: ' || docgia_info.ma_DocGia);
        DBMS_OUTPUT.PUT_LINE('Họ và tên: ' || docgia_info.ho || ' ' || docgia_info.tenlot || ' ' || docgia_info.ten);
        DBMS_OUTPUT.PUT_LINE('Ngày sinh: ' || TO_CHAR(docgia_info.ngaysinh));
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    END LOOP;


    CLOSE cur_DocGiaNguoiLonDangMuon;
END;
