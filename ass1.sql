create database ass1
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
--y1
select * from sach where maLoai like 'tk%'
--2
select maPhieuMuon,maSach,ngayMuon,maSV from phieumuon where ngayMuon between '2017-01-01' and '2017-02-01'
--y3
select * from phieumuon where ghiChu like 'chuatra' order by ngayMuon asc 
--y4
select  maLoai,tenSach,sum(soLuongBanSao) tongso from sach group by maLoai,tenSach
--y5
select count(maSV) as 'so luot muon sach ' from phieumuon 
--y6
select * from sach where tieude  like 'SQL'
--y1
select * from sach where maLoai like 'tk%'
--2
select maPhieuMuon,maSach,ngayMuon,maSV from phieumuon where ngayMuon between '2017-01-01' and '2017-02-01'
--y3
select * from phieumuon where ghiChu like 'chuatra' order by ngayMuon asc 
--y4
select  maLoai,tenSach,sum(soLuongBanSao) tongso from sach group by maLoai,tenSach
--y5
select count(maSV) as 'so luot muon sach ' from phieumuon 
--y6
select * from sach where tieude  like 'SQL'
DROP DATABASE ass1