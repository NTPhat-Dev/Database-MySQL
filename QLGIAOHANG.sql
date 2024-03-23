create database QLGIAOHANG
use QLGIAOHANG

create table KV (
	MAKV CHAR(10) not null
	constraint pk_makv PRIMARY KEY (MAKV),
	TENKV NVARCHAR(60) not null
)

create table LMH (
	MALMH CHAR(10) not null
	constraint pk_malmh PRIMARY KEY (MALMH),
	TENLMH NVARCHAR(60) not null
)

create table DV (
	MADV CHAR(10) not null
	constraint pk_madv PRIMARY KEY (MADV),
	TENDV NVARCHAR(60) not null
)

create table KHACHHANG (
	MAKH CHAR(10) not null
	constraint pk_makh PRIMARY KEY (MAKH),
	MAKV CHAR(10) not null
	constraint FK_makv_kv FOREIGN KEY (MAKV) REFERENCES KV (MAKV),
	TENKH NVARCHAR(60) not null,
	TENCH NVARCHAR(60) not null,
	SDT_KH CHAR(20) not null,
	EMAIL VARCHAR(60) null,
	DC_NHANHANG NVARCHAR(60) not null
)

create table DH_GH (
	MADH_GH CHAR(10) not null
	constraint pk_madhgh PRIMARY KEY (MADH_GH),
	MAKH CHAR(10) not null
	constraint FK_mkh_khg FOREIGN KEY (MAKH) REFERENCES KHACHHANG (MAKH),
	MATV_GH CHAR(10) not null
	constraint FK_mtv_tvgh FOREIGN KEY (MATV_GH) REFERENCES TV_GH (MATV_GH),
	MADV CHAR(10) not null
	constraint FK_mdv_vd FOREIGN KEY (MADV) REFERENCES DV (MADV),
	MAKV CHAR(10) not null
	constraint FK_mkvan_kv FOREIGN KEY (MAKV) REFERENCES KV (MAKV),
	TEN_NG_NHAN NVARCHAR(60) not null,
	DC_GH NVARCHAR(100) not null,
	SDT_NG_NHAN CHAR(20) not null,
	MA_KHOANG_TG_GH CHAR(10) not null
	constraint FK_mktg_ktgg FOREIGN KEY (MA_KHOANG_TG_GH) REFERENCES KTG (MA_KHOANG_TG_GH),
	NGAY_GH DATE not null,
	PTTT NVARCHAR(50) not null,
	TT_PHEDUYET NVARCHAR(50) not null,
	TT_GH NVARCHAR(50) not null
)

create table TV_GH (
	MATV_GH CHAR(10) not null
	constraint pk_matvghh PRIMARY KEY (MATV_GH),
	TENTV_GH NVARCHAR(50) not null,
	NGAYSINH DATE null,
	GT NVARCHAR(50) not null,
	SDT_TV CHAR(20) not null,
	DC_TV NVARCHAR(60) not null
)

create table KTG (
	MA_KHOANG_TG_GH CHAR(10) not null
	constraint pk_MAktggh PRIMARY KEY (MA_KHOANG_TG_GH),
	MOTA NVARCHAR(100) null
)

create table DK_GH (
	MATV_GH CHAR(10) not null,
	MA_KHOANG_TG_GH CHAR(10) not null,
	constraint pk_matvhg_khoangmatg PRIMARY KEY (MATV_GH, MA_KHOANG_TG_GH),
	constraint FK_MATVGH_TVhg FOREIGN KEY (MATV_GH) REFERENCES TV_GH (MATV_GH),
	constraint FK_MAKHOANGGHTG_GTK FOREIGN KEY (MA_KHOANG_TG_GH) REFERENCES KTG (MA_KHOANG_TG_GH)
)

create table CTDH (
	MADH_GH CHAR(10) not null,
	TENSPGIAO NVARCHAR(60) not null,
	constraint pk_tensp_mdh PRIMARY KEY (TENSPGIAO, MADH_GH),
	constraint FK_maghhd_ghhg FOREIGN KEY (MADH_GH) REFERENCES DH_GH (MADH_GH),
	SOLUONG INT not null,
	TRONGLUONG FLOAT not null,
	MALMH CHAR(10) not null,
	constraint FK_mahlm_hml FOREIGN KEY (MALMH) REFERENCES LMH (MALMH),
	TIENTH CHAR(50) not null
)

alter table DH_GH add constraint ck_pttt CHECK (PTTT IN ('Chuyen Khoan', 'Tien mat'))

alter table CTDH add constraint ck_soluong CHECK (SOLUONG >= 1)

alter table DH_GH add constraint ck_TTGH CHECK (TT_GH IN ('Nhan Hang','Khong nghe dien thoai','Khong nhan'))
