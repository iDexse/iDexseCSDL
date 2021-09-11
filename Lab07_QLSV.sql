/* Học phần: Cơ sở dữ liệu
   Người thực hiện: 
   MSSV: 
   Ngày: 27/05/2021
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab07_QLSV
go
use Lab07_QLSV
go
--Lệnh tạo các bảng
create table Khoa
(MSKhoa char(2) primary key,
TenKhoa nvarchar(20) not null unique,
TenTat varchar(10) not null)
go
create table Lop
(MSLop char(4) primary key,
TenLop nvarchar(20) not null,
MSKhoa char(2) references Khoa(MSkhoa),
NienKhoa int)
go
create table Tinh
(MSTinh char(2) primary key,
TenTinh nvarchar(20) not null
)
go
create table MonHoc
(MSMH char(4) primary key,
TenMH nvarchar(20) not null,
HeSo int
)
go
create table SinhVien
(MSSV char(7) primary key,
Ho nvarchar(30),
Ten nvarchar(10),
NgaySinh datetime,
MSTinh char(2) references Tinh(MSTinh),
NgayNhap datetime,
MSLop char(4) references Lop(MSLop),
Phai varchar(5),
DiaChi nvarchar(30),
DienThoai varchar(20)
)
go
create table BangDiem
(MSSV char(7) references SinhVien(MSSV),
MSMH char(4) references MonHoc(MSMH),
LanThi int,
Diem float,
primary key(MSSV,MSMH,LanThi)
)
go

----------NHẬP DỮ LIỆU CHO CÁC BẢNG----------
---------Nhập dữ liệu bảng Khoa----------
Insert into Khoa values('01', N'Công nghệ thông tin', 'CNTT')
Insert into Khoa values('02', N'Điện tử viễn thông', 'DTVT')
Insert into Khoa values('03', N'Quản trị kinh doanh', 'QTKD')
Insert into Khoa values('04', N'Công nghệ sinh học', 'CNSH')
---------Xem dữ liệu bảng Khoa----------
Select * From Khoa
---------Nhập dữ liệu bảng Lop-----------
Insert into Lop values('98TH', N'Tin học khoa 1998', '01', 1998)
Insert into Lop values('98VT', N'Viễn thông khoa 1998', '01', 1998)
Insert into Lop values('99TH', N'Tin học khoa 1998', '01', 1999)
Insert into Lop values('99VT', N'Viễn thông khoa 1998', '01', 1999)
Insert into Lop values('99QT', N'Quản trị khoa 1998', '01', 1999)
---------Xem dữ liệu bảng Lop-----------
Select * From Lop
--------Nhập dữ liệu cho bảng Tinh--------
Insert into Tinh values('01', N'An Giang')
Insert into Tinh values('02', N'TPHCM')
Insert into Tinh values('03', N'Đồng Nai')
Insert into Tinh values('04', N'Long An')
Insert into Tinh values('05', N'Huế')
Insert into Tinh values('06', N'Cà Mau')
--------Xem dữ liệu bảng Tinh---------
Select * From Tinh
--------Nhập dữ liệu bảng MonHoc--------
Insert into MonHoc values('TA01', N'Nhập môn tin học', 2)
Insert into MonHoc values('TA02', N'Lập trình cơ bản', 3)
Insert into MonHoc values('TB01', N'Cấu trúc dữ liệu', 2)
Insert into MonHoc values('TB02', N'Cơ sở dữ liệu', 2)
Insert into MonHoc values('QA01', N'Kinh tế vĩ mô', 2)
Insert into MonHoc values('QA02', N'Quản trị chất lượng', 3)
Insert into MonHoc values('VA01', N'Điện tử cơ bản', 2)
Insert into MonHoc values('VA02', N'Mạch số', 3)
Insert into MonHoc values('VB01', N'Truyền số liệu', 3)
Insert into MonHoc values('XA01', N'Vật lý đại cương', 2)
---------Xem dữ liệu bảng MonHoc-----------
Select * From MonHoc
---------Nhập dữ liệu bảng SinhVien---------
set dateformat dmy
Insert into SinhVien values('98TH001',N'Nguyễn Văn','An','06/08/80','01','03/09/98','98TH','Yes', N'12 Trần Hưng Đạo, Q.1','8234512')
Insert into SinhVien values('98TH002',N'Lê Thị','An','17/10/79','01','03/09/98','98TH','No', N'23 CMT8, Q.Tân Bình','0303234342')
Insert into SinhVien values('98VT001',N'Nguyễn Đức',N'Bình','25/11/81','02','03/09/98','98VT','Yes', N'245 Lạc Long Quân, Q.11','8654323')
Insert into SinhVien values('98VT002',N'Trần Ngọc',N'Ánh','19/08/80','02','03/09/98','98VT','No', N'242 Trần Hưng Đạo, Q.1',null)
Insert into SinhVien values('99TH001',N'Lý Văn Hùng',N'Dũng','27/09/81','03','05/10/99','99TH','Yes', N'178 CMT8, Q.Tân Bình','7563213')
Insert into SinhVien values('99TH002',N'Văn Minh',N'Hoàng','01/01/81','04','05/10/99','99TH','Yes', N'272 Lý Thường Kiệt, Q.10','8341234')
Insert into SinhVien values('99TH003',N'Nguyễn',N'Tuấn','12/01/80','03','05/10/99','99TH','Yes', N'162 Trần Hưng Đạo, Q.5',null)
Insert into SinhVien values('99TH004',N'Trần Văn','Minh','25/06/81','04','05/10/99','99TH','Yes', N'147 Điện Biên Phủ, Q.3','7236754')
Insert into SinhVien values('99TH005',N'Nguyễn Thái','Minh','01/01/80','04','05/10/99','99TH','Yes', N'345 Lê Đại Hành, Q.11',null)
Insert into SinhVien values('99VT001',N'Lê Ngọc','Mai','21/06/82','01','05/10/99','99VT','No', N'129 Trần Hưng Đạo, Q.1','0903124534')
Insert into SinhVien values('99QT001',N'Nguyễn Thị','Oanh','19/08/73','04','05/10/99','99QT','No', N'76 Hùng Vương, Q.5','0901656324')
Insert into SinhVien values('99QT002',N'Lê Mỹ',N'Hạnh','20/05/76','04','05/10/99','99QT','No', N'12 Phạm Ngọc Thạch, Q.3',null)
---------Xem dữ liệu bảng SinhVien----------
Select * From SinhVien
---------Nhập dữ liệu bảng BangDiem---------
Insert into BangDiem values('98TH001','TA01',1,8.5)
Insert into BangDiem values('98TH001','TA02',1,8)
Insert into BangDiem values('98TH002','TA01',1,4)
Insert into BangDiem values('98TH002','TA01',2,5.5)
Insert into BangDiem values('98TH001','TB01',1,7.5)
Insert into BangDiem values('98TH002','TB01',1,8)
Insert into BangDiem values('98VT001','VA01',1,4)
Insert into BangDiem values('98VT001','VA01',2,5)
Insert into BangDiem values('98VT002','VA02',1,7.5)
Insert into BangDiem values('99TH001','TA01',1,4)
Insert into BangDiem values('99TH001','TA01',2,6)
Insert into BangDiem values('99TH001','TB01',1,6.5)
Insert into BangDiem values('99TH002','TB01',1,10)
Insert into BangDiem values('99TH002','TB02',1,9)
Insert into BangDiem values('99TH003','TA02',1,7.5)
Insert into BangDiem values('99TH003','TB01',1,3)
Insert into BangDiem values('99TH003','TB01',2,6)
Insert into BangDiem values('99TH003','TB02',1,8)
Insert into BangDiem values('99TH004','TB02',1,2)
Insert into BangDiem values('99TH004','TB02',2,4)
Insert into BangDiem values('99TH004','TB02',3,3)
Insert into BangDiem values('99QT001','QA01',1,7)
Insert into BangDiem values('99QT001','QA02',1,6.5)
Insert into BangDiem values('99QT002','QA01',1,8.5)
Insert into BangDiem values('99QT002','QA02',1,9)
---------Xem dữ liệu bảng BangDiem----------
Select * From BangDiem
---------TRUY VẤN DỮ LIỆU----------
-- 1) Liệt kê MSSV, Họ, Tên, Địa chỉ của tất cả sinh viên
Select MSSV, Ho + ' ' + Ten As HoTen, DiaChi
From SinhVien
-- 2) Liệt kê MSSV, Họ, Tên, MS Tỉnh của tất cả các sinh viên.
-- Sắp xếp kết quả theo MS Tỉnh, trong cùng tỉnh sắp xếp theo họ tên của sinh viên.
Select MSSV, Ho + ' ' + Ten As HoTen, MSTinh
From SinhVien
Order by MSTinh, Ten, Ho ASC
-- 3) Liệt kê các sinh viên nữ của tỉnh Long An
Select *
From SinhVien
Where MSTinh = '04' and Phai = 'No'
-- 4) Liệt kê các sinh viên có sinh nhật trong tháng giêng
Select *
From SinhVien
Where month(NgaySinh) = '01'
-- 5) Liệt kê các sinh viên có sinh nhật nhằm ngày 1/1
Select *
From SinhVien
Where day(NgaySinh) = '01' and month(NgaySinh) = '01'
-- 6) Liệt kê các sinh viên có số điện thoại
Select *
From SinhVien
Where DienThoai is not null
-- 7) Liệt kê các sinh viên có số điện thoại di động
Select *
From SinhVien
Where DATALENGTH(DienThoai) = 10
-- 8) Liệt kê các sinh viên tên "Minh" học lớp "99TH"
Select *
From SinhVien
Where Ten = 'Minh' and MSLop like '99TH%'
-- 9) Liệt kê các sinh viên có địa chỉ ở đường 'Trần Hưng Đạo'
Select *
From SinhVien
Where DiaChi like N'%Trần Hưng Đạo%'
-- 10) Liệt kê các sinh viên có tên lót chữ Văn (Không liệt kê người họ 'Văn')
Select *
From SinhVien
Where Ho like N'% Văn%'
-- 11) Liệt kê MSSV, Ho Ten (ghép họ và tên thành 1 cột), Tuổi của các sinh viên ở tỉnh Long An
Select MSSV, Ho + ' ' + Ten As HoTen, year(getdate()) - year(NgaySinh) As Tuoi, TenTinh
From SinhVien A, Tinh B
Where A.MSTinh = B.MSTinh and TenTinh = 'Long An'
-- 12) Liệt kê các sinh viên nam từ 23 đến 28 tuổi
Select MSSV, Ho + ' ' + Ten As HoTen, Phai, year(getdate()) - year(NgaySinh) As Tuoi
From SinhVien
Where Phai = 'Yes' and year(getdate()) - year(NgaySinh) between 23 and 28
-- 13) Liệt kê các sinh viên nam từ 32 tuổi trở lên và các sinh viên nữ từ 27 tuổi trở lên.
Select MSSV, Ho + ' ' + Ten As HoTen, Phai, year(getdate()) - year(NgaySinh) As Tuoi
From SinhVien
Where (Phai = 'Yes' and year(getdate()) - year(NgaySinh) >=32) or
(Phai = 'No' and year(getdate()) - year(NgaySinh) >= 27)
-- 14) Liệt kê các sinh viên khi nhập học còn dưới 18 tuổi, hoặc đã trên 25 tuổi.
Select MSSV, Ho + ' ' + Ten As HoTen, year(NgayNhap) - year(NgaySinh) As TuoiKhiNhapHoc 
From SinhVien
Where (year(NgayNhap) - year(NgaySinh) < 18) or ( year(NgayNhap) - year(NgaySinh) > 25)
-- 15) Liệt kê danh sách các sinh viên của khóa 99 (MSSV có 2 ký tự đầu là '99')
Select *
From SinhVien
Where MSSV like '99%'
-- 16) Liệt kê MSSV, Điểm thi lần 1 môn 'Cơ sở dữ liệu' của lớp '99TH'
Select A.MSSV, Diem, B.LanThi, C.TenMH, A.MSLop
From SinhVien A, BangDiem B, MonHoc C
Where A.MSSV = B.MSSV and B.MSMH = C.MSMH and LanThi = 1 and TenMH = N'Cơ sở dữ liệu' and MSLop like '99TH%'
-- 17) Liệt kê MSSV, Họ tên của các sinh viên lớp '99TH' thi không đạt lần 1 môn 'Cở sở dữ liệu'
Select A.MSSV, Ho + ' ' + Ten As HoTen, A.MSLop, B.LanThi, C.TenMH, Diem
From SinhVien A, BangDiem B, MonHoc C
Where A.MSSV = B.MSSV and B.MSMH = C.MSMH and A.MSLop = '99TH' and C.TenMH = N'Cơ sở dữ liệu' and LanThi = 1 and Diem < 4
-- 18) Liệt kê tất cả các điểm thi của sinh viên có mã số '99TH001' theo mẫu sau:
Select B.MSMH, B.TenMH As N'Tên MH', A.LanThi As N'Lần thi', A.Diem As N'Điểm'
From BangDiem A, MonHoc B
Where A.MSMH = B.MSMH and A.MSSV = '99TH001'
-- 19) Liệt kê MSSV, họ tên, MSLop của các sinh viên có điểm thi lần 1 môn 'Cơ sở dữ liệu' từ 8 điểm trở lên
Select A.MSSV, Ho + ' ' + Ten As HoTen, A.MSLop, B.LanThi, C.TenMH, B.Diem
From SinhVien A, BangDiem B, MonHoc C
Where A.MSSV = B.MSSV and B.MSMH = C.MSMH and LanThi = 1 and C.TenMH = N'Cơ sở dữ liệu' and B.Diem >= 8
-- 20) Liệt kê các tỉnh không có sinh viên theo học
Select *
From Tinh
Where MSTinh not in (Select A.MSTinh
From SinhVien A)
-- 21) Liệt kê các sinh viên hiện chưa có điểm môn thi nào.
Select *
From SinhVien
Where MSSV not in (Select A.MSSV
From BangDiem A)
-- 22) Thống kê số lượng sinh viên ở mỗi lớp theo mẫu sau: MSLop, TenLop, SoLuongSV
SELECT B.MSLop, B.TenLop, COUNT(*) AS SoLuongSV
FROM SinhVien A, Lop B
Where A.MSLop = B.MSLop
GROUP BY B.MSLop, B.TenLop
ORDER BY SoLuongSV

-- 23) Thống kê số lượng sinh viên ở mỗi tỉnh theo mẫu sau:
SELECT
    B.MSTinh AS MaTinh,
    B.TenTinh AS TenTinh,
    SUM(CASE phai
        WHEN 'Yes' THEN 1
        ELSE 0
    END) AS N'Số SV Nam',
    SUM(CASE phai
        WHEN 'No' THEN 1
        ELSE 0
    END) AS N'Số SV Nữ',
    COUNT(*) AS N'Tổng cộng'
FROM sinhvien A, Tinh B
Where A.MSTinh=B.MSTinh
GROUP BY B.MSTinh,
         B.TenTinh

-- 24) Thống kê kết quả thi lần 1 môn ‘Co so du lieu’ ở các lớp, theo mẫu sau
SELECT
    D.MSLop AS 'MaLop',
    D.TenLop AS 'TenLop',
    COUNT(CASE
        WHEN diem >= 4 THEN 1
        ELSE NULL
    END) AS N'Số SV đạt',
    (COUNT(CASE
        WHEN diem >= 4 THEN 1
        ELSE NULL
    END) * 100 / COUNT(*)) AS N'Tỉ lệ đạt (%)',
    COUNT(CASE
        WHEN diem < 4 THEN 1
        ELSE NULL
    END) AS N'Số SV không đạt',
    (COUNT(CASE
        WHEN diem < 4 THEN 1
        ELSE NULL
    END) * 100 / COUNT(*)) AS N'Tỉ lệ không đạt (%)',
    COUNT(*) AS TongSo
FROM BangDiem A, MonHoc B, SinhVien C, Lop D
Where A.MSMH=B.MSMH and C.MSSV=A.MSSV and C.MSLop=D.MSLop and LanThi = 1 AND B.TenMH = 'Co so du lieu'
GROUP BY D.MSLop,
         D.TenLop

/* 25) Lọc ra điểm cao nhất trong các lần thi cho các sinh viên theo mẫu sau (điểm in ra của
 mỗi môn là điểm cao nhất trong các lần thi của môn đó): */
SELECT MSSV,
    B.MSMH,
    B.TenMH AS N'Tên MH ',
    B.HeSo AS N'Hệ số',
	MAX(diem) AS DIEM
FROM BangDiem A, MonHoc B
Where A.MSMH = B.MSMH
GROUP BY A.MSSV, B.MSMH, B.TenMH, B.HeSo

-- 26) Lập bảng tổng kết theo mẫu
SELECT B.MSSV,
       CONCAT(B.ho, ' ', B.ten) AS 'HoTen',
       ROUND(SUM(diem * heSo) / SUM(heSo), 1) AS 'DTB'
FROM BangDiem A, SinhVien B, MonHoc C
Where A.MSSV = B.MSSV and C.MSMH = A.MSMH
GROUP BY B.MSSV,
         B.Ho,
         B.Ten

-- 27) Thống kê số lượng sinh viên tỉnh ‘Long An’ đang theo học ở các khoa, theo mẫu sau:
SELECT C.NienKhoa AS N'Năm học',
                        D.MSKhoa,
                        D.TenKhoa,
                        COUNT(*) AS N'Số lượng SV'
FROM SinhVien A, Tinh B, Lop C, Khoa D
Where A.MSTinh = B.MSTinh and A.MSLop = C.MSLop and C.MSKhoa=D.MSKhoa and B.TenTinh='Long An'
GROUP BY C.NienKhoa,
         D.MSKhoa,
         D.TenKhoa

-- 28) Nhập vào MSSV, in ra bảng điểm của sinh viên đó theo mẫu sau (điểm in ra lấy điểm cao nhất trong các lần thi)
CREATE PROC usp_LayDiemSinhVien @mssv char(7)
AS
  IF NOT EXISTS (SELECT * FROM bangdiem WHERE MSSV = @mssv)
    PRINT N'Sinh viên có mã số ' + @mssv + N' không tồn tại trong CSDL!'
  ELSE
  BEGIN
    SELECT
      B.MSMH,
      B.TenMH AS N'Tên MH',
      B.HeSo AS N'Hệ số',
      MAX(diem) AS N'Điểm'
    FROM BangDiem A, MonHoc B
    Where A.MSMH = B.MSMH and A.MSSV = @mssv
    GROUP BY B.MSMH,
             B.TenMH,
             B.HeSo;
  END

EXEC usp_LayDiemSinhVien '98TH001'
EXEC usp_LayDiemSinhVien '98TH002'
EXEC usp_LayDiemSinhVien '98TH003'

-- 29) Nhập vào MSSV, in ra bảng tổng kết của lớp đó, theo mẫu sau:
CREATE PROC usp_TongKetSinhVien @mssv char(7)
AS
  IF NOT EXISTS (SELECT * FROM bangdiem WHERE MSSV = @mssv)
    PRINT N'Sinh viên có mã số ' + @mssv + N' không tồn tại trong CSDL!'
  ELSE
  BEGIN
    SELECT
      B.MSSV,
      B.Ho AS N'Họ',
      B.Ten AS N'Tên',
      ROUND(SUM(diem * HeSo) / SUM(HeSo), 1) AS N'ĐTB',
      CASE
        WHEN SUM(diem * HeSo) / SUM(HeSo) >= 8.0 THEN N'Giỏi'
        WHEN SUM(diem * HeSo) / SUM(HeSo) >= 6.5 THEN N'Khá'
        WHEN SUM(diem * HeSo) / SUM(HeSo) >= 5.0 THEN N'TB'
        ELSE N'Yếu'
      END AS N'Xếp loại'
    FROM BangDiem A, SinhVien B, MonHoc C
    Where A.MSSV = B.MSSV and A.MSMH =C.MSMH and B.MSSV = @mssv
    GROUP BY B.MSSV,
             B.Ho,
             B.Ten
  END

EXEC usp_TongKetSinhVien '98TH001'
EXEC usp_TongKetSinhVien '98TH002'
EXEC usp_TongKetSinhVien '98TH003'


/* 30) Tạo bảng SinhVienTinh trong đó chứa hồ sơ của các sinh viên 
 (lấy từ table SinhVien) có quê quán không phải ở TPHCM.  Thêm thuộc tính HBONG (học bổng) cho table SinhVienTinh. */

CREATE TABLE SinhVienTinh
(
	MSSV char(7) primary key,
	Ho varchar(50),
	Ten varchar(30),
	NgaySinh datetime,
	MSTinh char(2) references Tinh(MSTinh) on delete cascade,
	ngayNhapHoc datetime,
	MSLop char(4) references Lop(MSLop),
	Phai varchar(5),
	DiaChi varchar(100),
	DienThoai varchar(13),
	HocBong int
)

SET DATEFORMAT dmy
INSERT INTO SinhVienTinh values ('98TH001', 'Nguyen Van', 'An', '06/08/80', '01', '03/09/98', '98TH', 'Yes', '12 Tran Hung Dao, Q.1', '8234512',null)
INSERT INTO SinhVienTinh values ('98TH002', 'Le Thi', 'An', '17/10/79', '01', '03/09/98', '98TH', 'No', '23 CMT8, Q. Tan Binh', '0303234342',null)
INSERT INTO SinhVienTinh values ('99TH001', 'Ly Van Hung', 'Dung', '27/09/81', '03', '05/10/99', '99TH', 'Yes', '178 CMT8, Q. Tan Binh', '7563213',null)
INSERT INTO SinhVienTinh values ('99TH002', 'Van Minh', 'Hoang', '01/01/81', '04', '05/10/99', '99TH', 'Yes', '272 Ly Thuong Kiet, Q.10', '8341234',null)
INSERT INTO SinhVienTinh values ('99TH003', 'Nguyen', 'Tuan', '12/01/80', '03', '05/10/99', '99TH', 'Yes', '162 Tran Hung Dao, Q.5', NULL,null)
INSERT INTO SinhVienTinh values ('99TH004', 'Tran Van', 'Minh', '25/06/81', '04', '05/10/99', '99TH', 'Yes', '147 Dien Bien Phu, Q.3', '7236754',null)
INSERT INTO SinhVienTinh values ('99TH005', 'Nguyen Thai', 'Minh', '01/01/80', '04', '05/10/99', '99TH', 'Yes', '345 Le Dai Hanh, Q.11', NULL,null)
INSERT INTO SinhVienTinh values ('99VT001', 'Le Ngoc', 'Mai', '21/06/82', '01', '05/10/99', '99VT', 'No', '129 Tran Hung Dao, Q.1', '0903124534',null)
INSERT INTO SinhVienTinh values ('99QT001', 'Nguyen Thi', 'Oanh', '19/08/73', '04', '05/10/99', '99QT', 'No', '76 Hung Vuong, Q.5', '0901656324',null)
INSERT INTO SinhVienTinh values ('99QT002', 'Le My', 'Hanh', '20/05/76', '04', '05/10/99', '99QT', 'No', '12 Pham Ngoc Thach, Q.3', NULL,null)
SELECT * FROM SinhVienTinh
-- 31) Cập nhật thuộc tính HBONG trong table SinhVienThanh 10000 cho tất cả các sinh viên.
UPDATE SinhVienTinh
SET HocBong = 10000;
SELECT * FROM SinhVienTinh;

-- 32) Tăng HBONG lên 10% cho các sinh viên nữ.
UPDATE SinhVienTinh
SET hocBong = hocBong * 1.1
WHERE phai = 'No';

SELECT *
FROM SinhVienTinh
ORDER BY phai;


-- 33) Xóa tất cả các sinh viên có quê quán ở Long An ra khỏi table SinhVienTinh.
DELETE
FROM SinhVienTinh
WHERE MSTinh=
    (SELECT MSTinh
     FROM Tinh
     WHERE ten = 'Long An');

SELECT *
FROM SinhVienTinh;