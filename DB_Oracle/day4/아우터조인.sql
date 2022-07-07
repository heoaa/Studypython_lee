-- outer join
-- 전체 분류의 상품 자료 수를 검색, 조회

-- 상품분류정보 9개
select * from lprod;

-- inner join
select lprod_gu, lprod_nm, count(prod_lgu)
from lprod, prod
where lprod_gu = prod_lgu
group by lprod_gu, lprod_nm;

-- outer join
-- (+) : 오라클에서만 사용 가능
select lprod_gu, lprod_nm, count(prod_lgu)
from lprod, prod
where lprod_gu = prod_lgu(+)
group by lprod_gu, lprod_nm
order by lprod_gu;

-- outer join 표준
select lprod_gu, lprod_nm, count(prod_lgu)
from lprod left outer join prod
                on (lprod_gu = prod_lgu)
group by lprod_gu, lprod_nm
order by lprod_gu;


--< 일반 방식 >---------------------------
--일반 조인--
select prod_id, prod_name, sum(buy_qty)
from prod, buyprod
where prod_id = buy_prod and
      buy_date BETWEEN '2005-01-01' and '2005-01-31'
group by prod_id, prod_name;

--아우터 조인-- 39
select prod_id, prod_name, sum(buy_qty)
from prod, buyprod
where prod_id = buy_prod(+) and
      buy_date BETWEEN '2005-01-01' and '2005-01-31'
group by prod_id, prod_name
order by prod_id, prod_name;

--< 표준 방식 >---------------------------
--일반 조인--
select prod_id, prod_name, sum(buy_qty)
from prod inner join buyprod
            on(prod_id = buy_prod and
               buy_date BETWEEN '2005-01-01' and '2005-01-31')
group by prod_id, prod_name;

--아우터 조인-- 74 
-- !! 아우터 조인 전체 집계는 표준 사용
select prod_id, prod_name, sum(buy_qty)
from prod left outer join buyprod
            on(prod_id = buy_prod and
               buy_date BETWEEN '2005-01-01' and '2005-01-31')
group by prod_id, prod_name
order by prod_id, prod_name;



-- self join
select B.buyer_id, B.buyer_name, 
       B.buyer_add1 || ' ' ||
       B.buyer_add2
from buyer A, buyer B
where A.buyer_id = 'P30203' and
      substr(A.buyer_add1,1,2) = substr(B.buyer_add1,1,2);