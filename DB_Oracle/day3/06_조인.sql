--< cross join >---------------------------------------------------

-- 일반방식
select * from lprod, prod;
-- 표준방식
select * from lprod cross join prod;


--< inner join 조건 >-----------------------------------------------
-- PK, FK가 있어야 함
-- 관계조건 성립 : PK = FK
-- 관계조건 갯수 : from절에 제시된 (테이블 갯수 - 1개)

-- 상품테이블에서 상품코드, 상품명, 분류명 조회
-- 1. prod, lprod
-- 2. lprod_lgu = lprod_gu
-- 3. lprod > prod

--< 일반방식 >------------------------------------------------------
select prod_id, prod_name, lprod_nm, 
       buyer_name, cart_qty, mem_name
from lprod, prod, buyer, cart, member
-- 관계조건식
where lprod_gu = prod_lgu and
      buyer_id = prod_buyer and
      prod_id = cart_prod and
      mem_id = cart_member and
      mem_id = 'a001';


--< 표준방식 >------------------------------------------------------
select prod_id, prod_name, lprod_nm, buyer_name,
       cart_qty, mem_name
-- 서브쿼리 연결 순서 참고하여 순서대로 작성해야 함
from lprod inner join prod
            on (lprod_gu = prod_lgu)
           inner join buyer
            on (buyer_id = prod_buyer)
           inner join cart
            on (prod_id = cart_prod)
           inner join member
            on (mem_id = cart_member and
                mem_id = 'a001');
        
                
-- [문제]
-- 상품테이블에서 상품코드, 상품명, 분류명, 거래처명, 거래처주소 조회
-- 1) 판매가격이 10만원 이하이고
-- 2) 거래처 주소가 부산인 경우만 조회
-- 일반, 표준방식 모두 해보기

--< 일반방식 >------------------------------------------------------
select prod_id, prod_name, 
       lprod_nm, buyer_name, 
       buyer_add1
       
from prod, lprod, buyer
where prod_lgu = lprod_gu and
      prod_buyer = buyer_id and
      prod_sale <= 100000 and
      substr(buyer_add1,1,2) = '부산' ; 

--< 표준방식 >------------------------------------------------------
select prod_id, prod_name, 
       lprod_nm, buyer_name, 
       buyer_add1
       
from prod inner join lprod
            on(prod_lgu = lprod_gu and
               prod_sale <= 100000)
          inner join buyer
            on(prod_buyer = buyer_id and
               substr(buyer_add1,1,2) = '부산');
               
               
-- [문제]
-- 상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거래처명 조회
-- 단, 상품분류 코드가 P101, P201, P301인 것
--     매입수량이 15개 이상인 것
--     서울에 살고 있는 회원 중 생일이 1974년생인 회원
-- 정렬은 회원아이디 기준 내림차순, 매입수량 기준 오름차순
-- 일반, 표준방식 모두 해보기
select*from member;

--< 일반방식 >------------------------------------------------------
select lprod_nm, prod_name, prod_color, 
       buy_qty, cart_qty, buyer_name
from prod, lprod, buyprod, buyer, cart, member
where prod_lgu = lprod_gu and
      prod_id = buy_prod and
      prod_id = cart_prod and
      cart_member = mem_id and
      prod_buyer = buyer_id and
      -- lprod_gu in ('P101','P201','P301')
      (lprod_gu = 'P101' or lprod_gu = 'P201' or lprod_gu = 'P301') and
      buy_qty >= 15 and
      mem_add1 like '서울%' and
      to_char(substr(mem_bir,1,2)) = '74';

--< 표준방식 >------------------------------------------------------
select lprod_nm, prod_name, prod_color, 
       buy_qty, cart_qty, buyer_name
from prod inner join lprod
            on(prod_lgu = lprod_gu and
               lprod_gu in ('P101','P201','P301'))
          inner join buyprod
            on(prod_id = buy_prod and
               buy_qty >= 15)
          inner join buyer
            on(prod_buyer = buyer_id)
          inner join cart
            on(prod_id = cart_prod)
          inner join member
            on(cart_member = mem_id and
               mem_add1 like '서울%' and
               to_char(substr(mem_bir,1,2)) = '74');