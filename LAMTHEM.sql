 create table TRINHDO
(
	MaTD int identity(1,1) not null,
	TenTD nvarchar (50) not null,
)
create table CHUCVU
(
	MaChucVu int not null,
	TenChucVu varchar (50) not null,
	TenChucVu_Thua varchar (50) not null
)
create table NHANVIEN 
(
	MaNhanVien int not null,
	HoVaTen nvarchar (max) null,
	NgaySinh datetime null,
	MaTD int not null,
	MaChucVu int not null
)
alter table NHANVIEN
	add  GioiTinh int null;

alter table NHANVIEN 
	add constraint df_GioiTinh  DEFAULT(1) FOR GioiTinh;

alter table CHUCVU 
	add unique(TenChucVu);
alter table TRINHDO
	add primary key(MaTD)
alter table CHUCVU
	add primary key(MaChucVu)
alter table NHANVIEN
	add primary key(MaNhanVien)
alter table NHANVIEN
	add foreign key (MaChucVu) references CHUCVU(MaChucVu) 
alter table NHANVIEN
	add foreign key (MaTD) references TRINHDO(MaTD)
