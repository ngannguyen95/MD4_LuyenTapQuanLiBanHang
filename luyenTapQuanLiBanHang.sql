create database luyenTapQuanLiBanHang;
use luyenTapQuanLiBanHang;
create table khachhang(
makh int auto_increment primary key,
tenkh varchar (30) not null,
diachi varchar (50),
ngaysinh date,
sodt varchar(15) unique
);
create table nhanvien(
manv int auto_increment primary key,
hoten varchar (30) not null,
gioitinh bit not null,
diachi varchar (50) not null,
ngaysinh date not null,
dienthoai varchar (15),
email varchar(255),
noisinh varchar (20) not null,
ngayvaolam date,
manql varchar(4)
);
create table nhacungcap(
mancc int auto_increment primary key,
tenncc varchar (50) not null,
diachi varchar (50) not null,
dienthoai varchar (15) not null,
email varchar (255) not null,
website varchar (30)
);
create table loaisp(
maloaisp int auto_increment primary key,
tenloaisp varchar (30) not null,
ghichu varchar (100) not null
);
create table sanpham(
masp int auto_increment primary key,
maloaisp int,
foreign key(maloaisp) references loaisp(maloaisp),
tensp varchar(30) not null,
donvitinh varchar(10) not null,
ghichu varchar (100)
);
create table phieunhap(
sopn int auto_increment primary key,
manv int,
foreign key(manv) references nhanvien(manv),
mancc int,
foreign key(mancc) references nhacungcap(mancc),
ngaynhap datetime default now() ,
ghichu varchar(100)
);
-- drop table phieunhap;
create table ctphieunhap(
masp int,
foreign key(masp) references sanpham(masp),
sopn int,
foreign key(sopn) references phieunhap(sopn),
soluong smallint default 0,
gianhap real check (gianhap>=0) not null
);
create table phieuxuat(
sopx int auto_increment primary key,
manv int,
foreign key(manv) references nhanvien(manv),
makh int,
foreign key(makh) references khachhang(makh),
ngayban date ,
ghichu text
);

create table ctphieuxuat(
sopx int ,
foreign key(sopx) references phieuxuat(sopx),
masp int,
foreign key(masp) references sanpham(masp),
soluong smallint not null check (soluong >0),
giaban real check (giaban>0) not null
);
-- thm thong tin nhan vien
insert into nhanvien(hoten,gioitinh,diachi,ngaysinh,dienthoai,noisinh) values
("Nguyen Thi Ngan",0,"ha noi","1995-11-20","0350423056","thanh hoa");
insert into nhanvien(hoten,gioitinh,diachi,ngaysinh,dienthoai,noisinh) values
("Nguyen Thi Ngan",0,"ha noi","1995-11-20","0350423056","thanh hoa"),
("Hoàng Thái",1,"ha noi","2000-10-12","0350423056","nghe an"),
("Trần Hiền",1,"ha noi","1998-10-30","0350423056","thái bình"),
("Phạm Mai Hương",0,"ha noi","1997-10-5","0350423056","Hà Tĩnh");

insert into nhacungcap(tenncc,diachi,dienthoai,email) values
("nhã nam","cầu giấy","0253987265","nhanam@gmail.com"),
("phương nam","đống đa","0253987265","phuongnam@gmail.com"),
("nhà sách trẻ","mỹ đình","0253987265","mydinh@gmail.com"),
("nhã nam 2","cầu giấy","0253987265","nhanam@gmail.com"),
("nhã nam 3","cầu giấy","0253987265","nhanam@gmail.com");
insert into khachhang(tenkh,diachi,ngaysinh,sodt) values
("Hồ Văn Khánh","Nghệ An","1995-12-12","0356892152"),
("Trần Văn Hiền","Hà Nội","1995-12-12","0356892112"),
("Mai Văn Tuấn","Hà Tĩnh","1995-12-12","0356892179"),
("Nguyễn Ngọc Huyền","Thái Bình","1995-12-12","0356892196"),
("Nguyễn QuangTrung","Ninh Bình","1995-12-12","0356892178");
insert into loaisp(tenloaisp,ghichu) values
("tiểu thuyết", "kinh dị"),("tình cảm","tuổi teen"),("trinh thám","mạo hiểm");
insert into sanpham(maloaisp,tensp,donvitinh) values
(1,"hôm nay tôi đi học","quyển"),
(1,"trời mưa","quyển"),
(1,"tóc nâu","quyển"),
(2,"quản lí tài chính","quyển"),
(2,"tên cậu là gì","quyển");
insert into ctphieunhap(masp,sopn,soluong,gianhap) values
(1,2,10,20000),(2,1,12,30000),(1,2,6,25000),(2,2,5,23000);
insert into ctphieuxuat(sopx,masp,soluong,giaban) values
(5,1,10,52000),(6,2,7,53000),(7,5,4,54000),(8,4,9,55000);

-- thêm 2 phiếu nhâp trong tháng hiện hành
insert into phieunhap(manv,mancc) values 
(2,3),(3,1);
-- thêm 4 phiếu xuất trong tháng hiện hành
insert into phieuxuat(manv,makh,ngayban) values
(2,2,"2023-4-19"),(3,5,"2023-4-17"),(4,1,"2023-4-16"),(4,4,"2023-4-12");
insert into phieuxuat(manv,makh,ngayban) values
(2,4,"2023-8-19"),(3,5,"2023-10-17"),(1,1,"2023-11-16"),(4,2,"2023-1-12");
-- thêm 1 nhân viên mới
insert into nhanvien(hoten,gioitinh,diachi,ngaysinh,dienthoai,noisinh) values
("Mai Quốc Khánh",1,"Đà nẵng","2000-5-13","03504230556","thanh hoa");
-- cập nhật lại số điện thoại mới cho khách hàng mã "10"
update khachhang set sodt="000000000" where makh like "10";
-- cập nhật lại địa chỉ mới của nhân viên mã "5"
update nhanvien set diachi=" hoang hoa, thanh hoa" where manv like "5";
-- xóa nhân viên mới vừa thêm vào
delete from nhanvien where manv like "6";
-- xóa sản phẩm mã "3"
delete from sanpham where masp like "3";
-- liệt kê thông tin nhân viên sắp xếp theo tuổi 
select * from nhanvien
order by ngaysinh asc;
-- Liệt kê các hóa đơn nhập hàng trong tháng 4/2023, gồm thông tin số phiếu 
-- nhập, mã nhân viên nhập hàng, họ tên nhân viên, họ tên nhà cung cấp, ngày nhập hàng, ghi chú.
select pn.*,nv.hoten,ncc.tenncc
from 
nhanvien nv join phieunhap pn on nv.manv=pn.manv
join nhacungcap ncc on ncc.mancc=pn.mancc
where (select month(pn.ngaynhap)) like "4";
-- Liệt kê tất cả sản phẩm có đơn vị tính là chai, gồm tất cả thông tin về sản phẩm
select sp.*,l.tenloaisp from sanpham sp join loaisp l on sp.maloaisp=l.maloaisp 
where donvitinh like "quyển";
-- Liệt kê chi tiết nhập hàng trong tháng hiện hành gồm thông tin: số phiếu 
-- nhập, mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính, số lượng, giá nhập, thành tiền
select ctpn.*,s.tensp,s.donvitinh,ctpn.soluong*ctpn.gianhap as "Thanh Tien"  from phieunhap pn 
join ctphieunhap ctpn on pn.sopn = ctpn.sopn 
join sanpham s on ctpn.masp=s.masp
where month(pn.ngaynhap) like "4";
-- . Liệt kê các nhà cung cấp có giao dịch mua bán trong tháng hiện hành, gồm 
-- thông tin: mã nhà cung cấp, họ tên nhà cung cấp, địa chỉ, số điện thoại, 
-- email, số phiếu nhập, ngày nhập. Sắp xếp thứ tự theo ngày nhập hàng
select ncc.*,pn.sopn, pn.ngaynhap  
from nhacungcap ncc join phieunhap pn on ncc.mancc=pn.mancc
order by pn.ngaynhap;
-- Liệt kê chi tiết hóa đơn bán hàng trong 6 tháng đầu năm 2023 gồm thông tin: 
-- số phiếu xuất, nhân viên bán hàng, ngày bán, mã sản phẩm, tên sản phẩm, 
-- đơn vị tính, số lượng, giá bán, doanh thu
select px.*,nv.hoten,ctpx.masp,s.tensp,s.donvitinh,ctpx.soluong,ctpx.giaban,ctpx.soluong*ctpx.giaban as "Thanh tien" from phieuxuat px join ctphieuxuat ctpx on px.sopx=ctpx.sopx
join sanpham s on ctpx.masp = s.masp
join nhanvien nv on px.manv = nv.manv
where month(px.ngayban) between 0 and 6;
-- in danh sach khach hang co ngay sinh nhat trong thang 
select * from khachhang 
where month(ngaysinh) like "12";
-- Liệt kê các hóa đơn bán hàng từ ngày 15/04/2018 đến 15/05/2018 gồm các 
-- thông tin: số phiếu xuất, nhân viên bán hàng, ngày bán, mã sản phẩm, tên 
-- sản phẩm, đơn vị tính, số lượng, giá bán, doanh thu.
select px.sopx,nv.hoten,px.ngayban,sp.masp,sp.tensp,sp.donvitinh,ctpx.soluong,ctpx.giaban,ctpx.giaban*ctpx.soluong as "Doanh thu"   from phieuxuat px join nhanvien nv on px.manv=nv.manv
join ctphieuxuat ctpx on px.sopx=ctpx.sopx
join sanpham sp on ctpx.masp=sp.masp ;
-- Liệt kê các hóa đơn mua hàng theo từng khách hàng, gồm các thông tin: số 
-- phiếu xuất, ngày bán, mã khách hàng, tên khách hàng, trị giá
select kh.makh,px.sopx,px.ngayban,kh.tenkh,ctpx.giaban*ctpx.soluong as "Trị Giá"  
from phieuxuat px join khachhang kh on px.makh=kh.makh
join ctphieuxuat ctpx on px.sopx=ctpx.sopx;
-- Cho biết tổng số "trời mưa"  đã bán trong 6 tháng đầu năm 
-- 2018. Thông tin hiển thị: tổng số lượng.
select s.tensp, sum(ctpx.soluong) as "tong so"   from phieuxuat px join ctphieuxuat ctpx on px.sopx
join sanpham s on ctpx.masp=s.masp
where (s.tensp = "trời mưa") and (month (px.ngayban) between 0 and 6);
-- Tổng kết doanh thu theo từng khách hàng theo tháng, gồm các thông tin: 
-- tháng, mã khách hàng, tên khách hàng, địa chỉ, tổng tiền
select kh.makh,kh.tenkh,kh.diachi,month(px.ngayban),ctpx.soluong*ctpx.giaban as "Thành tiền"
from phieuxuat px join ctphieuxuat ctpx on px.sopx=ctpx.sopx
join khachhang kh on px.makh = kh.makh
order by kh.makh ;
-- Thống kê tổng số lượng sản phẩm đã bán theo từng tháng trong năm, gồm 
-- thông tin: năm, tháng, mã sản phẩm, tên sản phẩm, đơn vị tính, tổng số lượng.
select year(px.ngayban), month(px.ngayban), sp.masp, sp.tensp, sp.donvitinh, count(*) as `so luong`
 from phieuxuat px join ctphieuxuat ctpx on px.sopx = ctpx.sopx
join sanpham sp on ctpx.masp = sp.masp
group by year(px.ngayban), month(px.ngayban), sp.masp;
-- Liệt kê các hóa đơn bán hàng của tháng 4 và tháng 10 năm 2023, gồm các 
-- thông tin: số phiếu, ngày bán, họ tên nhân viên bán hàng, họ tên khách hàng, tổng trị giá
select px.sopx,px.ngayban,nv.hoten,k.tenkh from phieuxuat px join ctphieuxuat ctpx on px.sopx= ctpx.sopx 
join nhanvien nv on px.manv= nv.manv
join khachhang k on px.makh=k.makh
where month(px.ngayban) in (11, 4);







