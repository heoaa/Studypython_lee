-- [����] 
-- ��̰� ������ ȸ���� �߿� 
-- ���ϸ��� ���� 1000 �̻��� 
-- ȸ�����̵�, ȸ���̸�, ȸ�����, ȸ�����ϸ��� ��ȸ
-- ������ ȸ���̸� ���� ��������
select mem_id, mem_name, mem_like, mem_mileage
from member
where mem_like = '����' and mem_mileage >= 1000
order by mem_name;

--------------------------------------------------------------------------------
-- ��������(SubQuery) ����
-- (���1) select ��ȸ �÷� ��� ����ϴ� ���
--  : �����÷��� �����ุ ��ȸ ����

-- (���2) wherer ���� ����ϴ� ���
--  In () : �����÷��� ������ �Ǵ� ������ ��ȸ ����
--    =   : �����÷��� �����ุ ��ȸ ����
--------------------------------------------------------------------------------

-- (��������)
-- ������ ȸ���� ������ ��̸� ������
-- ȸ�����̵�, ȸ���̸�, ȸ����� ��ȸ
select mem_id, mem_name, mem_like
from member
where mem_like = (select mem_like
                    from member
                   where mem_name = '������') ;
                    

-- (��������)
-- �ֹ������� �ִ� ȸ���� ���� ������ ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸�, �ֹ���ȣ, �ֹ����� ��ȸ
-- �÷���� select���̹Ƿ� �ϳ��� ���� ��ȸ�ǰ� �������ָ� ��� ����
select cart_member, cart_no, cart_qty,
       (select mem_name
          from member
         where mem_id = cart_member) as name
from cart ;


-- (��������)
-- �ֹ������� �ִ� ȸ���� ���� ������ ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸�, �ֹ���ȣ, �ֹ�����, ��ǰ�� ��ȸ
select cart_member, cart_no, cart_qty,
       (select mem_name
          from member
         where mem_id = cart_member) as name,
       (select prod_name
          from prod
         where cart_prod = prod_id) as p_name
from cart ;


-- 
-- a001 ȸ���� �ֹ��� ��ǰ�� ����
-- ��ǰ�з��ڵ�, ��ǰ�з��� ��ȸ
select lprod_gu, lprod_nm
from lprod
where lprod_gu in (select prod_lgu
                     from prod
                    where prod_id in (select cart_prod
                                        from cart
                                       where cart_member = 'a001'));
                                       
                                       
-- �̻��̶�� ȸ���� �ֹ��� ��ǰ �߿�
-- ��ǰ�з��ڵ尡 P201�̰�, 
-- �ŷ�ó�ڵ尡 P20101��
-- ��ǰ�ڵ�, ��ǰ�� ��ȸ
select prod_id, prod_name
from prod
where prod_lgu = 'P201' and
      prod_buyer = 'P20101' and
      prod_id in (select cart_prod
                    from cart
                   where cart_member in (select mem_id
                                           from member
                                          where mem_name = '�̻���'));


