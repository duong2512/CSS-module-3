create database bai1;
use bai1;
create table khachhang(
makh int primary key auto_increment,
hoten varchar (50),
diachi varchar (50),
sodt varchar (10),
ngaysinh date,
doanhso float,
ngdk date
);

create table nhanvien(
manv int primary key auto_increment,
hoten varchar(50),
ngvl date,
sodt varchar(50)
);

create table sanpham(
masp int primary key auto_increment,
tensp varchar(50),
dvt varchar(50),
nuocsx varchar(50),
gia float
);

create table hoadon(
sohd int primary key auto_increment,
nghd date,
makh int,
manv int,
trigia float,
foreign key (makh) references khachhang (makh),
foreign key (manv) references nhanvien (manv)
);

create table hdct(
sohd int,
masp int,
slg int ,
foreign key (sohd) references hoadon (sohd),
foreign key (masp) references sanpham (masp),
primary key (sohd,masp)
);

-- cau1
select count(masp) as 'số sản phẩm bán được trong năm 2006' from hoadon join hdct on hoadon.sohd = hdct.sohd where year(hoadon.nghd) = 2006;

-- cau2
select min(hoadon.trigia) as 'trị giá min',max(hoadon.trigia) as 'trị giá min' from hoadon;

-- cau3
select avg(hoadon.trigia) as 'hóa đơn trung bình trong 2006' from hoadon where year(hoadon.nghd) = 2006;

-- cau4
select sum(hoadon.trigia) as 'doanh thu bán hàng năm 2006' from hoadon where  year(hoadon.nghd) = 2006;

-- cau5
select max(hoadon.trigia) as 'hóa đơn trị giá lớn nhất 2006' from hoadon where  year(hoadon.nghd) = 2006;

-- cau6
select khachhang.hoten from khachhang join hoadon on khachhang.makh = hoadon.makh;

-- cau7
select khachhang.makh,khachhang.hoten from khachhang order by khachhang.doanhso desc;

-- cau8
select sanpham.masp	,sanpham.tensp from sanpham order by gia desc limit 3;

-- cau9
select sanpham.masp	,sanpham.tensp from sanpham where sanpham.nuocsx = 'Thai Lan' order by gia desc limit 3;

-- cau10
select sanpham.masp	,sanpham.tensp from sanpham where sanpham.nuocsx = 'trung quốc' order by gia desc limit 3 ;

-- cau11
Select *, rank() over(order by doanhso DESC) from khachhang limit 3;

-- cau12
select count(masp) from sanpham where sanpham.nuocsx = 'trung quốc';

-- cau13
select sanpham.nuocsx,count(masp) from sanpham group by nuocsx;

-- cau14
select sanpham.nuocsx, max(sanpham.gia), min(sanpham.gia), avg(sanpham.gia) from sanpham group by nuocsx;

-- cau15
select sum(trigia), hoadon.nghd from hoadon group by nghd;

-- cau16
select count(hdct.slg),sanpham.tensp from hdct join sanpham on sanpham.masp=hdct.masp join hoadon on hdct.sohd = hoadon.sohd where month(hoadon.nghd) = 10 and year(hoadon.nghd) = 2006; 

-- cau17
select sum(trigia), month(hoadon.nghd) from hoadon where year(nghd) = 2006 group by month(nghd);

-- cau18
select hoadon.sohd,hoadon.nghd,hoadon.makh,hoadon.manv,hoadon.trigia, count(hdct.masp) from hoadon join hdct on hdct.sohd = hoadon.sohd  group by hoadon.sohd having count(hdct.sohd) > 3;

-- cau19
select hoadon.sohd,hoadon.nghd,hoadon.makh,hoadon.manv,hoadon.trigia, count(hdct.masp) from hoadon join hdct on hdct.sohd = hoadon.sohd join sanpham on sanpham.masp = hdct.masp where nuocsx = 'việt nam' group by hoadon.sohd having count(distinct hdct.sohd) = 3;

-- cau20
-- select count(sohd) from hoadon group by makh order by count(sohd) desc limit 1;
select khachhang.makh,khachhang.hoten,count(hoadon.sohd) from khachhang join hoadon on hoadon.makh = khachhang.makh group by khachhang.makh having count(hoadon.sohd) = (select count(sohd) from hoadon group by makh order by count(sohd) desc limit 1);

