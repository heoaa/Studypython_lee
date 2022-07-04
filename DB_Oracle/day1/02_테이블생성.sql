-- ** DB 데이터타입
-- varchar2 : 가변길이 문자열저장(효율적)
-- char : 고정길이 문자열저장(ex. 주민등록번호, 휴대폰번호 등 고정된 길이에 사용)
-- --nchar, nvarchar2 : 한글을 많이 사용하는 경우 n 사용
-- number
-- date : 날짜 데이터형

-- ** 키 key
-- Primary Key : 고유한 값
-- 참조키(Foreign key) : 


-- 1. 상품분류정보테이블 생성
CREATE TABLE lprod(
   lprod_id number(5) NOT NULL,                 -- 상품분류번호
   lprod_gu char(4) NOT NULL,                   -- 상품분류코드
   lprod_nm varchar2(40) NOT NULL,              -- 상품분류이름
   Constraint pk_lprod Primary key (lprod_gu)   -- 제약조건추가
);


SELECT * From lprod;


insert into lprod (lprod_id, lprod_gu,lprod_nm)
    values(1, 'P101', '컴퓨터제품') ;
insert into lprod (lprod_id, lprod_gu,lprod_nm)
    values(2, 'P102', '컴퓨터제품') ;    

    
SELECT lprod_gu, lprod_nm From lprod;

commit;
rollback;

-- 베이스테이블로 테이블 생성


-- 2. 자료 조회
-- 2-1. 회원정보 테이블
SELECT * From member;

-- 2-2. 주문내역관리 테이블
SELECT * From cart;

-- 2-3. 상품정보 테이블
SELECT * From prod;

-- 2-4. 상품분류정보 테이블
SELECT * From lprod;

-- 2-5. 거래처정보 테이블
SELECT * From buyer;

-- 2-6. 입고상품정보 테이블
SELECT * From buyprod;



-- [연습]
-- 1) 회원테이블에서 회원아이디, 회원이름 조회
select mem_id, mem_name from member;

-- 2) 상품코드와 상품명 조회
select prod_id, prod_name from prod;

-- 3) 상품코드, 상품명, 판매금액 조회
-- 단, 판매금액 = 판매가 * 55 로 계산해서 조회
-- 판매금액이 4백만 이상인 데이터만 조회
-- 정렬은 판매금액을 기준으로 내림차순
-- select > from 테이블 > where > 컬럼조회 > order by 순
-- 별칭은 컬럼조회 이후 사용 가능(order by에서만 사용가능)
select prod_id, prod_name,
      (prod_sale*55) as prod_sale
from prod
WHERE (prod_sale*55) >= 4000000
order by prod_sale desc;

-- 4) 상품정보에서 거래처코드 조회
-- 단 중복을 제거하고 조회
select distinct prod_buyer 
from prod ; 

-- 4-1) 상품중에 판매가격이 17만원인 상품 조회
select prod_name, prod_sale 
from prod
where prod_sale = 170000;

-- 4-2) 상품중에 판매가격이 17만원이 아닌 상품 조회
select prod_name, prod_sale 
from prod
where prod_sale != 170000;

-- 4-3) 상품중에 판매가격이 17만원 이상이고 20만원 이하인 상품 조회
select prod_name, prod_sale 
from prod
where prod_sale >= 170000 and prod_sale <= 200000;

-- 4-4) 상품중에 판매가격이 17만원 이상 또는 20만원 이하인 상품 조회
select prod_name, prod_sale 
from prod
where prod_sale >= 170000 or prod_sale <= 200000;


-- 5) 상품 판매가격이 10만원 이상이고, 
-- 상품거래처(공급업체) 코드가 P30203 또는 P10201인
-- 상품코드, 판매가격, 공급업체 코드 조회
select prod_id, prod_sale, prod_buyer
from prod
where prod_sale >= 100000 and (prod_buyer='P30203' or prod_buyer='P10201');

-- 위와 동일
select prod_id, prod_sale, prod_buyer
from prod
where prod_sale >= 100000 and prod_buyer in ('P30203', 'P10201');
--
select prod_id, prod_sale, prod_buyer
from prod
where prod_sale >= 100000 and prod_buyer not in ('P30203', 'P10201');


select distinct prod_buyer
from prod
order by prod_buyer asc;

SELECT * 
FROM buyer
where buyer_id in ( select distinct prod_buyer
                    from prod);
    
-- 6) 한번도 주문한 적이 없는 회원아이디, 이름을 조회
SELECT mem_id, mem_name
from member
where mem_id not in (select distinct cart_member from cart);

-- 7) 상품분류 중에 상품정보에 없는 분류코드만 조회
select lprod_gu
from lprod
where lprod_gu not in (select distinct prod_lgu from prod);

-- 8) 회원의 생일 중에 75년생이 아닌 회원아이디, 생일 조회
-- 생일 기준으로 내림차순
select mem_id, mem_bir 
from member
where mem_bir not like '75/%/%'
order by mem_bir desc ; 

-- 
select mem_id, mem_bir 
from member
where mem_bir not between '1975-01-01' and '1975-12-31'
order by mem_bir desc ;

-- 9) 회원 아이디가 a001인 회원이 주문한 상품코드 조회
-- 조회컬럼은 회원아이디, 상품코드
select cart_prod, cart_member 
from cart
where cart_member = 'a001';