/* Học phần: Cơ sở dữ liệu
   Người thực hiện: 
   MSSV: 
   Ngày: 27/05/2021
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab04_QLDatBao
go
USE Lab04_QLDatBao
go
--Tạo các bảng
create table BAO_TCHI
(
MaBaoTC char(4) primary key,
Ten nvarchar(30) not null,
DinhKy nvarchar(20) not null,
SoLuong int check(SoLuong > 0),
GiaBan int check(GiaBan > 0)
)
go
create table PHATHANH
(
MaBaoTC char(4) references BAO_TCHI(MaBaoTC),
SoBaoTC int check(SoBaoTC > 0),
NgayPH datetime,
primary key(MaBaoTC,SoBaoTC)
)
go
create table KHACHHANG
(
MaKH char(4) primary key,
TenKH nvarchar(10) not null,
DiaChi nvarchar(10) not null
)
go
create table DATBAO
(
MaKH char(4) references KHACHHANG(MaKH),
MaBaoTC char(4) references BAO_TCHI(MaBaoTC),
SLMua int check(SLMua > 0),
NgayDM datetime,
primary key(MaKH,MaBaoTC)
)
go
--Nhập dữ liệu cho các bảng
--nhập dữ liệu cho bảng BAO_TCHI
insert into BAO_TCHI values('TT01',N'Tuổi trẻ',N'Nhật báo',1000,1500)
insert into BAO_TCHI values('KT01',N'Kiến thức ngày nay',N'Bán nguyệt san',3000,6000)
insert into BAO_TCHI values('TN01',N'Thanh niên',N'Nhật báo',1000,2000)
insert into BAO_TCHI values('PN01',N'Phụ nữ',N'Tuần báo',2000,4000)
insert into BAO_TCHI values('PN02',N'Phụ nữ',N'Nhật báo',1000,2000)
--xem bảng BAO_TCHI
select * from BAO_TCHI
--nhập dữ liệu cho bảng PHATHANH
set dateformat dmy
insert into PHATHANH values('TT01',123,'15/12/2005')
insert into PHATHANH values('KT01',70,'15/12/2005')
insert into PHATHANH values('TT01',124,'16/12/2005')
insert into PHATHANH values('TN01',256,'17/12/2005')
insert into PHATHANH values('PN01',45,'23/12/2005')
insert into PHATHANH values('PN02',111,'18/12/2005')
insert into PHATHANH values('PN02',112,'19/12/2005')
insert into PHATHANH values('TT01',125,'17/12/2005')
insert into PHATHANH values('PN01',46,'30/12/2005')
--xem bảng PHATTHANH
select * from PHATHANH
--nhập bảng KHACHHANG
insert into KHACHHANG values('KH01',N'LAN',N'2 NCT')
insert into KHACHHANG values('KH02',N'NAM',N'32 THĐ')
insert into KHACHHANG values('KH03',N'NGỌC',N'16 LHP')
--xem bảng KHACHHANG
select * from KHACHHANG
--nhập bảng DATBAO
set dateformat dmy
insert into DATBAO values('KH01','TT01',100,'12/01/2000')
insert into DATBAO values('KH02','TN01',150,'01/05/2001')
insert into DATBAO values('KH01','PN01',200,'25/06/2001')
insert into DATBAO values('KH03','KT01',50,'17/03/2002')
insert into DATBAO values('KH03','PN02',200,'26/08/2003')
insert into DATBAO values('KH02','TT01',250,'15/01/2004')
insert into DATBAO values('KH01','KT01',300,'14/10/2004')
--xem bảng DATBAO
select * from DATBAO
-----------------------------------------------------------------------------
select * from BAO_TCHI
select * from PHATHANH
select * from KHACHHANG
select * from DATBAO
-----------------------------------------------------------------------------
------------TRUY VẤN DỮ LIỆU-------------------
-- 1) Cho biết các tờ báo, tạp chí (MABAOTC, TEN, GIABAN) có định kỳ phát hành hàng tuần (Tuần báo).
Select MaBaoTC, Ten, GiaBan
From BAO_TCHI
Where DinhKy = N'Tuần báo'

-- 2) Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ (mã báo tạp chí bắt đầu bằng PN).
Select *
From BAO_TCHI
Where MaBaoTC like 'PN%'

-- 3) Cho biết tên các khách hàng có đặt mua báo phụ nữ (mã báo tạp chí bắt đầu bằng PN), không liệt kê khách hàng trùng.
Select Distinct A.*
From KHACHHANG A, DATBAO B
Where A.MaKH = B.MaKH and MaBaoTC like 'PN%'

-- 4) Cho biết tên các khách hàng có đặt mua tất cả các báo phụ nữ (mã báo tạp chí bắt đầu bằng PN).
Select A.*
From KHACHHANG A, DATBAO B
Where A.MaKH = B.MaKH and MaBaoTC like 'PN%'
Group By A.MaKH, TenKH, DiaChi
Having Count(Distinct B.MaBaoTC) = (
Select Count(MaBaoTC)
From BAO_TCHI
Where MaBaoTC like 'PN%'
)

-- 5) Cho biết các khách hàng không đặt mua báo thanh niên.
Select Distinct A.*
From KHACHHANG A, DATBAO B
Where A.MaKH = B.MaKH and MaBaoTC Not like 'TN%'

-- 6) Cho biết số tờ báo mà mỗi khách hàng đã đặt mua
Select A.MaKH, TenKH, DiaChi, Sum(B.SLMua) As SLMua
From KHACHHANG A, DATBAO B
Where A.MaKH = B.MaKH
Group by A.MaKH, TenKH, DiaChi

-- 7) Cho biết số khách hàng đặt mua báo trong năm 2004
Select Count(Distinct B.MaKH) As SoKhachHang
From DATBAO B
Where year(NgayDM) = '2004'
-- 8) Cho biết thông tin đặt mua báo của các khách hàng (TenKH, Ten, DinhKy, SLMua, SoTien), trong đó SoTien = SLMua  x DonGia.
Select A.MaKH, TenKH, DiaChi, Ten, DinhKy, SLMua, Sum(SLMua) As SoLuongMua, Sum(SLMua * GiaBan) As TongSoTien
From KHACHHANG A, BAO_TCHI B, DATBAO C
Where A.MaKH = C.MaKH and B.MaBaoTC = C.MaBaoTC
Group by A.MaKH, TenKH, DiaChi, Ten, DinhKy, SLMua
-- 9) Cho biết số tờ báo, tạp chí (Ten, DinhKy) và tổng số lượng đặt mua của các khách hàng đối với tờ báo, tạp chí đó.
Select A.MaBaoTC, Ten, DinhKy, Sum(B.SLMua) As TongSoLuongMua
From BAO_TCHI A, DATBAO B
Where A.MaBaoTC = B.MaBaoTC
Group by A.MaBaoTC, Ten, DinhKy

-- 10) Cho biết tên các tờ báo dành cho học sinh, sinh viên (mã báo tạp chí bắt đầu bằng HS).
Select *
From BAO_TCHI
Where MaBaoTC like 'HS%'
-- 11) Cho biết những tờ báo không có người đặt mua.
Select *
From BAO_TCHI A
Where A.MaBaoTC Not In (Select B.MaBaoTC
From DATBAO B)

-- 12) Cho biết tên, định kỳ của những tờ báo có nhiều người đặt mua nhất.
Select A.MaBaoTC, Ten, DinhKy, SoLuong, GiaBan, Sum(B.SLMua) As TongSoLuongMua
From BAO_TCHI A, DATBAO B
Where A.MaBaoTC = B.MaBaoTC
Group by A.MaBaoTC, Ten, DinhKy, SoLuong, GiaBan
Having Sum(B.SLMua) >= All (Select Sum(C.SLMua)
From DATBAO C
Group by C.MaBaoTC)

-- 13) Cho biết khách đặt mua nhiều báo, tạp chí nhất.
Select A.MaKH, TenKH, DiaChi, Sum(B.SLMua) As TongSoLuongMua
From KHACHHANG A, DATBAO B
Where A.MaKH = B.MaKH
Group by A.MaKH, TenKH, DiaChi
Having Sum(B.SLMua) >= All ( Select Sum(C.SLMua)
From DATBAO C
Group by C.MaKH)
-- 14) Cho biết các tờ báo phát hành định kỳ một tháng 2 lần.
Select *
From BAO_TCHI
Where DinhKy = N'Bán nguyệt san'
-- 15) Cho biết các tờ báo, tạp chí có từ 3 khách hàng đặt mua trở lên.
Select A.MaBaoTC, Ten, DinhKy, SoLuong, GiaBan, Count(Distinct MaKH) As SoKhachHang
From BAO_TCHI A, DATBAO B
Where A.MaBaoTC = B.MaBaoTC
Group by A.MaBaoTC, Ten, DinhKy, SoLuong, GiaBan 
Having Count(Distinct MaKH) >= 3
