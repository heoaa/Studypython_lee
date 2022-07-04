-- [복습] 
-- 취미가 수영인 회원들 중에 
-- 마일리지 값이 1000 이상인 
-- 회원아이디, 회원이름, 회원취미, 회원마일리지 조회
-- 정렬은 회원이름 기준 오름차순
select mem_id, mem_name, mem_like, mem_mileage
from member
where mem_like = '수영' and mem_mileage >= 1000
order by mem_name;

--------------------------------------------------------------------------------
-- 서브쿼리(SubQuery) 정리
-- (방법1) select 조회 컬럼 대신 사용하는 경우
--  : 단일컬럼의 단일행만 조회 가능

-- (방법2) wherer 절에 사용하는 경우
--  In () : 단일컬럼의 단일행 또는 다중행 조회 가능
--    =   : 단일컬럼의 단일행만 조회 가능
--------------------------------------------------------------------------------

-- (서브쿼리)
-- 김은대 회원과 동일한 취미를 가지는
-- 회원아이디, 회원이름, 회원취미 조회
select mem_id, mem_name, mem_like
from member
where mem_like = (select mem_like
                    from member
                   where mem_name = '김은대') ;
                    

-- (서브쿼리)
-- 주문내역이 있는 회원에 대한 정보를 조회하기
-- 회원아이디, 회원이름, 주문번호, 주문수량 조회
-- 컬럼대신 select문이므로 하나의 값이 조회되게 지정해주면 사용 가능
select cart_member, cart_no, cart_qty,
       (select mem_name
          from member
         where mem_id = cart_member) as name
from cart ;


-- (서브쿼리)
-- 주문내역이 있는 회원에 대한 정보를 조회하기
-- 회원아이디, 회원이름, 주문번호, 주문수량, 상품명 조회
select cart_member, cart_no, cart_qty,
       (select mem_name
          from member
         where mem_id = cart_member) as name,
       (select prod_name
          from prod
         where cart_prod = prod_id) as p_name
from cart ;


-- 
-- a001 회원이 주문한 상품에 대한
-- 상품분류코드, 상품분류명 조회
select lprod_gu, lprod_nm
from lprod
where lprod_gu in (select prod_lgu
                     from prod
                    where prod_id in (select cart_prod
                                        from cart
                                       where cart_member = 'a001'));
                                       
                                       
-- 이쁜이라는 회원이 주문한 상품 중에
-- 상품분류코드가 P201이고, 
-- 거래처코드가 P20101인
-- 상품코드, 상품명 조회
select prod_id, prod_name
from prod
where prod_lgu = 'P201' and
      prod_buyer = 'P20101' and
      prod_id in (select cart_prod
                    from cart
                   where cart_member in (select mem_id
                                           from member
                                          where mem_name = '이쁜이'));


