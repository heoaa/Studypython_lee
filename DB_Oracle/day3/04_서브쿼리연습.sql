-- [��ȸ ��� ����]

-- 1. ���̺� ã��
--   ���õ� �÷����� �Ҽ� ã��

-- 2. ���̺� ���� ���� ã��
--   ERD���� ����� ������� PK�� FK �÷� �Ǵ�,
--   ������ ���� ������ ������ �� �ִ� �÷� ã��

-- 3. �ۼ� ���� ���ϱ�
--   ��ȸ�ϴ� �÷��� ���� ���̺��� ���� �� (1����)
--   1���� ���̺���� ERD ������� �ۼ�
--   ������ �ش� �÷���  ���� ���̺��� ���� ó��


-- ��ǰ�з� �߿� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸� ��ȸ
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ��
-- �׸���, ȸ���� ��̰� ������ ȸ��

-- 1. ���̺� ã��
--  lprod, cart, member, prod

-- 2. ���̺� ���� ���� ã��
--  member - cart - prod - lprod
--  lprod_gu = prod_lgu
--  prod_id = cart_prod
--  cart_member = mem_id

-- 3. �ۼ� ���� ��ȸ
--  ��ȸ�ϴ� �÷� ���� �ۼ�
--  member > cart > prod > lprod

select mem_id, mem_name from member 
 where mem_like = '����' and
      mem_id in (
        select cart_member from cart 
         where cart_prod in (
            select prod_id from prod
             where prod_name like '%�Ｚ����%' and
                   prod_lgu in (
                    select lprod_gu from lprod
                     where lprod_nm like '%����%'))); 
                     
                     
-- [����]
-- ������ ȸ���� ������ ��ǰ�� ���� �ŷ�ó ���� Ȯ��
-- �ŷ�ó�ڵ�, �ŷ�ó��, ����, �ŷ�ó ��ȭ��ȣ ��ȸ
-- ��, ��ǰ�з��� �߿� ĳ�־� �ܾ ���Ե� ��ǰ�� ���ؼ���

select buyer_id, buyer_name,
       substr(buyer_add1,1,2), buyer_comtel
from buyer
where buyer_lgu in (
    select lprod_gu from lprod
     where lprod_nm like '%ĳ�־�%' and
           lprod_gu in (
        select prod_lgu from prod
         where prod_id in (
            select cart_prod from cart
             where cart_member in (
                select mem_id from member
                 where mem_name = '������'))));
                 
                 
-- lprod - buyer ����x

select buyer_id, buyer_name,
       substr(buyer_add1,1,2) as add1, 
       buyer_comtel
from buyer
where buyer_id in (
    select prod_buyer from prod
     where prod_lgu in (
            select lprod_gu from lprod
             where lprod_nm like '%ĳ�־�%') and
           prod_id in (
            select cart_prod from cart
             where cart_member in (
                select mem_id from member
                 where mem_name = '������')));
                 
                 
-- [����]
-- ������ ȸ���� ������ ��ǰ �߿�
--��ǰ�з��� ���ڰ� ���ԵǾ� �ְ�,
-- �ŷ�ó�� ������ ������
-- ��ǰ�ڵ�, ��ǰ�� ��ȸ

select prod_id, prod_name
from prod
where prod_buyer in (
        select buyer_id from buyer
         where substr(buyer_add1,1,2) = '����') and
      prod_lgu in (
        select lprod_gu from lprod
         where lprod_nm like '%����%') and
      prod_id in (
        select cart_prod from cart
         where cart_member in (
            select mem_id from member
             where mod(substr(mem_regno2,1,1),2) = 0));
             
