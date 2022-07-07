-- �Լ�
-- [����]
-- ��ǰ�ڵ庰 ���ż����� ���� �ִ밪, �ּҰ�, ��հ�, �հ�, ���� ��ȸ
-- ��ȸ�÷� ��ǰ�ڵ�, �ִ밪, �ּҰ�, ��հ�, �հ�, ����

-- select ���� �����Լ� ����� ��� �Ϲ��÷��� group by ���� �־����
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

-- [����]
-- ������ 2005�⵵ 7�� 11���̶� �����ϰ� 
-- ��ٱ��� ���̺� �߻��� �߰� �ֹ���ȣ�� �˻��Ͻÿ�
-- ��ȸ�÷� : ���� ������ �ֹ���ȣ, �߰��ֹ���ȣ

select max(cart_no) as mno,
       max(cart_no) + 1 as mpno
from cart
where substr(cart_no,1,8) = '20050711';


-- [����]
-- ȸ�����̺��� ȸ����ü�� ���ϸ��� ���, �հ�, �ִ밪, �ּҰ�, �ο����� �˻�

select round(avg(mem_mileage), 2) as miavg,
       sum(mem_mileage) as misum,
       max(mem_mileage) as mimax,
       min(mem_mileage) as mimin,
       count(mem_mileage) as micount

from member;


-- [����]
-- ��ǰ���̺��� �ŷ�ó��, ��ǰ�з��ڵ庰��
-- �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ踦 ��ȸ
-- ������ �ڷ���� �������� ��������
-- �߰���, �ŷ�ó��, ��ǰ�з��� ��ȸ
-- ��, �հ谡 100 �̻��� ��

-- �Լ�, ��������(select��) ����
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
where buyer_charger like '��%';

update buyer set buyer_charger = ''
where buyer_charger like '��%';

select buyer_charger
from buyer
where buyer_charger is NULL;

select buyer_charger
from buyer
where buyer_charger is not NULL;

select buyer_name, 
       NVL(buyer_charger, '����') as charger
from buyer;


-- decode
-- ����
--if substr(prod_lgu, 1, 2) == 'P1' :
--   print('��ǻ��/���� ��ǰ')
-- elif substr(prod_lgu, 1, 2) == 
--   print(
-- else : print('��Ÿ')
--------------------------------------------

select decode(substr(prod_lgu, 1, 2),
       'P1', '��ǻ��/���� ��ǰ',
       'P2', '�Ƿ�',
       'P3', '��ȭ',
       '��Ÿ') as lgu_nm
from prod;


-- exists
select prod_id, prod_name, prod_lgu
from prod
where exists (
    select lprod_gu
    from lprod
    where lprod_gu = prod_lgu);