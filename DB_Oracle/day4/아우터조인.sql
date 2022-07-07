-- outer join
-- ��ü �з��� ��ǰ �ڷ� ���� �˻�, ��ȸ

-- ��ǰ�з����� 9��
select * from lprod;

-- inner join
select lprod_gu, lprod_nm, count(prod_lgu)
from lprod, prod
where lprod_gu = prod_lgu
group by lprod_gu, lprod_nm;

-- outer join
-- (+) : ����Ŭ������ ��� ����
select lprod_gu, lprod_nm, count(prod_lgu)
from lprod, prod
where lprod_gu = prod_lgu(+)
group by lprod_gu, lprod_nm
order by lprod_gu;

-- outer join ǥ��
select lprod_gu, lprod_nm, count(prod_lgu)
from lprod left outer join prod
                on (lprod_gu = prod_lgu)
group by lprod_gu, lprod_nm
order by lprod_gu;


--< �Ϲ� ��� >---------------------------
--�Ϲ� ����--
select prod_id, prod_name, sum(buy_qty)
from prod, buyprod
where prod_id = buy_prod and
      buy_date BETWEEN '2005-01-01' and '2005-01-31'
group by prod_id, prod_name;

--�ƿ��� ����-- 39
select prod_id, prod_name, sum(buy_qty)
from prod, buyprod
where prod_id = buy_prod(+) and
      buy_date BETWEEN '2005-01-01' and '2005-01-31'
group by prod_id, prod_name
order by prod_id, prod_name;

--< ǥ�� ��� >---------------------------
--�Ϲ� ����--
select prod_id, prod_name, sum(buy_qty)
from prod inner join buyprod
            on(prod_id = buy_prod and
               buy_date BETWEEN '2005-01-01' and '2005-01-31')
group by prod_id, prod_name;

--�ƿ��� ����-- 74 
-- !! �ƿ��� ���� ��ü ����� ǥ�� ���
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