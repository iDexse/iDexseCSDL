/* Học phần: Cơ sở dữ liệu
   Người thực hiện: 
   MSSV: 
   Ngày: 27/05/2021
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab05_QLTour
go
USE Lab05_QLTour
go
--TẠO BẢNG 
create table Tour
(
MaTour char(4) primary key,
TongSoNgay tinyint check (TongSoNgay > 0 and TongSoNgay < 10)
)
go
create table ThanhPho
(
MaTP char(2) primary key,
TenTP nvarchar(15) not null,
)
go
create table Tour_TP
(
MaTour char(4) references Tour(MaTour),
MaTP char(2) references ThanhPho(MaTP),
SoNgay tinyint check(SoNgay > 0 and SoNgay < 5),
primary key(MaTour,MaTP)
)
go
create table Lich_TourDL
(
MaTour char(4) references Tour(MaTour),
NgayKH datetime,
TenHDV nvarchar(10) not null,
SoNguoi tinyint check(SoNguoi >= 20 and SoNguoi < 50),
TenKH nvarchar(20) not null,
primary key(MaTour,NgayKH)
)
go
--NHẬP DỮ LIỆU VÀO BẢNG
--nhập bảng Tour
insert into Tour values('T001','3')
insert into Tour values('T002','4')
insert into Tour values('T003','5')
insert into Tour values('T004','7')
--xem bảng Tour
select * from Tour

--nhập bảng ThanhPho
insert into ThanhPho values('01',N'Đà Lạt')
insert into ThanhPho values('02',N'Nha Trang')
insert into ThanhPho values('03',N'Phan Thiết')
insert into ThanhPho values('04',N'Huế')
insert into ThanhPho values('05',N'Đà Nẵng')
--xem bảng ThanhPho
select * from ThanhPho

--nhập bảng Tour_TP
insert into Tour_TP values('T001','01','2')
insert into Tour_TP values('T001','03','1')
insert into Tour_TP values('T002','01','2')
insert into Tour_TP values('T002','02','2')
insert into Tour_TP values('T003','02','2')
insert into Tour_TP values('T003','01','1')
insert into Tour_TP values('T003','04','2')
insert into Tour_TP values('T004','02','2')
insert into Tour_TP values('T004','05','2')
insert into Tour_TP values('T004','04','3')
--xem bảng Tour_TP
select * from Tour_TP

--nhập bảng Lich_TourDL
set dateformat dmy
insert into Lich_TourDL values('T001','14/02/2017',N'Vân','20',N'Nguyễn Hoàng')
insert into Lich_TourDL values('T002','14/02/2017',N'Nam','30',N'Lê Ngọc')
insert into Lich_TourDL values('T002','06/03/2017',N'Hùng','20',N'Lý Dũng')
insert into Lich_TourDL values('T003','18/02/2017',N'Dũng','20',N'Lý Dũng')
insert into Lich_TourDL values('T004','18/02/2017',N'Hùng','30',N'Dũng Nam')
insert into Lich_TourDL values('T003','10/03/2017',N'Nam','45',N'Nguyễn An')
insert into Lich_TourDL values('T002','28/04/2017',N'Vân','25',N'Ngọc Dung')
insert into Lich_TourDL values('T004','29/04/2017',N'Dũng','35',N'Lê Ngọc')
insert into Lich_TourDL values('T001','30/04/2017',N'Nam','25',N'Trần Nam')
insert into Lich_TourDL values('T003','15/06/2017',N'Vân','20',N'Trịnh Bá')
--xem bảng Lich_Tour_DL
select * from Lich_TourDL
-------------------------------------------------------------------------------------
select * from Tour
select * from ThanhPho
select * from Tour_TP
select * from Lich_TourDL
-------------------------------------------------------------------------------------
------------------TRUY VẤN DỮ LIỆU-------------------
-- a)  Cho biết các tour du lịch có tổng số ngày của tour từ 3 đến 5 ngày.
Select *
From Tour
Where  TongSoNgay >= 3 and TongSoNgay <= 5

-- b)  Cho biết thông tin các tour được tổ chức trong tháng 2 năm 2017.
Select A.MaTour, TongSoNgay, NgayKH, TenHDV, SoNguoi, TenKH
From Tour A, Lich_TourDL B
Where A.MaTour = B.MaTour and month(NgayKH) = '2' and year(NgayKH) = '2017'

-- c) Cho biết các tour không đi qua thành phố 'Nha Trang'. 
Select MaTour, A.MaTP, SoNgay
From ThanhPho A, Tour_TP B
Where A.MaTP = B.MaTP and A.MaTP Not In (Select C.MaTP
From Tour_TP C
Where TenTP = N'Nha Trang')

-- d) Cho biết số lượng thành phố mà mỗi tour du lịch đi qua.
Select MaTour, Count(B.MaTP) As SoLuongTP
From Tour_TP A, ThanhPho B
Where A.MaTP = B.MaTP
Group by MaTour

-- e) Cho biết số lượng tour du lịch mỗi hướng dẫn viên hướng dẫn. 
Select TenHDV, Sum(SoNguoi) As TongSoNguoi, Count(MaTour) As SoLuongTour
From Lich_TourDL
Group by TenHDV

-- f) Cho biết tên thành phố có nhiều tour du lịch đi qua nhất.
Select A.MaTP, TenTP, Count(MaTour) As SoLuongTour
From ThanhPho A, Tour_TP B
Where A.MaTP = B.MaTP
Group by A.MaTP, TenTP
Having Count(MaTour) >= All (Select Count(C.MaTour)
From Tour_TP C
Group by C.MaTP)

-- g) Cho biết thông tin của tour du lịch đi qua tất cả các thành phố.
Select MaTour, Count(Distinct MaTP) As SoLuongThanhPho
From Tour_TP A
Group by MaTour
Having Count(Distinct MaTP) = (Select Count(Distinct C.MaTP)
From Tour_TP C)

-- h) Lập danh sách các tour đi qua thành phố 'Ðà Lạt', thông tin cần hiển thị bao gồm: Mã tour, Songay.
Select MaTour, SoNgay, TenTP
From Tour_TP A, ThanhPho B
Where A.MaTP = B.MaTP and TenTP = N'Đà Lạt'

-- i) Cho biết thông tin của tour du lịch có tổng số lượng khách tham gia nhiều nhất.
Select A.MaTour, Sum(SoNguoi) As TongSoNguoi
From Tour A, Lich_TourDL B
Where A.MaTour = B.MaTour 
Group by A.MaTour, TongSoNgay
Having Sum(SoNguoi) >= All (Select Sum(C.SoNguoi)
From Lich_TourDL C
Group by C.MaTour)
-- j) Cho biết tên thành phố mà tất cả các tour du lịch đều đi qua.
Select A.MaTP, TenTP, Count(Distinct MaTour) As SoLuongTour
From ThanhPho A, Tour_TP B
Where A.MaTP = B.MaTP 
Group by A.MaTP, TenTP
Having Count(Distinct MaTour) = (Select Count(Distinct C.MaTour)
From Tour_TP C)