-- [조회 방법 정리]

-- 1. 테이블 찾기
--   제시된 컬럼들의 소속 찾기

-- 2. 테이블 간의 관계 찾기
--   ERD에서 연결된 순서대로 PK와 FK 컬럼 또는,
--   성격이 같은 값으로 연결할 수 있는 컬럼 찾기

-- 3. 작성 순서 정하기
--   조회하는 컬럼이 속한 테이블이 가장 밖 (1순위)
--   1순위 테이블부터 ERD 순서대로 작성
--   조건은 해당 컬럼이  속한 테이블에서 조건 처리


-- 상품분류 중에 '전자'가 포함된 상품을 구매한 회원 조회하기
-- 회원아이디, 회원이름 조회
-- 단, 상품명에 삼성전자가 포함된 상품을 구매한 회원
-- 그리고, 회원의 취미가 수영인 회원

-- 1. 테이블 찾기
--  lprod, cart, member, prod

-- 2. 테이블 간의 관계 찾기
--  member - cart - prod - lprod
--  lprod_gu = prod_lgu
--  prod_id = cart_prod
--  cart_member = mem_id

-- 3. 작성 순서 조회
--  조회하는 컬럼 먼저 작성
--  member > cart > prod > lprod

select mem_id, mem_name from member 
 where mem_like = '수영' and
      mem_id in (
        select cart_member from cart 
         where cart_prod in (
            select prod_id from prod
             where prod_name like '%삼성전자%' and
                   prod_lgu in (
                    select lprod_gu from lprod
                     where lprod_nm like '%전자%'))); 
                     
                     
-- [문제]
-- 김형모 회원이 구매한 상품에 대한 거래처 정보 확인
-- 거래처코드, 거래처명, 지역, 거래처 전화번호 조회
-- 단, 상품분류명 중에 캐주얼 단어가 포함된 제품에 대해서만

select buyer_id, buyer_name,
       substr(buyer_add1,1,2), buyer_comtel
from buyer
where buyer_lgu in (
    select lprod_gu from lprod
     where lprod_nm like '%캐주얼%' and
           lprod_gu in (
        select prod_lgu from prod
         where prod_id in (
            select cart_prod from cart
             where cart_member in (
                select mem_id from member
                 where mem_name = '김형모'))));
                 
                 
-- lprod - buyer 연결x

select buyer_id, buyer_name,
       substr(buyer_add1,1,2) as add1, 
       buyer_comtel
from buyer
where buyer_id in (
    select prod_buyer from prod
     where prod_lgu in (
            select lprod_gu from lprod
             where lprod_nm like '%캐주얼%') and
           prod_id in (
            select cart_prod from cart
             where cart_member in (
                select mem_id from member
                 where mem_name = '김형모')));
                 
                 
-- [문제]
-- 여자인 회원이 구매한 상품 중에
--상품분류에 전자가 포함되어 있고,
-- 거래처의 지역이 서울인
-- 상품코드, 상품명 조회

select prod_id, prod_name
from prod
where prod_buyer in (
        select buyer_id from buyer
         where substr(buyer_add1,1,2) = '서울') and
      prod_lgu in (
        select lprod_gu from lprod
         where lprod_nm like '%전자%') and
      prod_id in (
        select cart_prod from cart
         where cart_member in (
            select mem_id from member
             where mod(substr(mem_regno2,1,1),2) = 0));
             
