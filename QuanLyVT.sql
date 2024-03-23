create database QuanLyVT
on primary(
size = 50MB,
filegrowth = 10MB,
maxsize = 200MB,
filename = 'D:\PATH\DATA\QuanLyVT.mdf',
name = QuanLyVT
)
log on (
size = 10MB,
filegrowth = 5MB,
maxsize = Unlimited,
filename = 'D:\PATH\LOG\QuanLyVT.ldf',
name = QuanLyVT_log
)

use QuanLyVT

create table VatTu (
	MaVTu CHAR(4) not null 
	constraint pk_mavtu PRIMARY KEY (MaVTu),
	TenVTu NVARCHAR(100) not null,
	DvTinh NVARCHAR(10) not null,
	PhanTram INT not null
)

create table NhaCC (
	MaNhaCC CHAR(4) not null 
	constraint pk_manhacc PRIMARY KEY (MaNhaCC),
	TenNhaCC NVARCHAR(100) not null,
	DiaChi NVARCHAR(200) not null,
	DienThoai NVARCHAR(20) not null
)

create table DonDH (
	SoDH CHAR(4) not null
	constraint pk_sodh PRIMARY KEY (SoDH),
	NgayDH DATETIME not null,
	MaNhaCC CHAR(4) not null
	constraint FK_manhacc FOREIGN KEY (MaNhaCC) REFERENCES NhaCC (MaNhaCC)
)

create table CTDonDH (
	SoDH CHAR(4) not null,
	MaVTu CHAR(4) not null,
	SLDat INT not null,
	constraint pk_sodh_mavt PRIMARY KEY (SoDH, MaVTu),
	constraint FK_sodh_dondh FOREIGN KEY (SoDH) REFERENCES DonDH (SoDH),
	constraint FK_mavtu_vtu FOREIGN KEy (MaVTu) REFERENCES VatTu (MaVTU)
)

create table PNhap (
	SoPN CHAR(4) not null
	constraint pk_sopn PRIMARY KEY (SoPN),
	NgayNhap DATETIME not null,
	SoDH CHAR(4) not null
	constraint FK_sodh FOREIGN KEY (SoDH) REFERENCES DonDH (SoDH)
)

create table CTPNhap (
	SoPN CHAR(4) not null,
	MaVTu CHAR(4) not null,
	SLNhap INT not null,
	DGNhap Money not null,
	constraint pk_sopn_matuv PRIMARY KEY (SoPN, MaVTu),
	constraint FK_sopn_pnhap FOREIGN KEY (SoPN) REFERENCES PNhap (SoPN),
	constraint FK_MaVTu_vattu FOREIGN KEY (MaVTu) REFERENCES VatTu (MaVTu)
)

create table PXuat (
	SoPX CHAR(4) not null
	constraint pk_sopx PRIMARY KEY (SoPX),
	NgayXuat DATETIME not null,
	TenKH NVARCHAR(100) not null
)
create table CTPXuat (
	SoPX CHAR(4) not null,
	MaVTu CHAR(4) not null,
	SLXuat INT not null,
	DGXuat Money not null,
	constraint pk_sopx_matuv PRIMARY KEY (SoPX, MaVTu),
	constraint FK_sopx_pxuat FOREIGN KEY (SoPX) REFERENCES PXuat (SoPX),
	constraint FK_mavtu_vtm FOREIGN KEY (MaVTu) REFERENCES VatTu (MaVTu)
)

create table TonKho(
	NamThang CHAR(6) not null,
	MaVTu CHAR(4) not null,
	SLDau INT not null,
	TongSLN INT not null,
	TongSLX INT not null,
	SLCuoi INT not null,
	constraint FK_namthang_matu PRIMARY KEY (NamThang, MaVTu),
	constraint Fk_mvtua_vatuu FOREIGN KEY (MaVTu) REFERENCES VatTu (MaVTu)
)

--Rang buoc cho bang VatTu 
alter table VatTu add constraint UQ_TenVTu UNIQUE (TenVTu);
alter table VatTu add constraint ck_phantram CHECK (PhanTram >= 0 AND PhanTram <= 100);
alter table VatTu add constraint df_dvtinh_vtu DEFAULT 'Tan' FOR DvTinh;

--Rang buoc cho bang NhaCC
alter table NhaCC add constraint uq_tennhacc_diachi UNIQUE (TenNhaCC, DiaChi)
alter table NhaCC add constraint df_sdt_nhacc DEFAULT 'Chua co' FOR DienThoai

--Rang buoc cho bang DonDH
alter table DonDH add constraint df_ngaydh_dondh DEFAULT GETDATE() FOR NgayDH

--Rang buoc cho bang CTDonDH
alter table CTDonDH add constraint ck_sldat CHECK (SLDat >0)

--Rang buoc cho bang CTPNhap
alter table CTPNhap add constraint ck_slnhap_dgnhap CHECK (SLNhap>0 AND DGNhap>0)

--Rang buoc cho bang CTPXuat
alter table CTPXuat add constraint ck_slxuat_dgxuat CHECK (SLXuat>0 AND DGXuat>0)

--Rang buoc cho bang TonKho
alter table TonKho add constraint ck_sldau_tsln_tslx CHECK (SLDau>=0 AND TongSLN>=0 AND TongSLX>=0)
alter table TonKho add constraint df_sld_tk DEFAULT 0 FOR SLDau 
alter table TonKho add constraint df_togsln_tk DEFAULT 0 FOR TongSLN
alter table TonKho add constraint df_togslx_tk DEFAULT 0 FOR TongSLX

--Chen data
insert into NhaCC (MaNhaCC, TenNhaCC, DiaChi, DienThoai) VALUES 
('C01', 'Le Minh Tri', '54 Hau Giang Q6 HCM', '8781024'),
('C02', 'Tran Minh Thach', '145 Hung Vuong My Tho', '7698154'),
('C03', 'Hong Phuong', '154/85 Le Lai Q1 HCM', '9600125'),
('C04', 'Nhat Thang', '198/40 Huong Lo 14 QTB HCM', '8757757'),
('C05', 'Luu Nguyet Que', '178 Nguyen Van Luong Da Lat', '7964251'),
('C07', 'Cao Minh Trung', '125 Le Quang Sung Nha Trang', '')

insert into VatTu (MaVTu, TenVTu, DvTinh, PhanTram) VALUES 
('DD01', 'Dau DVD Hitachi 1 dia', 'Bo', '40'),
('DD02', 'Dau DVD Hitachi 3 dia', 'Bo', '40'),
('TL15', 'Tu lanh Sanyo 150 lit', 'Cai', '25'),
('TL90', 'Tu lanh Sanyo 90 lit', 'Cai', '20'),
('TV14', 'Tivi Sony 14 inches', 'Cai', '15'),
('TV21', 'Tivi Sony 21 inches', 'Cai', '10'),
('TV29', 'Tivi Sony 29 inches', 'Cai', '10'),
('VD01', 'Dau VCD Sony 1 dia', 'Bo', '30'),
('VD02', 'Dau VCD Sony 3 dia', 'Bo', '30')

insert into DonDH (SoDH, NgayDH, MaNhaCC) VALUES
('D001', CONVERT(datetime, '15-01-2007', 103), 'C03'),
('D002', CONVERT(datetime, '30-01-2007', 103), 'C01'),
('D003', CONVERT(datetime, '10-02-2007', 103), 'C02'),
('D004', CONVERT(datetime, '17-02-2007', 103), 'C05'),
('D005', CONVERT(datetime, '03-01-2007', 103), 'C02'),
('D006', CONVERT(datetime, '03-12-2007', 103), 'C05')

insert into CTDonDH (SoDH, MaVTu, SLDat) VALUES
('D001', 'DD01', 10),
('D001', 'DD02', 15),
('D002', 'VD02', 30),
('D003', 'TV14', 10),
('D003', 'TV29', 20),
('D004', 'TL90', 10),
('D005', 'TV14', 10),
('D005', 'TV29', 20),
('D006', 'TV14', 10),
('D006', 'TV29', 20),
('D006', 'VD01', 20)

insert into PNhap (SoPN, NgayNhap, SoDH) VALUES
('N001', CONVERT(datetime, '17/01/2007', 103), 'D001'),
('N002', CONVERT(datetime, '20/01/2007', 103), 'D001'),
('N003', CONVERT(datetime, '31/01/2007', 103), 'D002'),
('N004', CONVERT(datetime, '15/02/2007', 103), 'D003')

insert into CTPNhap (SoPN, MaVTu, SLNhap, DGNhap) VALUES
('N001', 'DD01', 8, 2500000),
('N001', 'DD02', 10, 3500000),
('N002', 'DD01', 2, 2500000),
('N002', 'DD02', 5, 3500000),
('N003', 'VD02', 30, 2500000),
('N004', 'TV14', 5, 2500000),
('N004', 'TV29', 12, 3500000)

insert into PXuat (SoPX, NgayXuat, TenKH) VALUES
('X001', CONVERT(datetime, '17/01/2007', 103), 'Nguyễn Ngọc Phương Nhi'),
('X002', CONVERT(datetime, '25/01/2007', 103), 'Nguyễn Hồng Phương'),
('X003', CONVERT(datetime, '31/01/2007', 103), 'Nguyễn Tuấn Tú')

insert into CTPXuat (SoPX, MaVTu, SLXuat, DGXuat) VALUES
('X001', 'DD01', 2, 3500000),
('X002', 'DD01', 1, 3500000),
('X002', 'DD02', 5, 4900000),
('X003', 'DD01', 3, 3500000),
('X003', 'DD02', 2, 4900000),
('X003', 'VD02', 10, 3250000)

insert into TonKho (NamThang, MaVTu, SLDau, TongSLN, TongSLX, SLCuoi) VALUES
(200701, 'DD01', 0, 10, 6, 4),
(200701, 'DD02', 0, 15, 7, 8),
(200701, 'VD02', 0, 30, 10, 20),
(200702, 'DD01', 4, 0, 0, 4),
(200702, 'DD02', 8, 0, 0, 8),
(200702, 'VD02', 20, 0, 0, 20),
(200702, 'TV14', 5, 0, 0, 5),
(200702, 'TV29', 12, 0, 0, 12)

update CTPNhap set DGNhap = DGNhap * 1.1
update CTPXuat set DGXuat = DGXuat * 1.1

alter table CTPNhap add ThanhTien DECIMAL(18,2)
alter table CTPNhap add constraint ck_thanhtien CHECK (ThanhTien>=0)
update CTPNhap set ThanhTien = DGNhap * SLNhap

delete from ThanhTien
