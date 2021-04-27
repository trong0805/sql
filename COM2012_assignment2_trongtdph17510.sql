create database ass2
create table loaisach
(	
	maLoai nvarchar (50) not null primary key,
	tenLoai nvarchar (50) null,
	)

create table tacgia
(
	tenTacGia nvarchar (50) not null primary key,
	tuoi int null,
	diaChi nvarchar (50) null,
	sdt nvarchar (50) null,
	email nvarchar (50) null,

	
	)

create table nxb
(
	tenNXB nvarchar (50) not null primary key,
	ngayXB datetime null,
	soLuong int null,
	diaChi nvarchar (50) null,
	
	)
create table sach
(
	maSach nvarchar (50) not null primary key,
	tenSach nvarchar (50) null,
	gia int null,
	ngayNhapKho datetime null,
	tacGia nvarchar (50) null,
	soLuongBanSao int null,
	viTri nvarchar (50) null,
	nhaXuatBan nvarchar (50) null,
	maLoai nvarchar (50) not null,
	tieude nvarchar(50) null

	)
alter table sach
	add constraint fk_ml1 foreign key (maLoai) references loaisach(maLoai)
alter table sach
	add constraint fk_tg1 foreign key (tacGia) references tacgia(tenTacGia)
alter table sach
	add constraint fk_nxb1 foreign key (nhaXuatBan) references nxb(tenNXB)

                                                                                                            
create table thethuvien
(
	tenDocGia nvarchar (50) null ,
	maThe nvarchar (50) not null primary key,
	ngayHetHan dateTime null,

	)

create table sinhvien
(
	tenSV nvarchar (50) null,
	maSV nvarchar (50) not null primary key,
	tuoi int null,
	diaChi nvarchar (50) not null,
	sdt nvarchar (50) not null,
	email nvarchar (50) not null,

	)

create table nhanvien
(
	ten nvarchar (50) null,
	tuoi int null,
	maNV nvarchar (50) not null primary key,
	diaChi nvarchar (50) null,

	)
create table phieumuon
(
	maPhieuMuon nvarchar (50) not null primary key,
	ngayMuon datetime null,
	ngayTra datetime null,
	maThe nvarchar (50) null,
	maSV nvarchar (50) null,
	maNV nvarchar (50) null,
	maSach nvarchar (50) null,

	)
alter table phieumuon 
	add ghiChu nvarchar (50) null
alter table phieumuon
	add constraint fk_ms1 foreign key (maSach) references sach(maSach)
alter table phieumuon
	add constraint fk_mt1 foreign key (maThe) references thethuvien(maThe)
alter table phieumuon
	add constraint fk_sv1 foreign key (maSV) references sinhvien(maSV)
alter table phieumuon
	add constraint fk_nv1 foreign key (maNV) references nhanvien(maNV)
--ass2--
select * from sach where maLoai like 'IT%'
select maPhieuMuon,maSach,ngayMuon,maSV from phieumuon where ngayMuon between '2017-01-01' and '2017-02-01'
select * from phieumuon where ghiChu like 'chuatra' order by ngayMuon asc 
select  maLoai,tenSach,sum(soLuongBanSao) tongso from sach group by maLoai,tenSach
select count(maSV) as 'so luot muon sach ' from phieumuon 
select * from sach where tieude  like 'SQL'
--assht--6.7-->6.13--
select a.maSV,a.tenSV,b.maPhieuMuon,c.tieude,b.ngayMuon,b.ngayTra from sinhvien a,phieumuon b,sach c where a.maSV = b.maSV and b.maSach = c.maSach order by ngayMuon
--6.8 Liệt kê các đầu sách có lượt mượn lớn hơn 20 lần.
select maSach,count(maSach) as 'luot muon' from phieumuon group by (maSach) having (COUNT(maSach) > 3)
--6.9 Viết câu lệnh cập nhật lại giá tiền của các quyển sách có ngày nhập kho trước năm
--2014 giảm 30%.
update sach
set gia = gia - 0.3*gia
where ngayNhapKho < '2014-01-01'
--6.10 Viết câu lệnh cập nhật lại trạng thái đã trả sách cho phiếu mượn của sinh viên có mã
--sinh viên PD12301 (ví dụ).
update phieumuon
set ghiChu = 'datra'
where maSV = 'sv3'
--6.11 Lập danh sách các phiếu mượn quá hạn chưa trả gồm các thông tin: mã phiếu mượn,
--tên sinh viên, email, danh sách các sách đã mượn, ngày mượn.
select a.maPhieuMuon,b.tenSV,b.email,c.tenSach,a.ngayMuon from phieumuon a,sinhvien b,sach c
where a.maSV = b.maSV and a.maSach = c.maSach and a.ghiChu = 'datra'
--6.12 Viết câu lệnh cập nhật lại số lượng bản sao tăng lên 5 đơn vị đối với các đầu sách có
--lượt mượn lớn hơn 10
select * from sach
UPDATE sach
SET soLuongBanSao = soLuongBanSao + 5
where exists(
SELECT sach.tenSach, COUNT(SACH.maSach) LUOTMUON
FROM sach INNER JOIN phieumuon 
ON sach.maSach = phieumuon.maSach
GROUP BY sach.tenSach
HAVING COUNT(sach.maSach) > 3)

--6.13 Viết câu lệnh xoá các phiếu mượn có ngày mượn và ngày trả trước 1/1/2010
delete phieumuon 
where ngayMuon < '2010-01-01' and ngayTra < '2010-01-01'
--7--
BACKUP DATABASE ass2 to disk = 'D:\SQL.BAK'
