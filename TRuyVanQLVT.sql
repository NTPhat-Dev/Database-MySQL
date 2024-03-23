use QuanLyVT

--Cau 1:
select * from TonKho
select TenVTu from VatTu where DvTinh = 'Bo'

--Cau 2:
select * from DonDH where MONTH(NgayDH) = 12

--Cau 3:
select * from NhaCC where DiaChi like '%Binh Duong%'

--Cau 4:
select * from VatTu where DvTinh = 'Cai' AND PhanTram = 25

--Cau 5:
select SoPN, MaVTu, SLNhap, DGNhap, (SLNhap*DGNhap) as ThanhTienNhap from CTPNhap 

--Cau 6:
select SoPN, MaVTu, SLNhap, DGNhap, (SLNhap*DGNhap) as ThanhTienNhap from CTPNhap where SLNhap > 5

--Cau 7:
select SoPX, MaVTu, SLXuat, DGXuat, (DGXuat*SLXuat) as thanhtienxuat from CTPXuat

--Cau 8:
select MAX(SLDat) as sl_cao_nhat, MIN(SLDat) as soluong_thap_nhat  from CTDonDH where MaVTu = 'TV14'

--Cau 9:
select SUM(SLDat) as Tong_SL_DAT from CTDonDH where SoDH = 'D006'

--Cau 10:
select MaVTu, DGXuat from CTPXuat where SLXuat >= 2 order by DGXuat desc 

--Cau 11:
SELECT PN.SoPN, VT.MaVTu, VT.TenVTu, CTPN.SLNhap, CTPN.DGNhap, CTPN.SLNhap * CTPN.DGNhap AS ThanhTienNhap
FROM CTPNhap CTPN
JOIN PNhap PN ON CTPN.SoPN = PN.SoPN
JOIN VatTu VT ON CTPN.MaVTu = VT.MaVTu
WHERE VT.DvTinh = 'Bo'

--Cau 12:
SELECT VT.MaVTu, VT.TenVTu, SUM(CTPN.SLNhap) AS TongSoLuongNhap
FROM CTPNhap CTPN
JOIN VatTu VT ON CTPN.MaVTu = VT.MaVTu
GROUP BY VT.MaVTu, VT.TenVTu

--Cau 13:
SELECT V.MaVTu, V.TenVTu, V.DvTinh FROM VatTu V
LEFT JOIN CTPXuat C ON V.MaVTu = C.MaVTu
WHERE C.MaVTu IS NULL


--Cau 14:
select TenNhaCC, DiaChi, DienThoai from NhaCC LEFT JOIN DonDH ON NhaCC.MaNhaCC = DonDH.MaNhaCC
where DonDH.MaNhaCC is null

--Cau 15:
select top 3 TenVTu, COUNT(DH.SoDH) as SoDonHang from VatTu MH
join CTDonDH CTDH ON MH.MaVTu = CTDH.MaVTu
join DonDH DH ON CTDH.SoDH = DH.SoDH
group by MH.TenVTu
order by SoDonHang DESC 

