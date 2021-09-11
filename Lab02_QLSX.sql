/* Học phần: Cơ sở dữ liệu
   Người thực hiện: 
   MSSV: 
   Ngày: 27/05/2021
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab02_QLSX
go
use Lab02_QLSX
go
--lệnh tạo các bảng
create table ToSanXuat
(MaTSX char(4) primary key,
TenTSX nvarchar(5) not null unique
)
go
create table CongNhan
(MACN char(5) primary key,
Ho nvarchar(30) not null,
Ten nvarchar(10) not null,
Phai nvarchar(5) not null,
NgaySinh datetime,
MaTSX char(4) references ToSanXuat(MaTSX)
)
go
create table SanPham
(MASP char(5) primary key,
TenSP nvarchar(20) not null unique,
DVT nchar(5) not null,
TienCong int check(TienCong > 0)
)
go
create table ThanhPham
(
MACN char(5) references CongNhan(MACN),
MASP char(5) references SanPham(MASP),
Ngay datetime,
SoLuong tinyint check(SoLuong > 0),
primary key(MACN,MaSP,Ngay)
)
go
----------NHẬP DỮ LIỆU CHO CÁC BẢNG----------
insert into ToSanXuat values('TS01',N'Tổ 1')
insert into ToSanXuat values('TS02',N'Tổ 2')
--xem bảnh ToSanXuat
select * from ToSanXuat
--Nhập bảng CongNhan
set dateformat dmy
insert into CongNhan values('CN001',N'Nguyễn Trường',N'An',N'Nam','12/05/1981','TS01')
insert into CongNhan values('CN002',N'Lê Thị Hồng',N'Gấm',N'Nữ','04/06/1980','TS01')
insert into CongNhan values('CN003',N'Nguyễn Công',N'Thành',N'Nam','04/05/1981','TS02')
insert into CongNhan values('CN004',N'Võ Hữu',N'Hạnh',N'Nam','15/02/1980','TS02')
insert into CongNhan values('CN005',N'Lý Thanh',N'Hân',N'Nữ','03/12/1981','TS01')
--xem bảng CongNhan
select * from CongNhan
--Nhập bảng SanPham
insert into SanPham values('SP001',N'Nồi đất',N'cái',10000)
insert into SanPham values('SP002',N'Chén',N'cái',2000)
insert into SanPham values('SP003',N'Bình gốm nhỏ',N'cái',20000)
insert into SanPham values('SP004',N'Bình gốm lớn',N'cái',25000)
--xem bảng SanPham
SELECT * FROM SanPham
--Nhập bảng ThanhPham
set dateformat dmy
insert into ThanhPham values('CN001','SP001','01/02/2007',10)
insert into ThanhPham values('CN002','SP001','01/02/2007',5)
insert into ThanhPham values('CN003','SP002','10/01/2007',50)
insert into ThanhPham values('CN004','SP003','12/01/2007',10)
insert into ThanhPham values('CN005','SP002','12/01/2007',100)
insert into ThanhPham values('CN002','SP004','13/02/2007',10)
insert into ThanhPham values('CN001','SP003','14/02/2007',15)
insert into ThanhPham values('CN003','SP001','15/01/2007',20)
insert into ThanhPham values('CN003','SP004','14/02/2007',15)
insert into ThanhPham values('CN004','SP002','30/01/2007',100)
insert into ThanhPham values('CN005','SP003','01/02/2007',50)
insert into ThanhPham values('CN001','SP001','20/02/2007',30)
--xem bảng ThanhPham
select * from ThanhPham
--------------------------------------------------------------------------------
select * from ToSanXuat
select * from CongNhan
select * from SanPham
select * from ThanhPham
--------------------------------------------------------------------------------
---------------TRUY VAN DU LIEU----------------
-- 1) Liệt kê các công nhân theo tổ sản xuất gồm các thông tin: TenTSX, HoTen, 
-- NgaySinh, Phai (xếp thứ tự tăng dần của tên tổ sản xuất, Tên của công nhân).
Select TenTSX, Ho + ' ' + Ten As HoTen, NgaySinh, Phai
From CongNhan A, ToSanXuat B
Where A.MaTSX = B.MaTSX
Order By TenTSX, Ten ASC

-- 2) Liệt kê các thành phẩm mà công nhân ‘Nguyễn Trường An’ đã làm được gồm 
-- các thông tin: TenSP, Ngay, SoLuong, ThanhTien (xếp theo thứ tự tăng dần của ngày). 
Select Ho + ' ' + Ten As HoTen, TenSP, Ngay, SoLuong, SoLuong * TienCong As ThanhTien
From CongNhan A, SanPham B, ThanhPham C
Where A.MACN = C.MACN and B.MASP = C.MASP and Ho = N'Nguyễn Trường' and Ten = N'An'

-- 3) Liệt kê các nhân viên không sản xuất sản phẩm ‘Bình gốm lớn’.
Select Distinct Ho + ' ' + Ten As HoTen, NgaySinh, Phai
From CongNhan A
Where A.MACN Not In(Select B.MACN
From ThanhPham B, SanPham C
Where B.MASP = C.MASP and TenSP = N'Bình gốm lớn')


-- 4) Liệt kê thông tin các công nhân có sản xuất cả ‘Nồi đất’ và ‘Bình gốm nhỏ’.
Select distinct A.MACN, Ho + ' ' + Ten As HoTen, Phai, NgaySinh
From CongNhan A, ThanhPham B, SanPham C
Where A.MACN = B.MACN and B.MASP = C.MASP and TenSP = N'Nồi đất' and A.MACN In(Select D.MACN
From ThanhPham D, SanPham E
Where D.MASP = E.MASP and TenSP = N'Bình gốm nhỏ')

-- 5) Thống kê Số luợng công nhân theo từng tổ sản xuất.
Select B.MaTSX, TenTSX, Count(MACN) As SoCN
From CongNhan A, ToSanXuat B
Where A.MaTSX = B.MaTSX
Group By B.MaTSX, TenTSX 

-- 6)  Tổng số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được (Ho, Ten, TenSP, TongSLThanhPham, TongThanhTien).
Select Ho + ' ' + Ten As HoTen, TenSP, Sum(SoLuong) As TongSLThanhPham, Sum(SoLuong * TienCong) As TongThanhTien
From CongNhan A, ThanhPham B, SanPham C
Where A.MACN = B.MACN and B.MASP = C.MASP
Group By Ho + ' ' + Ten, TenSP

-- 7) Tổng số tiền công đã trả cho công nhân trong tháng 1 năm 2007
Select Sum(SoLuong * TienCong) As TongTienCong
From ThanhPham A, SanPham B
Where A.MASP = B.MASP and Month(Ngay) = '1' and year(Ngay) = '2007'

-- 8) Cho biết sản phẩm được sản xuất nhiều nhất trong tháng 2.2007.
Select TenSP, Sum(SoLuong) As SoLuongSP
From SanPham A, ThanhPham B
Where A.MASP = B.MASP and month(Ngay) = '2' and year(Ngay) = '2007'
Group by TenSP
Having Sum(SoLuong) >= All( Select Sum(C.SoLuong)
From ThanhPham C, SanPham D
Where C.MASP = D.MASP and month(Ngay) = '2' and year(Ngay) = '2007'
Group by TenSP)

-- 9) Cho biết công nhân sản xuất được nhiều 'Chén' nhất
Select A.MACN, Ho + ' ' + Ten As HoTen, Sum(SoLuong) As TongSoLuongSP
From CongNhan A, ThanhPham B, SanPham C
Where A.MACN = B.MACN and B.MASP = C.MASP and TenSP = N'Chén'
Group by A.MACN, Ho + ' ' + Ten
Having Sum(SoLuong) >= All(Select Sum(D.SoLuong)
From ThanhPham D, SanPham E
Where D.MASP = E.MASP and TenSP = N'Chén'
Group by D.MACN)

-- 10) Tiền công tháng 2/2006 của công nhân viên có mã số ‘CN002’
Select Ho + ' ' + Ten As HoTen, Sum(SoLuong * TienCong) As TienCong
From CongNhan A, SanPham B, ThanhPham C
Where A.MACN = C.MACN and B.MASP = C.MASP and C.MACN = 'CN002' and month(Ngay) = '2' and year(Ngay) = '2006'
Group By Ho + ' ' + Ten

-- 11) Liệt kê các công nhân có sản xuất từ 3 loại sản phẩm trở lên.
Select Ho + ' ' + Ten As HoTen, NgaySinh, Phai, Count(Distinct MASP) As SoLoaiSP
From CongNhan A, ThanhPham B
Where A.MACN = B.MACN
Group By Ho + ' ' + Ten, NgaySinh, Phai
Having Count(Distinct MASP) >= 3

-- 12) Cập nhật giá tiền công của các loại bình gốm thêm 1000.
Select * From SanPham
Update SanPham set TienCong = TienCong + 1000
Where TenSP like N'Bình gốm%'
Select * From SanPham


-- 13) Thêm bộ <’CN006’>, ‘Lê Thị’, ‘Lan’, ‘Nữ’,’TS02’ > vào bảng CongNhan.
Insert into CongNhan(MACN, Ho, Ten, Phai, MaTSX) values ('CN006', N'Lê Thị', N'Lan', N'Nữ', 'TS02')
Select * From CongNhan

------------------CÀI ĐẶT RÀNG BUỘC TOÀN VẸN----------------
Create trigger tr_SanPham_ins_upd_TienCong
On SanPham  for insert, update
As
if  update(TienCong)
	     if exists(select * from inserted i where i.TienCong<0)	
	      begin
	    	     raiserror (N'Tiền công không thể nhỏ hơn 0',15,1)
		     rollback tran
	      end
go	
-----thử nghiệm hoạt động của trigger tr_SanPham_ins_upd_TienCong----
insert into SanPham values('SP005',N'Gốm sứ', N'cái',1100)
--------------------
Create trigger tr_ThanhPham_ins_upd_SoLuong
On ThanhPham  for insert, update
As
if  update(SoLuong)
	     if exists(select * from inserted i where i.SoLuong<0)	
	      begin
	    	     raiserror (N'Số lượng không thể nhỏ hơn 0',15,1)
		     rollback tran
	      end
go	
-----thử nghiệm hoạt động của trigger tr_ThanhPham_ins_upd_SoLuong----
set dateformat dmy
insert into ThanhPham values('CN006','SP006','01/01/2007',-10)
