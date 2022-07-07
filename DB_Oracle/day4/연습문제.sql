-- [문제1]
-- 상품테이블과 상품분류테이블에서 상품분류코드가 P101인 것에 대한
-- 상품분류코드(상품테이블에 있는 컬럼), 상품명, 상품분류명 조회
-- 정렬은 상품아이디로 내림차순

--<일반 방식>----------------------------------
select lprod_gu, prod_name, lprod_nm
from lprod, prod
where lprod_gu = prod_lgu and
      lprod_gu = 'P101'
order by prod_id desc;

--<표준 방식>----------------------------------
select lprod_gu, prod_name, lprod_nm
from lprod inner join prod
                on(lprod_gu = prod_lgu and
                   lprod_gu = 'P101')
order by prod_id desc;


-- [문제2]
-- 김형모 회원이 구매한 상품에 대한
-- 거래처 정보를 확인하려고 합니다
-- 거래처코드, 거래처명, 회원거주지역(서울, 인천 ...) 조회
-- 단, 상품분류명 중에 캐주얼 단어가 포함된 제품에 대해서만

--<일반 방식>----------------------------------
select buyer_id, buyer_name, substr(mem_add1,1,2)
from prod, buyer, cart, member, lprod
where prod_buyer = buyer_id and
      prod_id = cart_prod and
      cart_member = mem_id and
      prod_lgu = lprod_gu and
      
      mem_name = '김형모' and
      lprod_nm like '%캐주얼%';
      
--<표준 방식>----------------------------------
select buyer_id, buyer_name, substr(mem_add1,1,2)
from prod inner join buyer
            on(prod_buyer = buyer_id)
          inner join cart
            on(prod_id = cart_prod)
          inner join member
            on(cart_member = mem_id and
               mem_name = '김형모')
          inner join lprod
            on(prod_lgu = lprod_gu and
               lprod_nm like '%캐주얼%');
               
               
-- [문제3]
-- 상품분류명에 '전자'가 포함된 상품을 구매한 회원 조회
-- 회원아이디, 회원이름, 상품분류명 조회
-- 단, 상품명에 삼성전자가 포함된 상품을 구매한 회원과
--     회원의 취미가 수영인 회원

--<일반 방식>----------------------------------
select mem_id, mem_name, lprod_nm
from prod, cart, member, lprod
where prod_id = cart_prod and
      cart_member = mem_id and
      prod_lgu = lprod_gu and
      lprod_nm like '%전자%' and
      prod_name like '%삼성전자%' and
      mem_like = '수영';
      
--<표준 방식>----------------------------------
select mem_id, mem_name, lprod_nm
from prod inner join cart
            on(prod_id = cart_prod and
               prod_name like '%삼성전자%')
          inner join member
            on(cart_member = mem_id and
               mem_like = '수영')
          inner join lprod
            on(prod_lgu = lprod_gu and
               lprod_nm like '%전자%');
               
               
-- [문제4]
-- 상품분류테이블과 상품테이블과 거래처테이블과 장바구니 테이블 사용
-- 상품분류코드가 P101인 것을 조회
-- 그리고, 정렬은 상품분류명을 기준으로 내림차순,
--                상품아이디 기준으로 오름차순
-- 상품분류명, 상품아이디, 상품판매가, 거래처담당자, 회원아이디, 주문수량 조회

--<일반 방식>----------------------------------
select lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
from prod, lprod, buyer, cart
where prod_lgu = lprod_gu and
      prod_buyer = buyer_id and 
      prod_id = cart_prod and
      lprod_gu = 'P101'
order by lprod_nm desc,
          prod_id asc;
         
--<표준 방식>----------------------------------
select lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
from prod inner join lprod
            on(prod_lgu = lprod_gu and
               lprod_gu = 'P101')
          inner join buyer
            on(prod_buyer = buyer_id)
          inner join cart
            on(prod_id = cart_prod)
order by lprod_nm desc,
         prod_id asc;


-- [문제5]
-- 상품코드별 구매수량에 대한 최대값, 최소값, 평균값, 합계, 갯수 조회
-- 단, 상품명에 삼성이 포함된 상품을 구매한 회원에 대해서만
-- 조회컬럼 상품코드, 최대값, 최소값, 평균값, 합계, 갯수

--<일반 방식>----------------------------------
select cart_prod, 
       max(cart_qty) as mxqty,
       min(cart_qty) as mnqty,
       round(avg(cart_qty),2) as aqty,
       sum(cart_qty) as sqty,
       count(cart_qty) as cqty
from cart, prod
where cart_prod = prod_id and
      prod_name like '%삼성%'
group by cart_prod;


-- [문제6]
-- 거래처코드 및 상품분류코드별로
-- 판매가에 대한 최고, 최소, 자료수, 평균, 합계 조회
-- 조회컬럼: 거래처코드, 거래처명, 상품분류코드, 상품분류명, 
--           판매가에 대한 최고, 최소, 자료수, 평균, 합계
-- 정렬은 평균을 기준으로 내림차순
-- 단, 판매가의 평균이 100이상인 것

--<일반 방식>----------------------------------
select buyer_id, buyer_name, lprod_gu, lprod_nm,
       max(prod_sale),
       min(prod_sale),
       count(prod_sale),
       round(avg(prod_sale), 2) as avg_prod_sale,
       sum(prod_sale)
from prod, buyer, lprod
where prod_buyer = buyer_id and
      prod_lgu = lprod_gu 
group by buyer_id, buyer_name, lprod_gu, lprod_nm
having avg(prod_sale) >= 100
order by avg_prod_sale desc;



-- [문제7]
-- 거래처별로 group 지어서 매입금액의 합을 검색하고자 합니다
-- 조건은 상품입고테이블의 2005년도 1월 매입일자(입고일자)인것들
-- 매입금액 = 매입수량 * 매입금액
-- 조회컬럼 : 거래처코드, 거래처명, 매입금액의 합
-- (매입금액의 합이 null인 경우 0으로 조회)
-- 정렬은 거래처 코드 및 거래처명을 기준으로 내림차순

--<일반 방식>----------------------------------
select buyer_id, buyer_name,
       -- sum(nvl(buy_qty*buy_cost, 0)) as sumcost
       decode(sum(buy_qty*buy_cost), 
              NULL, 0,
              sum(buy_qty*buy_cost)) as sumcost
from prod, buyer, buyprod
where prod_buyer = buyer_id and
      prod_id = buy_prod and
      -- buy_date between '05/01/01' and '05/01/31'
      extract(year from buy_date) = 2005 and
      extract(month from buy_date) = 1
group by buyer_id, buyer_name
order by buyer_id desc, 
         buyer_name desc;
         
         
-- [문제8]
-- 거래처별로 group지어서 매입금액의 합을 계산하여
-- 매입금액의 합이 1천만원 이상인 상품코드, 상품명 검색
-- 조건은 상품입고테이블의 매입일자(입고일자)가 2005년도 1월
-- 매입금액 = 매입수량*매입금액
-- (매입금액의 합이 null인 경우 0으로 조회)
-- 조회컬럼 : 상품코드, 상품명
-- 정렬은 상품명을 기준으로 오름차순

--<일반 방식>----------------------------------
select prod_id, prod_name
from prod, buyprod, buyer
where prod_id = buy_prod and
      prod_buyer = buyer_id and
      buy_date between '05/01/01' and '05/01/31'
group by prod_id, prod_name
having sum(nvl(buy_qty*buy_cost, 0)) >= 10000000
order by prod_name;


-- [문제8]
-- 거래처별로 group지어서 매입금액의 합을 검색
-- 조건은 상품입고테이블의 매입일자(입고일자)가 2005년도 1월
-- 매입금액 = 매입수량*매입금액
-- 조회컬럼 : 상품코드, 상품명
-- (매입금액의 합이 null인 경우 0으로 조회)
-- 정렬은 거래처 코드 및 거래처명을 기준으로 내림차순

-- 위 결과를 이용하여 매임금액 합이 1천만원 이상인 상품코드, 상품명 검색

--< where절 서브쿼리 >-----
select prod_id, prod_name
from prod
where prod_buyer in (
                     select buyer_id 
                     from prod, buyprod, buyer
                     where prod_id = buy_prod and
                     buy_date between '05/01/01' and '05/01/31'
                     group by buyer_id
                     having sum(nvl(buy_qty*buy_cost, 0)) >= 10000000);
                     
                     
--< from절 서브쿼리 >---------------------------
select prod_id, prod_name
from (select buyer_id, buyer_name,
             sum(nvl(buy_qty*buy_cost, 0)) as sumcost
      from buyer, prod, buyprod
      where buyer_id = prod_buyer and
            prod_id = buy_prod and
            buy_date between '05/01/01' and '05/01/31'
      group by buyer_id, buyer_name
      order by buyer_id desc,
               buyer_name desc) A, prod p
where prod_buyer = A.buyer_id and 
      A.sumcost >= 10000000
order by prod_name asc;

