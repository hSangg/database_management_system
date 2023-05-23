--Cau 4:
--B?ng:  cthd, hoadon





--+---------+-----------+-------+-----------+
--|  B?ng   |   Them    |  Xoa  |    Sua    |
--+---------+-----------+-------+-----------+
--| HoaDon  | +(TriGia) | -     | +(TriGia) |
--| CTHD    | +(SL)     | +(SL) | +(SL)     |
--| SanPham | -         |       | +(gia)    |
--+---------+-----------+-------+-----------+
create or REPLACE TRIGGER check_TriGiaHD
after insert or update or delete
on cthd
for each row
declare
    tongTien number;
    v_triGiaHD number;
    
begin
    select sum(sl*gia) into tongTien
    from cthd c, sanpham s
    where c.sohd= :new.sohd
    and s.masp = c.masp;
    
    select trigia into v_triGiaHD
    from hoadon
    where sohd = :new.sohd;
    
    if(tongTien<>v_triGiaHD) then
        update hoadon set trigia=tongTien where sohd= :new.sohd;
    end if;
end;
/

create or replace trigger Check_trigiaHoaDon
after insert or update
on Hoadon
for each row
declare
     tongTien number;
    v_triGiaHD number;
begin
    select sum(sl*gia) into tongTien
    from cthd c, sanpham s
    where c.sohd= :new.sohd
    and s.masp = c.masp;
    
    select trigia into v_triGiaHD
    from hoadon
    where sohd = :new.sohd;
    
    if(tongTien<>v_triGiaHD) then
        update hoadon set trigia=tongTien where sohd= :new.sohd;
    end if;
end;
/

create or replace trigger check_trigiaHD_sanpham
after update
on sanpham
for each row
declare
    v_tongtien number;
    v_sohd number;
    v_trigiaHD number;
begin
    
    select sum(sl*:new.gia), sohd into v_tongtien, v_sohd
    from cthd c
    where c.masp = :new.masp
    group by masp;
    
    select trigia into v_triGiaHD
    from hoadon
    where sohd = v_sohd;
    
     if(v_tongTien<>v_triGiaHD) then
        update hoadon set trigia=v_tongTien where sohd= v_sohd;
    end if;
    
end;
/