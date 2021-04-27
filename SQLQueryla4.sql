create database lab4;
go
create table phongban
(
mota nvarchar(100) null,
tenphongban nvarchar(50) primary key not null,
tentruongphong nvarchar(50) null,
slduanBDS int null,

);
go
create table duanbds
(
maBDS nvarchar(15) primary key not null,
ten nvarchar(50) null,
diachi nvarchar(100) null,
tenphongban nvarchar(50) null,
constraint FK_pb foreign key (tenphongban) references phongban(tenphongban),

);
go
create table nhanvienpb
(
chucvu nvarchar(50) null,
tenNV nvarchar(59)   null,
maNV nvarchar(15) primary key not null,
ngaysinh date null,
gioitinh nvarchar(10) null,
constraint FK_chucvu foreign key (chucvu) references phongban(tenphongban),

);
go
create table nguoithan
(
MQH nvarchar(15) not null,
ten nvarchar(50)  primary key not null,
ngaysinh date null,
constraint FK_nvpb foreign key (MQH) references nhanvienpb(maNV),
);
go
create table nguoiquanli
(
ten nvarchar(50) primary key not null,
maNVQL nvarchar(15) not null,
tenphongban nvarchar(50) not null,
maBDS nvarchar(15) null,
constraint FK_maNVQL foreign key (maNVQL) references nhanvienpb(maNV),
constraint FK_tenpb foreign key (tenphongban) references phongban(tenphongban),
constraint FK_duan foreign key (maBDS) references duanbds(maBDS)
);
go
create table chusohuu1
(
tenCSH nvarchar(50) primary key not null,
diachi nvarchar(100) null,
sdt nvarchar(15) null,
tendean nvarchar(15) null,
constraint FK_7 foreign key (tendean) references duanbds(maBDS),

);
go
create table nguoidung
(
	ten nvarchar (50) not null,
	tuoi int null,
	diaChi nvarchar(50) null
);

drop table nguoidung;
alter table nhanvienpb 
	drop constraint FK_chucvu;
alter table chusohuu1
	add  GioiTinh int null;
alter table chusohuu1
	add  email int null;