/* Học phần: Cơ sở dữ liệu
   Người thực hiện: 
   MSSV: 
   Ngày: 27/05/2021
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab03_QLNhapXuatHangHoa
go
USE Lab03_QLNhapXuatHangHoa
go
create table DOITAC
(
MADT char(5) primary key,
TENDT nvarchar(30) not null,
DIACHI nvarchar(50) not null,
DIENTHOAI varchar(20) not null
)
go
create table HOADON
(
SOHD char(5) primary key,
NGAYLAPHD datetime,
MADT char(5) references DOITAC(MADT), 
TONGTG float
)
go
create table HANGHOA
(
MAHH varchar(5) primary key,
TENHH nvarchar(30) not null,
DVT nvarchar(5) not null,
SOLUONGTON int)
GO
create table KHANANGCC
(
MADT char(5) references DOITAC(MADT),
MAHH varchar(5) references HANGHOA(MAHH),
primary key(MADT,MAHH)
)
go
create table CT_HOADON
(
SOHD char(5) references HOADON(SOHD),
MAHH varchar(5) references HANGHOA(MAHH),
DONGIA int,
SOLUONG int 
primary key(SOHD,MAHH)
)
GO
--NHẬP DỮ LIỆU CHO BẢNG
insert into HANGHOA values('CPU01',N'CPU INTEL,CELERON 600 BOX',N'CÁI',5)
insert into HANGHOA values('CPU02',N'CPU INTEL,PIII 700',N'CÁI',10)
insert into HANGHOA values('CPU03',N'CPU AMD K7 ATHL,ON 600',N'CÁI',8)
insert into HANGHOA values('HDD01',N'HDD 10.2 GB QUANTUM',N'CÁI',10)
insert into HANGHOA values('HDD02',N'HDD 13.6 GB SEAGATE',N'CÁI',15)
insert into HANGHOA values('HDD03',N'HDD 20 GB SEAGATE',N'CÁI',6)
insert into HANGHOA values('KB01',N'KB GENIUS',N'CÁI',12)
insert into HANGHOA values('KB02',N'KB MITSUMIMI',N'CÁI',5)
insert into HANGHOA values('MB01',N'GIGABYTE CHIPSET INTEL',N'CÁI',10)
insert into HANGHOA values('MB02',N'ACOPR BX CHIPSET VIA',N'CÁI',10)
insert into HANGHOA values('MB03',N'INTEL PHI CHIPSET INTEL',N'CÁI',10)
insert into HANGHOA values('MB04',N'ESC CHIPSET SIS',N'CÁI',10)
insert into HANGHOA values('MB05',N'ESC CHIPSET VIA',N'CÁI',10)
insert into HANGHOA values('MNT01',N'SAMSUNG 14" SYNCMASTER',N'CÁI',5)
insert into HANGHOA values('MNT02',N'LG 14"',N'CÁI',5)
insert into HANGHOA values('MNT03',N'ACER 14"',N'CÁI',8)
insert into HANGHOA values('MNT04',N'PHILIPS 14"',N'CÁI',6)
insert into HANGHOA values('MNT05',N'VIEWSONIC 14"',N'CÁI',7)
--xem bảng HANGHOA
select * from HANGHOA
--nhập bảng DOITAC
insert into DOITAC values('CC001',N'Cty TNC',N'176 BTX - TP.HCM','08.8250259')
insert into DOITAC values('CC002',N'Cty Hoàng Long',N'15A TTT Q1 - TP.HCM','08.8250898')
insert into DOITAC values('CC003',N'Cty Hợp Nhất',N'152 BTX Q1 - TP.HCM','08.8252376')
insert into DOITAC values('K0001',N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trỗi Tp.Đà Lạt','063.831129')
insert into DOITAC values('K0002',N'Như Quỳnh',N'21 Điện Biên Phủ. N.Trang','058590270')
insert into DOITAC values('K0003',N'Trần Nhật Duật',N'Lê Lợi TP.Huế','054.848376')
insert into DOITAC values('K0004',N'Phan Nguyễn Hùng Anh',N'11 Nam Kỳ Khởi nghĩa - TP.Đà Lạt','063.823409')
--xem bảng DOITAC
select * from DOITAC
--nhập bảng HOADON
set dateformat dmy
insert into HOADON(SOHD,NGAYLAPHD,MADT) values('N0001','25/01/2006','CC001')
insert into HOADON(SOHD,NGAYLAPHD,MADT) values('N0002','01/05/2006','CC002')
insert into HOADON(SOHD,NGAYLAPHD,MADT) values('X0001','12/05/2006','K0001')
insert into HOADON(SOHD,NGAYLAPHD,MADT) values('X0002','16/06/2006','K0002')
insert into HOADON(SOHD,NGAYLAPHD,MADT) values('X0003','20/04/2006','K0001')
--xem bảng HOADON
select * from HOADON
--nhập bảng KHANANGCC
insert into KHANANGCC values('CC001','CPU01')
insert into KHANANGCC values('CC001','HDD03')
insert into KHANANGCC values('CC001','KB01')
insert into KHANANGCC values('CC001','MB02')
insert into KHANANGCC values('CC001','MB04')
insert into KHANANGCC values('CC001','MNT01')
insert into KHANANGCC values('CC002','CPU01')
insert into KHANANGCC values('CC002','CPU02')
insert into KHANANGCC values('CC002','CPU03')
insert into KHANANGCC values('CC002','KB02')
insert into KHANANGCC values('CC002','MB01')
insert into KHANANGCC values('CC002','MB05')
insert into KHANANGCC values('CC002','MNT03')
insert into KHANANGCC values('CC003','HDD01')
insert into KHANANGCC values('CC003','HDD02')
insert into KHANANGCC values('CC003','HDD03')
insert into KHANANGCC values('CC003','MB03')
--xem bảng KHANANGCC
select * from KHANANGCC
--nhập bảng CT_HOADON
insert into CT_HOADON values('N0001','CPU01',63,10)
insert into CT_HOADON values('N0001','HDD03',97,7)
insert into CT_HOADON values('N0001','KB01',3,5)
insert into CT_HOADON values('N0001','MB02',57,5)
insert into CT_HOADON values('N0001','MNT01',112,3)
insert into CT_HOADON values('N0002','CPU02',115,3)
insert into CT_HOADON values('N0002','KB02',5,7)
insert into CT_HOADON values('N0002','MNT03',111,5)
insert into CT_HOADON values('X0001','CPU01',67,2)
insert into CT_HOADON values('X0001','HDD03',100,2)
insert into CT_HOADON values('X0001','KB01',5,2)
insert into CT_HOADON values('X0001','MB02',62,1)
insert into CT_HOADON values('X0002','CPU01',67,1)
insert into CT_HOADON values('X0002','KB02',7,3)
insert into CT_HOADON values('X0002','MNT01',115,2)
insert into CT_HOADON values('X0003','CPU01',67,1)
insert into CT_HOADON values('X0003','MNT03',115,2)
--xem bảng CT_HOADON
select * from CT_HOADON
-----------------------------------------------------------------------
select * from HANGHOA
select * from DOITAC
select * from HOADON
select * from KHANANGCC
select * from CT_HOADON
-----------------------------------------------------------------------
----------------TRUY VAN DU LIEU--------------------
-- 1)  Liệt kê các mặt hàng thuộc loại đĩa cứng
Select * 
From HANGHOA
Where MAHH like 'HDD%'

--2) Liệt kê các mặt hàng có số lượng tồn trên 10.
Select * 
From HANGHOA
Where SOLUONGTON > 10

-- 3) Cho biết thông tin về các nhà cung cấp ở Thành phố Hồ Chí Minh
Select * 
From DOITAC
Where DIACHI like N'%TP.HCM'

-- 4) Liệt kê các hóa đơn nhập hàng trong tháng 5/2006, thông tin hiển thị gồm: sohd; ngaylaphd, tên, DIACHI, DIENTHOAI, số mặt hàng
Select A.SOHD, NGAYLAPHD, TENDT As Ten, DIACHI, DIENTHOAI, Count(MAHH) As SoMatHang
From HOADON A, DOITAC B, CT_HOADON C
Where A.SOHD = C.SOHD and A.MADT = B.MADT and month(NGAYLAPHD) = '5' and year(NGAYLAPHD) = '2006'
Group By A.SOHD, NGAYLAPHD, TENDT, DIACHI, DIENTHOAI

-- 5) Cho biết tên các nhà cung cấp có cung cấp đĩa cứng.
Select *
From DOITAC A, KHANANGCC B
Where A.MADT = B.MADT and MAHH like 'HDD%'

-- 6) Cho biết tên các nhà cung cấp có thể cung cấp tất cả các loại đĩa cứng.
Select A.MADT, TENDT, DIACHI, DIENTHOAI, Count(MAHH) As SoLoaiDiaCung
From DOITAC A, KHANANGCC B
Where A.MADT = B.MADT and MAHH like 'HDD%'
Group By A.MADT,TENDT,DIACHI,DIENTHOAI
Having Count(MAHH) = (Select Count(MAHH) 
					  From HANGHOA 
					  Where MAHH like 'HDD%')

-- 7) Cho biết tên nhà cung cấp không cung cấp đĩa cứng.
Select Distinct TENDT, DIACHI, DIENTHOAI
From DOITAC A, KHANANGCC B, HANGHOA C
Where A.MADT = B.MADT and B.MAHH = C.MAHH and A.MADT Not In(Select D.MADT
From KHANANGCC D, HANGHOA E
Where D.MAHH = E.MAHH and E.MAHH like 'HDD%')

-- 8) Cho biết thông tin của mặt chưa bán được.
Select *
From HANGHOA A
Where A.MAHH Not In(Select B.MAHH
From CT_HOADON B, HOADON C
Where B.SOHD = C.SOHD and C.SOHD like 'X%')

-- 9) Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhất (tính theo số lượng).
Select A.MAHH, TENHH, Sum(SOLUONG) As TongSoLuong
From HANGHOA A, CT_HOADON B, HOADON C
Where A.MAHH = B.MAHH and B.SOHD = C.SOHD and C.SOHD like 'X%'
Group by A.MAHH, TENHH
Having Sum(SOLUONG) >= All(Select Sum(SOLUONG) 
From CT_HOADON D, HOADON E
Where D.SOHD = E.SOHD and E.SOHD like 'X%'
Group by D.MAHH)

-- 10) Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất
Select B.SOHD, A.MAHH, TENHH, Sum(SOLUONG) As TongSoLuong
From HANGHOA A, CT_HOADON B
Where A.MAHH = B.MAHH and B.SOHD like 'N%'
Group by B.SOHD, A.MAHH, TENHH
Having Sum(SOLUONG) <= All(Select Sum(SOLUONG)
From CT_HOADON C
Where C.SOHD like 'N%'
Group by C.SOHD, C.MAHH)

-- 11) Cho biết hóa đơn nhập nhiều mặt hàng nhất
Select B.SOHD, A.MAHH, DONGIA, Sum(SOLUONG) As TongSoLuong
From HANGHOA A, CT_HOADON B
Where A.MAHH = B.MAHH and SOHD like 'N%'
Group by B.SOHD, A.MAHH, DONGIA
Having Sum(SOLUONG) >= All(Select Sum(SOLUONG)
From CT_HOADON C
Where C.SOHD like'N%'
Group by C.SOHD, C.MAHH, C.DONGIA)

--  12) Cho biết các mặt hàng không được nhập hàng trong tháng 1/2006
Select *
From HANGHOA A
Where A.MAHH Not In(Select B.MAHH
From CT_HOADON B, HOADON C
Where B.SOHD = C.SOHD and C.SOHD like'N%' and Month(NGAYLAPHD) = '1' and year(NGAYLAPHD) = '2006')

-- 13) Cho biết tên các mặt hàng không bán được trong tháng 6/2006
Select *
From HANGHOA A
Where A.MAHH Not In(Select B.MAHH
From CT_HOADON B, HOADON C
Where B.SOHD = C.SOHD and C.SOHD like'X%' and month(NGAYLAPHD) = '6' and year(NGAYLAPHD) = '2006')

-- 14) Cho biết cửa hàng bán bao nhiêu mặt hàng
Select Count(MAHH) As SoLuongMatHang
From HANGHOA

-- 15) Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp.
Select A.MADT, TENDT, DIACHI, DIENTHOAI, Count(*) As SoMatHang
From DOITAC A, KHANANGCC B
Where A.MADT = B.MADT
Group by A.MADT, TENDT, DIACHI, DIENTHOAI
Order By SoMatHang DESC

-- 16) Cho biết thông tin của khách hàng có giao dịch với cửa hàng nhiều nhất
Select B.MADT, TENDT, DIACHI, DIENTHOAI, Count(A.SOHD) As SoLanGiaoDich
From HOADON A, DOITAC B, CT_HOADON C
Where A.MADT = B.MADT and A.SOHD = C.SOHD and A.MADT like 'K%' 
Group by B.MADT, TENDT, DIACHI, DIENTHOAI
Having Count(A.SOHD) >= All (Select Count(D.SOHD)
From HOADON D, CT_HOADON E
Where D.SOHD = E.SOHD and D.MADT like 'K%'
Group by D.MADT)


-- 17) Tính tổng doanh thu năm 2006.
Select Sum(SOLUONG * DONGIA) As TongDoanhThu
From CT_HOADON A, HOADON B
Where A.SOHD = B.SOHD and year(NGAYLAPHD) = '2006' and B.SOHD like 'X%'

-- 18) Cho biết loại mặt hàng bán chạy nhất
Select A.MAHH, TENHH, DVT, SOLUONGTON, Sum(SOLUONG) As TongMatHangBanDuoc
From HANGHOA A, HOADON B, CT_HOADON C
Where A.MAHH = C.MAHH and B.SOHD = C.SOHD and B.SOHD like 'X%'
Group by A.MAHH, TENHH, DVT, SOLUONGTON
Having Sum(SOLUONG) >= All(Select Sum(SOLUONG)
From CT_HOADON D, HOADON E
Where D.SOHD = E.SOHD and E.SOHD like 'X%'
Group by D.MAHH)

-- 19) Liệt kê thông tin bán hàng của tháng 5/2006 bao gồm: mahh, tenhh, dvt, tổng số lượng, tổng thành tiền.
Select A.MAHH, TENHH, DVT, Sum(SOLUONG) As TongSoLuong, Sum(SOLUONG * DONGIA) As TongThanhTien
From HANGHOA A, CT_HOADON B, HOADON C
Where A.MAHH = B.MAHH and B.SOHD = C.SOHD and month(NGAYLAPHD) = '5' and year(NGAYLAPHD) = '2006'
Group By A.MAHH, TENHH, DVT

-- 20) Liệt kê thông tin của mặt hàng có nhiều người mua nhất
Select A.MAHH, TENHH, DVT, SOLUONGTON, Sum(SOLUONG) As TongMatHangBanDuoc
From HANGHOA A, HOADON B, CT_HOADON C
Where A.MAHH = C.MAHH and B.SOHD = C.SOHD and B.SOHD like 'X%'
Group by A.MAHH, TENHH, DVT, SOLUONGTON
Having Sum(SOLUONG) >= All(Select Sum(SOLUONG)
From CT_HOADON D, HOADON E
Where D.SOHD = E.SOHD and E.SOHD like 'X%'
Group by D.MAHH)

-- 21) Tính và cập nhật tổng trị giá của các hóa đơn
Select Sum(SOLUONG*DONGIA) As TongTGN1
From CT_HOADON A, HOADON B
Where A.SOHD = B.SOHD and B.SOHD like 'N%1'
Select Sum(SOLUONG*DONGIA) As TongTGN2
From CT_HOADON A, HOADON B
Where A.SOHD = B.SOHD and B.SOHD like 'N%2'
Select Sum(SOLUONG*DONGIA) As TongTGX1
From CT_HOADON A, HOADON B
Where A.SOHD = B.SOHD and B.SOHD like 'X%1'
Select Sum(SOLUONG*DONGIA) As TongTGX2
From CT_HOADON A, HOADON B
Where A.SOHD = B.SOHD and B.SOHD like 'X%2'
Select Sum(SOLUONG*DONGIA) As TongTGX3
From CT_HOADON A, HOADON B
Where A.SOHD = B.SOHD and B.SOHD like 'X%3'


