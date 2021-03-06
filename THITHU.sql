CREATE DATABASE THITHU
CREATE TABLE MATHANG
(
	MSMH NVARCHAR (50) NOT NULL PRIMARY KEY,
	TENHANG NVARCHAR (50) NULL,
	DONGIA MONEY NULL,
	DVT NVARCHAR (50) NULL
)
INSERT INTO MATHANG
VALUES  ('MSMH1','CU ĐƠ',50000,'CÁI'),
		('MSMH2','KẸO LẠC',100000,'CÁI'),
		('MSMH1','BÁNH GAI',150000,'CÁI')
CREATE TABLE KHACHHANG
(
	MAKH NVARCHAR (50) NOT NULL PRIMARY KEY,
	TENKH NVARCHAR (50) NULL,
	DIACHI NVARCHAR (50) NULL
)
INSERT INTO KHACHHANG
VALUES  ('MKH1','TRỌNG','HÀ TĨNH'),
		('MKH2','HƯNG','HÀ TĨNH'),
		('MKH3','ĐIỀN','HÀ TĨNH')
CREATE TABLE PHIEUNHAP
(
	SOPN NVARCHAR (50) NOT NULL PRIMARY KEY,
	NGAYLAP DATETIME NULL,
	MAKH NVARCHAR (50) NULL,
	KHO NVARCHAR (50) NULL
)
INSERT INTO PHIEUNHAP
VALUES  ('SPN1','26-03-2006','MKH1','KHO A'),
		('SPN2','09-02-2015','MKH2','KHO B'),
		('SPN3','22-02-2018','MKH3','KHO C')
ALTER TABLE PHIEUNHAP
ADD CONSTRAINT FK_1 FOREIGN KEY  (MAKH) REFERENCES KHACHHANG(MAKH)
CREATE TABLE CTNHAP
(
	SOPN NVARCHAR (50) NOT NULL,
	MSMH NVARCHAR (50) NOT NULL PRIMARY KEY,
	SOLUONG INT NULL
)
INSERT INTO CTNHAP
VALUES  ('SPN1','MSKH1',50),
		('SPN2','MSKH2',35),
		('SPN3','MSKH3',63)
ALTER TABLE CTNHAP
ADD CONSTRAINT FK_2 FOREIGN KEY  (SOPN) REFERENCES PHIEUNHAP(SOPN)
ALTER TABLE CTNHAP
ADD CONSTRAINT FK_3 FOREIGN KEY  (MSMH) REFERENCES MATHANG(MSMH)
