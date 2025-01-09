create table tbl_goods_02(
goods_cd number(6) not null primary key,
goods_nm varchar2(30),
goods_price number(8),
cost number(8),
in_date date
);

create table store_tbl_004(
store_cd varchar2(5) not null primary key,
store_nm varchar2(20),
store_fg varchar2(1)
); 

create table sale_tbl_004(
sale_no varchar2(4) not null primary key,
sale_ymd date not null,
sale_fg varchar2(1) not null,
store_cd varchar2(5),
goods_cd number(6),
sale_cnt number(3),
pay_type varchar2(2),
foreign key(store_cd) references store_tbl_004(store_cd),
foreign key(goods_cd) references tbl_goods_02(goods_cd)
);

insert into tbl_goods_02 values(110001, '라면', 1050, 750, '20190302');
insert into tbl_goods_02 values(110002, '빵', 1300, 800, '20190302');
insert into tbl_goods_02 values(110003, '과자', 2000, 1700, '20190302');
insert into tbl_goods_02 values(110004, '탄산음료', 900, 750, '20190302');
insert into tbl_goods_02 values(110005, '삼각김밥', 750, 300, '20190302');
insert into tbl_goods_02 values(110006, '초콜릿', 1500, 1300, '20190302');
insert into tbl_goods_02 values(110007, '우유', 850, 600, '20190302');

insert into store_tbl_004 values('A001', '이태원점', '0');
insert into store_tbl_004 values('A002', '한남점', '0');
insert into store_tbl_004 values('A003', '도원점', '0');
insert into store_tbl_004 values('B001', '혜화점', '1');
insert into store_tbl_004 values('C001', '방배점', '1');
insert into store_tbl_004 values('D001', '사당점', '0');
insert into store_tbl_004 values('D002', '흑석점', '1');
insert into store_tbl_004 values('E001', '금호점', '0');

insert into sale_tbl_004 values('0001', '20190325', '1', 'A001', 110001, 2, '02');
insert into sale_tbl_004 values('0002', '20190325', '1', 'B001', 110003, 2, '02');
insert into sale_tbl_004 values('0003', '20190325', '1', 'D001', 110003, 1, '01');
insert into sale_tbl_004 values('0004', '20190325', '1', 'A001', 110006, 5, '02');
insert into sale_tbl_004 values('0005', '20190325', '1', 'C001', 110006, 2, '02');
insert into sale_tbl_004 values('0006', '20190325', '2', 'C001', 110003, 2, '02');
insert into sale_tbl_004 values('0007', '20190325', '1', 'A002', 110005, 4, '02');
insert into sale_tbl_004 values('0008', '20190325', '1', 'A003', 110004, 4, '02');
insert into sale_tbl_004 values('0009', '20190325', '1', 'B001', 110001, 2, '01');
insert into sale_tbl_004 values('0010', '20190325', '1', 'A002', 110006, 1, '02');

create sequence Jongchan
increment by 1
start with 11;

create sequence dawon
increment by 1
start with 110008;

<--List-->
select goods_cd, goods_nm, goods_price, cost, in_date 
from tbl_goods_02;

<--ListEditConfirm-->
update tbl_goods_02 set goods_nm = ?, goods_price = ?, cost = ?, in_date = ? 
where goods_cd = ?;

<--ListRegi-->
select max(goods_cd)+1, sysdate 
from tbl_goods_02;

<--ListRegiConfirm-->
insert into tbl_goods_02 values(?, ?, ?, ?, ?);

<--Regi-->
select max(sale_no)+1, sysdate 
from sale_tbl_004 
ikgroup by sysdate;

<--RegiConfirm-->
insert into sale_tbl_004 values(?, ?, ?, ?, ?, ?, ?);

<--Result-->
select st.store_nm as 점포명, 
sum(case when sa.pay_type = '01' then sa.sale_cnt * go.goods_price ELSE 0 END) as 현금매출, 
sum(case when sa.pay_type = '02' then sa.sale_cnt * go.goods_price ELSE 0 END) as 카드매출, 
sum(sa.sale_cnt * go.goods_price) as 총매출 
from sale_tbl_004 sa, store_tbl_004 st, tbl_goods_02 go 
where go.goods_cd = sa.goods_cd and sa.store_cd = st.store_cd 
group by st.store_nm 
order by SUM(sa.sale_cnt * go.goods_price) desc;

<--ResultConfirm-->
select st.store_nm, 
sa.sale_fg, sa.sale_no, sa.sale_ymd, go.goods_nm, sa.sale_cnt, 
SUM(sa.sale_cnt * go.goods_price), 
sa.pay_type 
from sale_tbl_004 sa, store_tbl_004 st, tbl_goods_02 go 
where go.goods_cd = sa.goods_cd and sa.store_cd = st.store_cd 
group by st.store_nm, sa.sale_fg, sa.sale_no, sa.sale_ymd, go.goods_nm, sa.sale_cnt, sa.pay_type 
order by sa.pay_type;