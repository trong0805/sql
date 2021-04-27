create database lab2
CREATE TABLE KhachHang
(
	maKhachHang		nvarchar (50) NOT NULL,
	hoVaTenLot		nvarchar (50) NULL,
	ten				nvarchar (50) NULL,
	diaChi			nvarchar (255) NULL,
	email			nvarchar (50) NULL,
	dienThoai		nvarchar (10) NULL,

	constraint pk_maKhachHang primary key (maKhachHang)

	)
----------------------------
CREATE TABLE sanPham
(
	maSanPham		int NOT NULL,
	moTa			nvarchar (255) NULL,
	soLuong			int NULL,
	donGia			money NULL,
	TtenSP			nvarchar (50) NULL,


	constraint pk_maSanPham primary key (maSanPham)

	)

-----------------------------
CREATE TABLE HoaDon
(
	maHoaDon		INT NOT NULL,
	ngayMuaHang		DATE NULL,
	maKhachHang		nvarchar (50) NULL,
	trangThai		nvarchar (50) NULL,

	constraint pk_maHoaDon primary key (maHoaDon),
	constraint fk_maKhachHang foreign key (maKhachHang) references KhachHang
	)

------------------------------
CREATE TABLE HoaDonChiTiet
(
	maHoaDon		int NULL,
	maSanPham		int NULL,
	soLuong			int NULL,
	maHoaDonChiTiet	int NOT NULL,

	constraint pk_maHoaDonChiTiet primary key (maHoaDonChiTiet)	
	)

--lab5
select * from KhachHang
select TOP 10 maKhachHang,hoVaTenLot+''+ten as 'hoten',email,dienThoai from KhachHang
select maSanPham,TtenSP,sum(donGia*soLuong) from sanPham group by maSanPham,TtenSP
select  maKhachHang,hoVaTenLot+' '+ten as 'hoten' ,diaChi from KhachHang where ten like '%H%'
select * from KhachHang where diaChi like 'DANANG'
select * from sanPham where soLuong between 100 and 500
select ngayMuaHang,trangThai from HoaDon where trangThai like 'CHUATHANHTOAN' and ngayMuaHang between '2016-01-01' and '2016-12-30'
select * from HoaDon where maKhachHang = 'KH001' or maKhachHang = 'KH003' or maKhachHang = 'KH006'

select maKhachHang,count(maKhachHang) from KhachHang group by maKhachHang
select max(donGia) from sanPham
select min(soLuong) from sanPham
select sum(soLuong) from sanPham
select * from HoaDon where trangThai like 'CHUATHANHTOAN' and ngayMuaHang like '2016-12-01'
select maHoaDon,ngayMuaHang,maKhachHang from HoaDon order by maHoaDon,ngayMuaHang,maKhachHang desc

--lab6
--bai1
select * from HoaDon a left join HoaDonChiTiet b on a.maHoaDon = b.maHoaDon
select * from HoaDon a left join HoaDonChiTiet b on a.maHoaDon = b.maHoaDon where a.maKhachHang = 'KH001'
select a.maHoaDon,a.ngayMuaHang,c.TtenSP,b.soLuong,SUM(b.soLuong*c.donGia) as 'tien' from HoaDon a,HoaDonChiTiet b, sanPham c where (a.maHoaDon = b.maHoaDon) and (c.maSanPham = b.maSanPham) group by a.maHoaDon,a.ngayMuaHang,c.TtenSP,b.soLuong
select a.hoVaTenLot+' '+a.ten as 'ho ten',a.email,a.dienThoai,b.maHoaDon,b.trangThai,SUM(c.soLuong*d.donGia) as ' tong tien' 
from sanPham d, KhachHang a,HoaDon b,HoaDonChiTiet c 
where (a.maKhachHang = b.maKhachHang) and (b.maHoaDon = c.maHoaDon) and (c.maSanPham = d.maSanPham) and (b.trangThai='CHUATHANHTOAN') group by  a.hoVaTenLot+' '+a.ten,a.email,a.dienThoai,b.maHoaDon,b.trangThai
select c.maHoaDon,b.ngayMuaHang,SUM(d.donGia*c.soLuong) as ' tien' 
from sanPham d,HoaDon b,HoaDonChiTiet c 
where (b.maHoaDon = c.maHoaDon) and (d.maSanPham = c.maSanPham)  group by  c.maHoaDon,b.ngayMuaHang having SUM(d.donGia*c.soLuong) >= 500000  order by SUM(d.donGia*c.soLuong) desc
--bai2
select a.hoVaTenLot+' '+a.ten as 'ho ten',b.ngayMuaHang from HoaDon b,KhachHang a where (a.maKhachHang = b.maKhachHang) and (b.ngayMuaHang < '01-01-2016')
--b. Hiển thị mã sản phẩm, tên sản phẩm có lượt mua nhiều nhất trong tháng 12/2016
select top 1 a.maSanPham,a.TtenSP,b.ngayMuaHang,sum(c.soLuong) as 'so luong mua' from sanPham a,HoaDon b,HoaDonChiTiet c where (a.maSanPham = c.maSanPham) and (b.maHoaDon = c.maHoaDon) and b.ngayMuaHang like '2016-12%' group by a.maSanPham,a.TtenSP,b.ngayMuaHang order by sum(c.soLuong) desc
--c. Hiển thị top 5 khách hàng có tổng số tiền mua hàng nhiều nhất trong năm 2016
select top 5 * from 
KhachHang a inner join HoaDon b on a.maKhachHang = b.maKhachHang
inner join HoaDonChiTiet c on c.maHoaDon = b.maHoaDon
inner join sanPham d on d.maSanPham = c.maSanPham 
where YEAR(b.ngayMuaHang) = '2016'
--d. Hiển thị thông tin các khách hàng sống ở ‘Đà Nẵng’ có mua sản phẩm có tên
--“Iphone 7 32GB” trong tháng 12/2016
SELECT  a.hoVaTenLot+' '+a.ten as 'ho ten',a.diaChi,a.dienThoai,b.ngayMuaHang,c.TtenSP,c.maSanPham FROM KhachHang a,HoaDon b,sanPham c,HoaDonChiTiet d
where (a.maKhachHang = b.maKhachHang) and (b.maHoaDon = d.maHoaDon) and (d.maSanPham = c.maSanPham) and (c.TtenSP = 'IPHONE7')



