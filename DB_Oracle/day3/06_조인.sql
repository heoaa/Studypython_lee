--< cross join >---------------------------------------------------

-- �Ϲݹ��
select * from lprod, prod;
-- ǥ�ع��
select * from lprod cross join prod;


--< inner join ���� >-----------------------------------------------
-- PK, FK�� �־�� ��
-- �������� ���� : PK = FK
-- �������� ���� : from���� ���õ� (���̺� ���� - 1��)

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з��� ��ȸ
-- 1. prod, lprod
-- 2. lprod_lgu = lprod_gu
-- 3. lprod > prod

--< �Ϲݹ�� >------------------------------------------------------
select prod_id, prod_name, lprod_nm, 
       buyer_name, cart_qty, mem_name
from lprod, prod, buyer, cart, member
-- �������ǽ�
where lprod_gu = prod_lgu and
      buyer_id = prod_buyer and
      prod_id = cart_prod and
      mem_id = cart_member and
      mem_id = 'a001';


--< ǥ�ع�� >------------------------------------------------------
select prod_id, prod_name, lprod_nm, buyer_name,
       cart_qty, mem_name
-- �������� ���� ���� �����Ͽ� ������� �ۼ��ؾ� ��
from lprod inner join prod
            on (lprod_gu = prod_lgu)
           inner join buyer
            on (buyer_id = prod_buyer)
           inner join cart
            on (prod_id = cart_prod)
           inner join member
            on (mem_id = cart_member and
                mem_id = 'a001');
        
                
-- [����]
-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��, �ŷ�ó�ּ� ��ȸ
-- 1) �ǸŰ����� 10���� �����̰�
-- 2) �ŷ�ó �ּҰ� �λ��� ��츸 ��ȸ
-- �Ϲ�, ǥ�ع�� ��� �غ���

--< �Ϲݹ�� >------------------------------------------------------
select prod_id, prod_name, 
       lprod_nm, buyer_name, 
       buyer_add1
       
from prod, lprod, buyer
where prod_lgu = lprod_gu and
      prod_buyer = buyer_id and
      prod_sale <= 100000 and
      substr(buyer_add1,1,2) = '�λ�' ; 

--< ǥ�ع�� >------------------------------------------------------
select prod_id, prod_name, 
       lprod_nm, buyer_name, 
       buyer_add1
       
from prod inner join lprod
            on(prod_lgu = lprod_gu and
               prod_sale <= 100000)
          inner join buyer
            on(prod_buyer = buyer_id and
               substr(buyer_add1,1,2) = '�λ�');
               
               
-- [����]
-- ��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó�� ��ȸ
-- ��, ��ǰ�з� �ڵ尡 P101, P201, P301�� ��
--     ���Լ����� 15�� �̻��� ��
--     ���￡ ��� �ִ� ȸ�� �� ������ 1974����� ȸ��
-- ������ ȸ�����̵� ���� ��������, ���Լ��� ���� ��������
-- �Ϲ�, ǥ�ع�� ��� �غ���
select*from member;

--< �Ϲݹ�� >------------------------------------------------------
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
      mem_add1 like '����%' and
      to_char(substr(mem_bir,1,2)) = '74';

--< ǥ�ع�� >------------------------------------------------------
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
               mem_add1 like '����%' and
               to_char(substr(mem_bir,1,2)) = '74');