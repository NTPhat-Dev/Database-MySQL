create database QuanLyPhongMay
use QuanLyPhongMay

create table PhongMay (
	MaPhong VARCHAR(20) not null
	constraint pk_maphong PRIMARY KEY (MaPhong),
	GhiChu NVARCHAR(100) null
)

create table MayTinh (
	MaMay VARCHAR(20) not null
	constraint pk_mamay PRIMARY KEY (MaMay),
	TenMay NVARCHAR(100) not null,
	MaPhong VARCHAR(20) not null
	constraint FK_mphog_pm FOREIGN KEY (MaPhong) REFERENCES PhongMay (MaPhong)
)

create table MonHoc (
	MaMon VARCHAR(20) not null
	constraint pk_mamon PRIMARY KEY (MaMon),
	TenMon NVARCHAR(100) not null,
	SoGio INT not null
)

create table DangKy (
	MaMon VARCHAR(20) not null,
	MaPhong VARCHAR(20) not null,
	NgayDK DATETIME not null,
	constraint pk_mm_mp PRIMARY KEY (MaMon, MaPhong),
	constraint FK_Mmon_MnHc FOREIGN KEY (MaMon) REFERENCES MonHoc (MaMon),
	constraint FK_Mphog_Phgm FOREIGN KEY (MaPhong) REFERENCES PhongMay (MaPhong)
)

alter table DangKy add constraint ck_ngdk CHECK (NgayDK >= GETDATE())
alter table PhongMay add constraint ck_mapg CHECK (MaPhong IN ('pm01', 'pm02', 'pm03', 'pm04'))
alter table MonHoc add constraint ck_sogioo CHECK (SoGio > 0 AND SoGio < 4)