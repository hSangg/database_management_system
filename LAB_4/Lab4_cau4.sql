--Cau 4
--
--+---------+------+-----+-----+
--|  B?ng   | Them | Xoa | Sua |
--+---------+------+-----+-----+
--| HoaDon  | +    | -   | +   |
--| CTHD    | +    | +   | +   |
--| SanPham | -    |  -  | -   |
--+---------+------+-----+-----+

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