
create or replace procedure sp_DocGiaCotTreEmMuon1 IS
    v_nguoilon_id DocGia.ma_docgia%type;
    v_nguoilon_ho DocGia.ho%type;
    v_nguoilon_tenlot DocGia.tenlot%type;
    v_nguoilon_ten DocGia.ten%type;
    v_nguoilon_Ngaysinh DocGia.Ngaysinh%type;
    v_tre_em_id DocGia.ma_docgia%type;
    v_tre_em_ho DocGia.ho%type;
    v_tre_em_tenlot DocGia.tenlot%type;
    v_tre_em_ten DocGia.ten%type;
    v_tre_em_Ngaysinh DocGia.Ngaysinh%type;
    
    cursor get_nguoilon is 
        Select distinct dg.ma_docgia, ho, tenlot, ten, Ngaysinh
        from DOCGIA dg, NGUOILON ngl, quatrinhmuon qtm
        where dg.ma_docgia = ngl.ma_docgia
            and dg.ma_docgia = qtm.ma_docgia
            and qtm.ngay_tra is null;
           
    cursor get_treem is
        select distinct dg.ma_docgia, ho, tenlot, ten, Ngaysinh
        from DOCGIA dg, TREEM tre, quatrimuon qtm
        where dg.ma_docgia = tre.ma_docgia
            and tre.ma_docgia_nguoilon = v_nguoilon_id
            and dg.ma_docgia = qtm.ma_docgia
            and qtm.ngay_tra is null;
            
begin
    open get_nguoilon;
    loop
        fetch get_nguoilon into v_nguoilon_id, v_nguoilon_ho, v_nguoilon_tenlot
                                , v_nguoilon_ten, v_nguoilon_Ngaysinh;
                                
         EXIT WHEN get_nguoilon%NOTFOUND;    
                                
        dbms_output.put_line('Nguoi lon');
        dbms_output.put_line('Ma: '|| v_nguoilon_id);
        dbms_output.put_line('Ho va ten: '|| v_nguoilon_ho ||' '|| v_nguoilon_tenlot || ' ' || v_nguoilon_ten);
        dbms_output.put_line('Ngay sinh: ' || v_nguoilon_Ngaysinh);
        dbms_output.put_line('');
        
        open get_treem;
        loop
            fetch get_treem into v_tre_em_id, v_tre_em_ho, v_tre_em_tenlot
                                , v_tre_em_ten, v_tre_em_Ngaysinh;
                                
             EXIT WHEN get_treem%NOTFOUND;
                                
            dbms_output.put_line('Tre em:');
            dbms_output.put_line('Ma: '|| v_tre_em_id);
            dbms_output.put_line('Ho va ten: '|| v_tre_em_ho ||' '|| v_tre_em_tenlot || ' ' || v_tre_em_ten);
            dbms_output.put_line('Ngay sinh: ' || v_tre_em_Ngaysinh);
            dbms_output.put_line('');
        
           
        end loop;
        close get_treem;
   
    end loop;
    close get_nguoilon;
end sp_DocGiaCotTreEmMuon1;

clear screen
set serveroutput on;
begin
 sp_DocGiaCotTreEmMuon1();
end;