-- 함수
-- [연습]
-- 상품코드별 구매수량에 대한 최대값, 최소값, 평균값, 합계, 갯수 조회
-- 조회컬럼 상품코드, 최대값, 최소값, 평균값, 합계, 갯수

-- select 문에 집계함수 사용한 경우 일반컬럼을 group by 절에 넣어야함
select cart_prod,
       max(cart_qty) as maxqty,
       min(cart_qty) as minqty,
       round(avg(cart_qty),2) as avgqty,
       sum(cart_qty) as sumqty,
       count(cart_qty) as cqty
       
from cart
group by cart_prod;


select*from cart;

select*from lprod;

-- [문제]
-- 오늘이 2005년도 7월 11일이라 가정하고 
-- 장바구니 테이블에 발생될 추가 주문번호를 검색하시오
-- 조회컬럼 : 현재 마지막 주문번호, 추가주문번호

select max(cart_no) as mno,
       max(cart_no) + 1 as mpno
from cart
where substr(cart_no,1,8) = '20050711';


-- [문제]
-- 회원테이블의 회원전체의 마일리지 평균, 합계, 최대값, 최소값, 인원수를 검색

select round(avg(mem_mileage), 2) as miavg,
       sum(mem_mileage) as misum,
       max(mem_mileage) as mimax,
       min(mem_mileage) as mimin,
       count(mem_mileage) as micount

from member;


-- [문제]
-- 상품테이블에서 거래처별, 상품분류코드별로
-- 판매가에 대한 최고, 최소, 자료수, 평균, 합계를 조회
-- 정렬은 자료수를 기준으로 내림차순
-- 추가로, 거래처명, 상품분류명 조회
-- 단, 합계가 100 이상인 것

-- 함수, 서브쿼리(select문) 연습
select prod_buyer, prod_lgu,
       (select distinct buyer_name from buyer where prod_buyer = buyer_id) as nm,
       (select distinct lprod_gu from lprod where prod_lgu = lprod_gu) as bnm,
       max(prod_sale) as ps_max,
       min(prod_sale) as ps_min,
       count(prod_sale) as ps_count,
       round(avg(prod_sale), 2) as ps_avg,
       sum(prod_sale) as ps_sum
       
from prod
group by prod_buyer, prod_lgu
having sum(prod_sale) >= 100
order by ps_count desc;


-- null

update buyer set buyer_charger = null
where buyer_charger like '김%';

update buyer set buyer_charger = ''
where buyer_charger like '성%';

select buyer_charger
from buyer
where buyer_charger is NULL;

select buyer_charger
from buyer
where buyer_charger is not NULL;

select buyer_name, 
       NVL(buyer_charger, '없다') as charger
from buyer;


-- decode
-- 예시
--if substr(prod_lgu, 1, 2) == 'P1' :
--   print('컴퓨터/전자 제품')
-- elif substr(prod_lgu, 1, 2) == 
--   print(
-- else : print('기타')
--------------------------------------------

select decode(substr(prod_lgu, 1, 2),
       'P1', '컴퓨터/전자 제품',
       'P2', '의류',
       'P3', '잡화',
       '기타') as lgu_nm
from prod;


-- exists
select prod_id, prod_name, prod_lgu
from prod
where exists (
    select lprod_gu
    from lprod
    where lprod_gu = prod_lgu);