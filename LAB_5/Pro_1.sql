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