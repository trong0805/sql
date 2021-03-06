CREATE DATABASE LAB7

CREATE TABLE  KHACHHANG
(
	MAKHACHHANG NVARCHAR (50) NOT NULL PRIMARY KEY,
	HOVATENLOT NVARCHAR (50) NULL,
	TEN NVARCHAR (50) NULL,
	DIACHI NVARCHAR (50) NULL,
	EMAIL NVARCHAR (50) NULL,
	DIENTHOAI INT NULL
)
INSERT INTO KHACHHANG
VALUES ('KH001','NGUYỄN THỊ','NGA','15 QUANG TRUNG TP ĐÀ NẴNG','NGANT@GMAIL.COM',0912345670),
	   ('KH002','TRẦN CÔNG','THÀNH','234 LÊ LỢI QUANGR NAM','THANHTCGMAIL.COM',1610942343),
	   ('KH003','LÊ HOÀNG','NAM','23 TRẦN PHÚ TP HUẾ','NAMLT@YAHOO.COM',0989354556),
	   ('KH004','VŨ NGỌC','HIỀN','37 NGUYỄN THỊ THẬP TP ĐÀ NẴNG','HIENVN@GMAIL.COM',0894545435)
CREATE TABLE SANPHAM
(
	MASANPHAM NVARCHAR (50) NOT NULL PRIMARY KEY,
	MOTA NVARCHAR (50) NULL,
	SOLUONG INT NULL,
	DONGIA MONEY NULL,
	TENSP NVARCHAR (50) NULL
)
INSERT INTO SANPHAM
VALUES ('1','Samsung Galaxy J7 Pro ',800,'6600000','SAMSUNG GALAXY J7 PRO'),
		('2','iPhone 6 32GB',500,8990000,'IPHONE 6 32GB'),
		('3','Dell Inspiron 3467 i',507,'11290000','LAPTOP DELL INSPRIRON 3467'),
		('4','Pin sạc dự phòng Polymer 5.000
mAh eSaver JP85',600,'200000','PIN SẠC SỰ PHÒNG'),
		('5','Nokia 3100 phù hợp với SINH VIÊN',100,'700000','NOKIA 3100')
CREATE TABLE HOADON
(
	MAKHACHHANG NVARCHAR (50) NULL,
	MAHOADON NVARCHAR (50) NOT NULL PRIMARY KEY,
	NGAYMUAHANG NVARCHAR (50) NULL,
	TRANGTHAI NVARCHAR (50) NULL
)
INSERT INTO HOADON 
VALUES ('KH001','120954','03-23-2016','ĐÃ THANH TOÁN'),
	   ('KH002','120955','04-02-2016','ĐÃ THANH TOÁN'),
	   ('KH003','120956','07-12-2016','CHƯA THANH TOÁN'),
	   ('KH004','120957','12-04-2016','CHƯA THANH TOÁN')
CREATE TABLE HOADONCHITIET
(
	MAHOADONCHITIET NVARCHAR (50) NOT NULL PRIMARY KEY,
	MAHOADON NVARCHAR (50) NULL,
	MASANPHAM NVARCHAR (50) NULL,
	SOLUONG INT NULL
)
INSERT INTO HOADONCHITIET
VALUES ('1','120954','3',40),
	   ('2','120954','1',20),
	   ('3','120955','2',100),
	   ('4','120956','4',6),
	   ('5','120956','2',60),
	   ('6','120956','1',10),
	   ('7','120957','2',50)



SELECT * INTO KHACHHANG_DANNANG FROM KHACHHANG WHERE DIACHI LIKE '%ĐÀ NẴNG%'
SELECT * FROM SANPHAM
--A--
UPDATE KHACHHANG
SET DIENTHOAI = 1626778898
WHERE MAKHACHHANG = 'KH002'
--B
UPDATE SANPHAM--
SET SOLUONG = SOLUONG + 200
WHERE MASANPHAM = '3'
--C--
UPDATE SANPHAM
SET DONGIA = DONGIA - DONGIA*0.05
--D--
UPDATE SANPHAM
SET SOLUONG = SOLUONG + 100
WHERE EXISTS 
(SELECT * FROM HOADON A, HOADONCHITIET B 
WHERE A.NGAYMUAHANG BETWEEN '2016-12-01%' AND '2016-12-30%' AND A.MAHOADON = B.MAHOADON AND B.MASANPHAM = SANPHAM.MASANPHAM )
--E
UPDATE SANPHAM
SET DONGIA = DONGIA - DONGIA*0.1
WHERE EXISTS (SELECT TOP 2 * FROM HOADONCHITIET WHERE HOADONCHITIET.MASANPHAM = MASANPHAM ORDER BY SOLUONG ASC)
--F--
UPDATE HOADON
SET TRANGTHAI = 'ĐÃ THANH TOÁN'
WHERE MAHOADON =  '120956'
--G--
DELETE SANPHAM
WHERE EXISTS (SELECT * FROM HOADON A,HOADONCHITIET B WHERE B.MASANPHAM = MASANPHAM AND A.MAHOADON = B.MAHOADON AND A.TRANGTHAI LIKE 'CHUA THANH TOÁN') AND MASANPHAM = '2'
--H--
DELETE KHACHHANG
WHERE EXISTS (SELECT * FROM HOADON WHERE NGAYMUAHANG > '2016-01-01')
