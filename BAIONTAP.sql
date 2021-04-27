CREATE DATABASE NHACSI
CREATE TABLE CASI
(
	MACS NVARCHAR (50) NOT NULL PRIMARY KEY,
	HOTEN NVARCHAR (50) NULL,
	NGAYSINH NVARCHAR (50) NULL,
	QUEQUAN NVARCHAR (50) NULL 
)
CREATE TABLE NHACSI
(
	MANS  NVARCHAR (50) NOT NULL PRIMARY KEY,
	HOTEN NVARCHAR (50) NULL,
	NGAYSINH NVARCHAR (50) NULL,
	QUEQUAN NVARCHAR (50) NULL ,
	DIACHI NVARCHAR (50) NULL
)
CREATE TABLE BAIHAT 
(
	MABH  NVARCHAR (50) NOT NULL PRIMARY KEY,
	TENBH NVARCHAR (50) NULL,
	NOIDUNG NVARCHAR (50) NULL,
	NAMSANGTAC DATETIME NULL,
	THELOAI NVARCHAR (50) NULL
)
CREATE TABLE TRINHBAY
(
	MACS  NVARCHAR (50) NOT NULL,
	MABH  NVARCHAR (50) NOT NULL,
	NGAYTRINHBAY DATETIME NULL,
	CONSTRAINT PK_1 PRIMARY KEY (MACS,MABH),
	CONSTRAINT FK_1 FOREIGN KEY (MACS) REFERENCES CASI(MACS),
	CONSTRAINT FK_2 FOREIGN KEY (MABH) REFERENCES BAIHAT(MABH)
)

CREATE TABLE SANGTAC
(
	MANS NVARCHAR (50) NOT NULL,
	MABH NVARCHAR (50) NOT NULL,
	CONSTRAINT PK_2 PRIMARY KEY (MANS,MABH),
	CONSTRAINT FK_3 FOREIGN KEY (MANS) REFERENCES NHACSI(MANS),
	CONSTRAINT FK_4 FOREIGN KEY (MABH) REFERENCES BAIHAT(MABH)

)

--1) Hiển thị danh sách bài hát được sáng tác trước 1990. Thông tin hiển thị gồm: tên bài hát,
--năm sáng tác, họ tên nhạc sĩ sáng tác.
SELECT A.TENBH,A.NAMSANGTAC,B.HOTEN FROM BAIHAT A,NHACSI B WHERE A.NAMSANGTAC < 1990
--2) Cho biết ca sĩ nào có thể hát tất cả các thể loại nhạc (có trong cơ sở dữ liệu)?
--3) Hiển thị danh sách bài hát được sáng tác trước 1990. Thông tin hiển thị gồm: tên bài hát,
--năm sáng tác, họ tên nhạc sĩ sáng tác. Kết quả sắp theo thứ tự abc tên bài hát.
SELECT A.TENBH,A.NAMSANGTAC,B.HOTEN FROM BAIHAT A,NHACSI B WHERE A.NAMSANGTAC < 1990 ORDER BY ASC 
--4) Cho biết ca sĩ nhỏ tuổi nhất .
SELECT A.HOTEN,A.MACS,A.NGAYSINH,MAX(NGAYSINH) FROM CASI A GROUP BY A.HOTEN,A.MACS,A.NGAYSINH
--5) Thống kê quê quán và số lượng ca sĩ cùng quê quán. Thông tin hiển thị gồm 2 cột: quê-
--quán, số-ca-sĩ.

--6) Cho biết họ tên nhạc sĩ và số lượng bài hát họ đã sáng tác, chỉ liệt kê các nhạc sĩ sáng
--tác trên 5 bài hát.

--7) Hiển thị danh sách bài hát, ca sĩ trình bày của những bài hát được sáng tác sau 1990.
--Thông tin hiển thị gồm: tên bài hát, năm sáng tác, họ tên ca sĩ trình bày. Kết quả sắp theo
--thứ tự abc tên bài hát

--8) Cho biết ca sĩ (Macs) có thể hát cả 2 thể loại nhạc “Truyền thống” và “Trữ tình”.

--9) Cho biết họ tên những ca sĩ không trình bày một bài hát nào trong năm 2006.

--10) Cho biết họ tên ca sĩ và số bài hát đã trình bày (Lưu ý: đếm bài hát không trùng).