/* Học phần: Cơ sở dữ liệu
   Người thực hiện: 
   MSSV: 
   Ngày: 27/03/2021
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
USE master
go
IF exists (SELECT * FROM sysdatabases WHERE name= 'Lab01_QLNV')
DROP DATABASE Lab01_QLNV
go
CREATE DATABASE Lab01_QLNV -- lenh khai bao CSDL
go
--lenh su dung CSDL
use Lab01_QLNV
go
--lenh tao cac bang
create table ChiNhanh
(MSCN	char(2) primary key,		 --khai bao MSCN la khoa chinh cua ChiNhanh
TenCN	nvarchar(30) not null unique --khai bao TenCN không được để trống và không được nhập trùng
)
go
create table KyNang
(MSKN	char(2) primary key,
TenKN	nvarchar(30) not null unique
)
go
create table NhanVien
(
MANV char(4) primary key,
Ho	nvarchar(20) not null,
Ten nvarchar(10)	not null,
Ngaysinh	datetime,
NgayVaoLam	datetime,
MSCN	char(2)	references ChiNhanh(MSCN)--khai báo MSCN là khóa ngoại của bảng NhanVien
)
go
create table NhanVienKyNang
(
MANV char(4) references NhanVien(MANV),
MSKN char(2) references KyNang(MSKN),
MucDo	tinyint check(MucDo between 1 and 9)--check(MucDo>=1 and MucDo<=1)
primary key(MANV,MSKN)--Khai báo NhanVienKyNang có khóa chính gồm 2 thuộc tính (MaNV, MSKN)
)
-------------NHAP DU LIEU CHO CAC BANG-----------
--Nhap du lieu cho cac bang
insert into ChiNhanh values('01',N'Quận 1')
insert into ChiNhanh values('02',N'Quận 5')
insert into ChiNhanh values('03',N'Bình thạnh')
--xem bảng Chi nhanh
select * from ChiNhanh
--Nhap bang Kynang
insert into KyNang values('01',N'Word')
insert into KyNang values('02',N'Excel')
insert into KyNang values('03',N'Access')
insert into KyNang values('04',N'Power Point')
insert into KyNang values('05','SPSS')
--xem bảng KyNang
select * from KyNang
--Nhap bang NhanVien
set dateformat dmy
go
insert into NhanVien values('0001',N'Lê Văn',N'Minh','10/06/1960','02/05/1986','01')
insert into NhanVien values('0002',N'Nguyễn Thị',N'Mai','20/04/1970','04/07/2001','01')
insert into NhanVien values('0003',N'Lê Anh',N'Tuấn','25/06/1975','01/09/1982','02')
insert into NhanVien values('0004',N'Vương Tuấn',N'Vũ','25/03/1975','12/01/1986','02')
insert into NhanVien values('0005',N'Lý Anh',N'Hân','01/12/1980','15/05/2004','02')
insert into NhanVien values('0006',N'Phan Lê',N'Tuấn','04/06/1976','25/10/2002','03')
insert into NhanVien values('0007',N'Lê Tuấn',N'Tú','15/08/1975','15/08/2000','03')
--xem bang nhanvien
select * from NhanVien
--nhap bang nhanvienkynang
insert into NhanVienKyNang values('0001','01',2)
insert into NhanVienKyNang values('0001','02',1)
insert into NhanVienKyNang values('0002','01',2)
insert into NhanVienKyNang values('0002','03',2)
insert into NhanVienKyNang values('0003','02',1)
insert into NhanVienKyNang values('0003','03',2)
insert into NhanVienKyNang values('0004','01',5)
insert into NhanVienKyNang values('0004','02',4)
insert into NhanVienKyNang values('0004','03',1)
insert into NhanVienKyNang values('0005','02',4)
insert into NhanVienKyNang values('0005','04',4)
insert into NhanVienKyNang values('0006','05',4)
insert into NhanVienKyNang values('0006','02',4)
insert into NhanVienKyNang values('0006','03',2)
insert into NhanVienKyNang values('0007','03',4)
insert into NhanVienKyNang values('0007','04',3)

select * from NhanVienKyNang
----------------------------------------------------------------------
select * from ChiNhanh
select * from KyNang
select * from NhanVien
select * from NhanVienKyNang
----------------------------------------------------------------------
--------------------TRUY VAN DU LIEU---------------
--------Truy vấn lựa chọn trên nhiều bảng--------
--Cau 1a: Hiển thị MSNV, HoTen (Ho + Ten as HoTen), số năm làm iệc(SoNamLamViec)
Select MANV, Ho + ' ' + Ten As HoTen, year(getdate())-year(NgayVaoLam) As SoNamLamViec
From NhanVien

--Cau 1b: Liệt kê các thông tin về nhân viên: HoTen, NgaySinh, NgayVaoLam, TenCN (sắp theo tên chi nhánh)
Select Ho + ' ' + Ten As HoTen, NgaySinh, NgayVaoLam, TenCN
From NhanVien A, ChiNhanh B
Where A.MSCN = B.MSCN
Order By TenCN, Ten, Ho

--Cau 1c: Liệt kê các nhân viên (HoTen, TenKN, MucDo) của những nhân viên biết sử dụng "Word"
Select Ho + ' ' + Ten As HoTen, TenKN, MucDo
From NhanVien A, KyNang B, NhanVienKyNang C
Where A.MANV = C.MANV and B.MSKN = C.MSKN and TenKN = N'Word'

--Cau 1d: Liệt kê các kỹ năng (TenKN, MucDo) mà nhân viên ‘Lê Anh Tuấn’ biết sử dụng
Select  Ho + ' ' + Ten As HoTen, TenKN, MucDo
From KyNang A, NhanVienKyNang B, NhanVien C
Where A.MSKN = B.MSKN and C.MANV = B.MANV and Ho = N'Lê Anh' and Ten = N'Tuấn'

--------Truy vấn lồng---------
--Cau 2a: Liệt kê MANV, HoTen, MSCN, TenCN của các nhân viên có mức độ thành thạo về ‘Excel’ cao nhất trong công ty .
Select B.MANV, Ho + ' ' + Ten As HoTen, A.MSCN, TenCN, TenKN, MucDo
From ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where A.MSCN = B.MSCN and B.MANV = C.MANV and C.MSKN = D.MSKN and TenKN = 'Excel' and C.MucDo = (Select Max(E.MucDo)
From NhanVienKyNang E, KyNang F
Where E.MSKN = F.MSKN and TenKN = 'Excel')


--Cau 2b: Liệt kê MANV, HoTen, TenCN của các nhân viên vừa biết ‘Word’ vừa biết ‘Excel’ (dùng truy vấn lồng).
Select B.MANV, Ho + ' ' + Ten As HoTen, TenCN
From ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where A.MSCN = B.MSCN and B.MANV = C.MANV and C.MSKN = D.MSKN and TenKN = 'Word' and B.MANV In (Select F.MANV
From NhanVienKyNang F, KyNang G
Where F.MSKN = G.MSKN and TenKN = 'Excel')


--Cau 2c: Với từng kỹ năng, hãy liệt kê các thông tin (MANV, HoTen, TenCN, TenKN, MucDo) của những nhân viên thành thạo kỹ năng đó nhất. 
Select B.MANV, Ho + ' ' + Ten As HoTen, TenCN, TenKN, MucDo
From ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where A.MSCN = B.MSCN and B.MANV = C.MANV and C.MSKN = D.MSKN and C.MucDo = ( Select Max(E.MucDo)
From NhanVienKyNang E, KyNang F
Where E.MSKN = F.MSKN and E.MSKN = D.MSKN)


--Cau 2d: Liệt kê các chi nhánh (MSCN, TenCN) mà mọi nhân viên trong chi nhánh đó đều biết ‘Word’.
Select A.MSCN, TenCN, Count(Distinct B.MANV) As SoNV
From ChiNhanh A, NhanVien B
Where A.MSCN = B.MSCN
Group by A.MSCN, TenCN
Having Count(Distinct B.MANV) = (Select Count(C.MANV)
From NhanVien E, NhanVienKyNang C, KyNang D
Where E.MANV = C.MANV and C.MSKN = D.MSKN and TenKN = 'Word' and E.MSCN = A.MSCN)


------Truy vấn gom nhóm dữ liệu--------
--Cau 3a:  Với mỗi chi nhánh, hãy cho biết các thông tin sau TenCN, SoNV (số nhân viên của chi nhánh đó).
Select  TenCN, Count(MANV) As SoNV
From NhanVien A, ChiNhanh B
Where A.MSCN = B.MSCN
Group By TenCN

--Cau 3b: Với mỗi kỹ năng, hãy cho biết TenKN, SoNguoiDung (số nhân viên biết sử dụng kỹ năng đó).
Select TenKN, Count(MANV) As SoNguoiDung
From NhanVienKyNang A, KyNang B
Where A.MSKN = B.MSKN
Group By TenKN

--Cau 3c: Cho biết TenKN có từ 3 nhân viên trong công ty sử dụng trở lên.
Select TenKN, Count(MANV)
From NhanVienKyNang A, KyNang B
Where A.MSKN = B.MSKN
Group By TenKN
Having Count(MANV) >= 3

--Cau 3d: Cho biết TenCN có nhiều nhân viên nhất.
Select A.MSCN, TenCN, Count(B.MANV) As SoNV
From ChiNhanh A, NhanVien B
Where A.MSCN =B.MSCN 
Group by A.MSCN, TenCN
Having Count(B.MANV) >= All (Select Count(C.MANV)
From NhanVien C, ChiNhanh D
Where C.MSCN = D.MSCN
Group by D.MSCN)

--Cau 3e: Cho biết TenCN có ít nhân viên nhất.
Select TenCN, Count(B.MANV) As SoNV
From ChiNhanh A, NhanVien B
Where A.MSCN = B.MSCN 
Group by TenCN
Having Count(MANV) <= All(Select Count(D.MANV)
From ChiNhanh C, NhanVien D
Where C.MSCN = D.MSCN
Group by TenCN)

--Cau 3f: Với mỗi nhân viên, hãy cho biết số kỹ năng tin học mà nhân viên đó sử dụng được.
Select Ho + ' ' + Ten As HoTen, Count(MSKN) As SoKyNangTinHoc
From NhanVienKyNang A, NhanVien B
Where A.MANV = B.MANV
Group by Ho + ' ' + Ten

--Cau 3g: Cho biết HoTen, TenCN của nhân viên biết sử dụng nhiều kỹ năng nhất
Select Ho + ' ' + Ten as HoTen, TenCN, Count(MSKN) As SoKN
From ChiNhanh A, NhanVien B, NhanVienKyNang C
Where A.MSCN = B.MSCN and B.MANV = C.MANV 
Group by Ho + ' ' + Ten, TenCN
Having Count(MSKN) >= All(Select Count(MSKN)
From NhanVien D, NhanVienKyNang E
Where D.MANV = E.MANV 
Group by Ho + ' ' + Ten)


---------Cập nhật dữ liệu----------
--Cau 4a: Thêm bộ <’06’, ‘PhotoShop’> vào bảng KyNang
Insert into KyNang values ('06','Photoshop')
Select * From KyNang

/*Cau 4b: Thêm các bộ sau vào bảng NhanVienKyNang 
<’0001’,’06’,3> 
<’0005’, ‘06’, 2> */
insert into NhanVienKyNang values('0001', '06',3)
insert into NhanVienKyNang values('0005', '06',2)
Select * From NhanVienKyNang 

--Cau 4c:  Cập nhật cho các nhân viên có sử dụng kỹ năng ‘Word’có mức độ tăng thêm một bậc. 
select * from NhanVienKyNang
Update NhanVienKyNang set MucDo = MucDo + 1 
Where MSKN = '01'
select * from NhanVienKyNang

--Cau 4d: Tạo bảng mới NhanVienChiNhanh1(MANV, HoTen, SoKyNang) (dùng lệnh Create table)
Create table NhanVienChiNhanh1
(
MANVCN char(4) primary key,
Ho nvarchar(30) not null,
Ten nvarchar(10) not null,
SoKyNang tinyint check(SoKyNang > 0 and SoKyNang <= 10)
)
go
--Cau 4e:  Thêm vào bảng trên các thông tin như đã liệt kê của các nhân viên thuộc chi nhánh 1 (dùng câu lệnh Insert Into cho nhiều bộ).
insert into NhanVienChiNhanh1 values('0001',N'Lê Văn', N'Minh', 2)
insert into NhanVienChiNhanh1 values('0002',N'Nguyễn Thị', N'Mai', 2)
select * from NhanVienChiNhanh1
------------------------------------------------------------------------------
----------------XÂY DỰNG THỦ TỤC & HÀM-------------------
----Thủ tục thêm dữ liệu bảng ChiNhanh-------
create proc usp_ThemChiNhanh @mscn char(2), @tencn nvarchar(30)
As
	if exists(Select * From ChiNhanh Where MSCN = @mscn)
		print N'Đã có chi nhánh ' + @mscn + N' trong CSDL.'
	else
		begin
			insert into ChiNhanh values(@mscn, @tencn)
			print N'Thêm chi nhánh thành công!'
		end
Go
--Sử dụng thủ tục
select * from ChiNhanh
exec usp_ThemChiNhanh '04', N'Quận 3'

---Thủ tục thêm dữ liệu bảng NhanVien------
create proc usp_ThemNhanVien @manv char(4), @ho nvarchar(30), @ten nvarchar(20), @ngaysinh datetime, @ngayvaolam datetime, @mscn char(2)
As
	if Not exists(Select * From NhanVien Where MANV = @manv)
		begin
			if exists(Select * From NhanVien Where MSCN = @mscn)
				begin
					Insert into NhanVien values(@manv, @ho, @ten, @ngaysinh, @ngayvaolam, @mscn)
					print N'Thêm nhân viên thành công!'
				end
			else
				print N'Không có chi nhánh trong CSDL.'
		end
	else
		print N'Đã có nhân viên ' + @manv + N' trong CSDL.'

Go
--Thử nghiệm
--TH1: Thêm vào bị trùng khóa chính (manv)
set dateformat dmy
go
exec usp_ThemNhanVien '0002',N'Trần Văn',N'An','14/05/1995', '02/10/2017','01'
--TH2: Thêm nhân viên vào chi nhánh chưa tồn tại trong CSDL (vi phạm rb khóa ngoại)
set dateformat dmy
go
exec usp_ThemNhanVien '0008',N'Trần Văn',N'An','14/05/1995', '02/10/2017','01'

------Hàm tính số năm công tác khi biết ngày vào làm-------
