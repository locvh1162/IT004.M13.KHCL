USE QLBH

--LAB 3

--BAI TAP BAT BUOC

--III.15

SELECT MASP, TENSP FROM SANPHAM
EXCEPT
SELECT SANPHAM.MASP, TENSP
FROM SANPHAM INNER JOIN CTHD ON CTHD.MASP = SANPHAM.MASP

--III.16

SELECT MASP, TENSP FROM SANPHAM
EXCEPT (
SELECT SANPHAM.MASP, TENSP
FROM SANPHAM INNER JOIN CTHD ON CTHD.MASP = SANPHAM.MASP
			INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE YEAR(NGHD) = 2006 )

--III.17

SELECT MASP, TENSP FROM SANPHAM
WHERE NUOCSX='Trung Quoc'
EXCEPT (
SELECT SANPHAM.MASP, TENSP
FROM SANPHAM INNER JOIN CTHD ON CTHD.MASP = SANPHAM.MASP
			INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE YEAR(NGHD)=2006 AND NUOCSX='Trung Quoc')

--III.18

SELECT SOHD FROM HOADON AS T1
WHERE NOT EXISTS (
	SELECT MASP FROM SANPHAM AS T2
	WHERE NUOCSX = 'Singapore' AND NOT EXISTS (
		SELECT * FROM CTHD AS T3
		WHERE T3.MASP = T2.MASP AND T3.SOHD = T1.SOHD
	)
)

--III.19

SELECT SOHD FROM HOADON AS T1
WHERE YEAR(NGHD)=2006 AND NOT EXISTS (
	SELECT MASP FROM SANPHAM AS T2
	WHERE NUOCSX = 'Singapore' AND NOT EXISTS (
		SELECT * FROM CTHD AS T3
		WHERE T3.MASP = T2.MASP AND T3.SOHD = T1.SOHD
	)
)

--III.20

SELECT COUNT(SOHD) 
FROM HOADON LEFT OUTER JOIN KHACHHANG ON HOADON.MAKH = KHACHHANG.MAKH
WHERE NGHD < NGDK OR HOADON.MAKH IS NULL

--III.21

SELECT COUNT(DISTINCT SANPHAM.MASP)
FROM (SANPHAM INNER JOIN CTHD ON SANPHAM.MASP=CTHD.MASP INNER JOIN HOADON ON HOADON.SOHD=CTHD.SOHD)
WHERE YEAR(NGHD)=2006

--III.22

SELECT MAX(TRIGIA) AS TGLN, MIN(TRIGIA) AS TGNN FROM HOADON

--III.23

SELECT AVG(TRIGIA) AS TGTB FROM HOADON
WHERE YEAR(NGHD)=2006

--III.24

SELECT SUM(TRIGIA) AS DOANHTHU FROM HOADON
WHERE YEAR(NGHD)=2006

--III.25

SELECT SOHD FROM HOADON
WHERE (TRIGIA >= (SELECT MAX(TRIGIA) FROM HOADON))

---III.26

SELECT HOTEN 
FROM (KHACHHANG INNER JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH)
WHERE (TRIGIA >= (SELECT MAX(TRIGIA) FROM HOADON))

--III.27

SELECT TOP 3 MAKH, HOTEN FROM KHACHHANG
ORDER BY DOANHSO DESC

--III.28

SELECT MASP, TENSP FROM SANPHAM
WHERE GIA IN (SELECT DISTINCT TOP 3 GIA FROM SANPHAM ORDER BY GIA DESC)

--III.29

SELECT MASP, TENSP FROM SANPHAM
WHERE NUOCSX='Thai Lan' AND GIA IN (SELECT DISTINCT TOP 3 GIA FROM SANPHAM ORDER BY GIA DESC)

--III.30

SELECT MASP, TENSP 
FROM SANPHAM
WHERE NUOCSX='Trung Quoc' 
	AND GIA IN (SELECT DISTINCT TOP 3 GIA 
				FROM SANPHAM
				WHERE NUOCSX='Trung Quoc'
				ORDER BY GIA DESC)

---BAI TAP LAM THEM

USE QLGV

--III.7

SELECT MONHOC.MAMH, TENMH 
FROM (MONHOC INNER JOIN GIANGDAY ON MONHOC.MAMH=GIANGDAY.MAMH
				INNER JOIN GIAOVIEN ON GIANGDAY.MAGV = GIAOVIEN.MAGV
				INNER JOIN LOP ON GIAOVIEN.MAGV=LOP.MAGVCN)
WHERE GIANGDAY.MALOP='K11' AND (HOCKY=1 AND NAM=2006)

--III.8

SELECT CONCAT(HO, ' ', TEN) AS HOTEN 
FROM (HOCVIEN INNER JOIN LOP ON HOCVIEN.MAHV=LOP.TRGLOP
				INNER JOIN GIANGDAY ON LOP.MALOP=GIANGDAY.MALOP
				INNER JOIN GIAOVIEN ON GIAOVIEN.MAGV = GIANGDAY.MAGV
				INNER JOIN MONHOC ON MONHOC.MAMH = GIANGDAY.MAMH)
WHERE GIAOVIEN.HOTEN='Nguyen To Lan' AND TENMH='Co So Du Lieu'

--III.9

SELECT MAMH, TENMH FROM MONHOC
WHERE MAMH IN (SELECT MAMH_TRUOC 
				FROM (MONHOC INNER JOIN DIEUKIEN ON MONHOC.MAMH=DIEUKIEN.MAMH)
				WHERE TENMH = 'Co So Du Lieu')

--III.10

SELECT MONHOC.MAMH, TENMH 
FROM (MONHOC INNER JOIN DIEUKIEN ON MONHOC.MAMH=DIEUKIEN.MAMH)
WHERE MAMH_TRUOC='CTRR'

--III.11

SELECT HOTEN 
FROM (GIAOVIEN INNER JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV)
WHERE MALOP='K11' AND (HOCKY=1 AND NAM=2006)
INTERSECT
SELECT HOTEN 
FROM (GIAOVIEN INNER JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV)
WHERE MALOP='K12' AND (HOCKY=1 AND NAM=2006)

--III.12

SELECT HOCVIEN.MAHV, CONCAT(HO, ' ', TEN) AS HOTEN 
FROM (HOCVIEN INNER JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV)
WHERE MAMH='CSDL' AND (LANTHI = 1 AND KQUA = 'Khong Dat')
EXCEPT
SELECT HOCVIEN.MAHV, CONCAT(HO, ' ', TEN) AS HOTEN 
FROM (HOCVIEN INNER JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV)
WHERE MAMH='CSDL' AND LANTHI > 1

--III.13

SELECT MAGV, HOTEN FROM GIAOVIEN
EXCEPT
SELECT GIAOVIEN.MAGV, HOTEN 
FROM GIAOVIEN INNER JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV

--III.14

SELECT MAGV, HOTEN FROM GIAOVIEN
EXCEPT
SELECT GIAOVIEN.MAGV, HOTEN 
FROM GIAOVIEN INNER JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV
		INNER JOIN MONHOC ON MONHOC.MAMH=GIANGDAY.MAMH
WHERE GIAOVIEN.MAKHOA = MONHOC.MAKHOA

--III.15

SELECT DISTINCT CONCAT(HO, ' ', TEN) AS HOTEN 
FROM (HOCVIEN INNER JOIN KETQUATHI ON HOCVIEN.MAHV=KETQUATHI.MAHV)
WHERE MALOP='K11' AND (LANTHI > 2 OR (LANTHI = 2 AND MAMH='CTRR' AND DIEM=5))

--III.16

SELECT HOTEN 
FROM GIAOVIEN INNER JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV
WHERE GIANGDAY.MAMH='CTRR' AND (SELECT COUNT(MALOP) FROM GIANGDAY)>1


















