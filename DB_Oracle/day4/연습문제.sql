-- [����1]
-- ��ǰ���̺�� ��ǰ�з����̺��� ��ǰ�з��ڵ尡 P101�� �Ϳ� ����
-- ��ǰ�з��ڵ�(��ǰ���̺� �ִ� �÷�), ��ǰ��, ��ǰ�з��� ��ȸ
-- ������ ��ǰ���̵�� ��������

--<�Ϲ� ���>----------------------------------
select lprod_gu, prod_name, lprod_nm
from lprod, prod
where lprod_gu = prod_lgu and
      lprod_gu = 'P101'
order by prod_id desc;

--<ǥ�� ���>----------------------------------
select lprod_gu, prod_name, lprod_nm
from lprod inner join prod
                on(lprod_gu = prod_lgu and
                   lprod_gu = 'P101')
order by prod_id desc;


-- [����2]
-- ������ ȸ���� ������ ��ǰ�� ����
-- �ŷ�ó ������ Ȯ���Ϸ��� �մϴ�
-- �ŷ�ó�ڵ�, �ŷ�ó��, ȸ����������(����, ��õ ...) ��ȸ
-- ��, ��ǰ�з��� �߿� ĳ�־� �ܾ ���Ե� ��ǰ�� ���ؼ���

--<�Ϲ� ���>----------------------------------
select buyer_id, buyer_name, substr(mem_add1,1,2)
from prod, buyer, cart, member, lprod
where prod_buyer = buyer_id and
      prod_id = cart_prod and
      cart_member = mem_id and
      prod_lgu = lprod_gu and
      
      mem_name = '������' and
      lprod_nm like '%ĳ�־�%';
      
--<ǥ�� ���>----------------------------------
select buyer_id, buyer_name, substr(mem_add1,1,2)
from prod inner join buyer
            on(prod_buyer = buyer_id)
          inner join cart
            on(prod_id = cart_prod)
          inner join member
            on(cart_member = mem_id and
               mem_name = '������')
          inner join lprod
            on(prod_lgu = lprod_gu and
               lprod_nm like '%ĳ�־�%');
               
               
-- [����3]
-- ��ǰ�з��� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ
-- ȸ�����̵�, ȸ���̸�, ��ǰ�з��� ��ȸ
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ����
--     ȸ���� ��̰� ������ ȸ��

--<�Ϲ� ���>----------------------------------
select mem_id, mem_name, lprod_nm
from prod, cart, member, lprod
where prod_id = cart_prod and
      cart_member = mem_id and
      prod_lgu = lprod_gu and
      lprod_nm like '%����%' and
      prod_name like '%�Ｚ����%' and
      mem_like = '����';
      
--<ǥ�� ���>----------------------------------
select mem_id, mem_name, lprod_nm
from prod inner join cart
            on(prod_id = cart_prod and
               prod_name like '%�Ｚ����%')
          inner join member
            on(cart_member = mem_id and
               mem_like = '����')
          inner join lprod
            on(prod_lgu = lprod_gu and
               lprod_nm like '%����%');
               
               
-- [����4]
-- ��ǰ�з����̺�� ��ǰ���̺�� �ŷ�ó���̺�� ��ٱ��� ���̺� ���
-- ��ǰ�з��ڵ尡 P101�� ���� ��ȸ
-- �׸���, ������ ��ǰ�з����� �������� ��������,
--                ��ǰ���̵� �������� ��������
-- ��ǰ�з���, ��ǰ���̵�, ��ǰ�ǸŰ�, �ŷ�ó�����, ȸ�����̵�, �ֹ����� ��ȸ

--<�Ϲ� ���>----------------------------------
select lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
from prod, lprod, buyer, cart
where prod_lgu = lprod_gu and
      prod_buyer = buyer_id and 
      prod_id = cart_prod and
      lprod_gu = 'P101'
order by lprod_nm desc,
          prod_id asc;
         
--<ǥ�� ���>----------------------------------
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


-- [����5]
-- ��ǰ�ڵ庰 ���ż����� ���� �ִ밪, �ּҰ�, ��հ�, �հ�, ���� ��ȸ
-- ��, ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ������ ȸ���� ���ؼ���
-- ��ȸ�÷� ��ǰ�ڵ�, �ִ밪, �ּҰ�, ��հ�, �հ�, ����

--<�Ϲ� ���>----------------------------------
select cart_prod, 
       max(cart_qty) as mxqty,
       min(cart_qty) as mnqty,
       round(avg(cart_qty),2) as aqty,
       sum(cart_qty) as sqty,
       count(cart_qty) as cqty
from cart, prod
where cart_prod = prod_id and
      prod_name like '%�Ｚ%'
group by cart_prod;


-- [����6]
-- �ŷ�ó�ڵ� �� ��ǰ�з��ڵ庰��
-- �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ� ��ȸ
-- ��ȸ�÷�: �ŷ�ó�ڵ�, �ŷ�ó��, ��ǰ�з��ڵ�, ��ǰ�з���, 
--           �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ�
-- ������ ����� �������� ��������
-- ��, �ǸŰ��� ����� 100�̻��� ��

--<�Ϲ� ���>----------------------------------
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



-- [����7]
-- �ŷ�ó���� group ��� ���Աݾ��� ���� �˻��ϰ��� �մϴ�
-- ������ ��ǰ�԰����̺��� 2005�⵵ 1�� ��������(�԰�����)�ΰ͵�
-- ���Աݾ� = ���Լ��� * ���Աݾ�
-- ��ȸ�÷� : �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��� ��
-- (���Աݾ��� ���� null�� ��� 0���� ��ȸ)
-- ������ �ŷ�ó �ڵ� �� �ŷ�ó���� �������� ��������

--<�Ϲ� ���>----------------------------------
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
         
         
-- [����8]
-- �ŷ�ó���� group��� ���Աݾ��� ���� ����Ͽ�
-- ���Աݾ��� ���� 1õ���� �̻��� ��ǰ�ڵ�, ��ǰ�� �˻�
-- ������ ��ǰ�԰����̺��� ��������(�԰�����)�� 2005�⵵ 1��
-- ���Աݾ� = ���Լ���*���Աݾ�
-- (���Աݾ��� ���� null�� ��� 0���� ��ȸ)
-- ��ȸ�÷� : ��ǰ�ڵ�, ��ǰ��
-- ������ ��ǰ���� �������� ��������

--<�Ϲ� ���>----------------------------------
select prod_id, prod_name
from prod, buyprod, buyer
where prod_id = buy_prod and
      prod_buyer = buyer_id and
      buy_date between '05/01/01' and '05/01/31'
group by prod_id, prod_name
having sum(nvl(buy_qty*buy_cost, 0)) >= 10000000
order by prod_name;


-- [����8]
-- �ŷ�ó���� group��� ���Աݾ��� ���� �˻�
-- ������ ��ǰ�԰����̺��� ��������(�԰�����)�� 2005�⵵ 1��
-- ���Աݾ� = ���Լ���*���Աݾ�
-- ��ȸ�÷� : ��ǰ�ڵ�, ��ǰ��
-- (���Աݾ��� ���� null�� ��� 0���� ��ȸ)
-- ������ �ŷ�ó �ڵ� �� �ŷ�ó���� �������� ��������

-- �� ����� �̿��Ͽ� ���ӱݾ� ���� 1õ���� �̻��� ��ǰ�ڵ�, ��ǰ�� �˻�

--< where�� �������� >-----
select prod_id, prod_name
from prod
where prod_buyer in (
                     select buyer_id 
                     from prod, buyprod, buyer
                     where prod_id = buy_prod and
                     buy_date between '05/01/01' and '05/01/31'
                     group by buyer_id
                     having sum(nvl(buy_qty*buy_cost, 0)) >= 10000000);
                     
                     
--< from�� �������� >---------------------------
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

