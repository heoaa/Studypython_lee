-- <<1������>>
-- ��ǰ�̸��� ������ �������� �����ϴ� ��ǰ�� ������ �Ҹ��� ���ð� ����� �����ϼ���
-- �Ҹ������ð��� �ֹ��� - ������
-- �Ҹ��� ���ð��� 0 ������ ������ ����
-- ���ð� ����� �Ҽ��� ��°�ڸ������� ��Ÿ�����ּ���
-- alias���� ������ǰ, �Ҹ������ð����� ��Ÿ�����ּ���

select substr(prod_name,1,2) as ������ǰ, 
       round(avg(cast(substr(cart_no,1,8) as date) - buy_date),2) as �Ҹ������ð�
from prod, buyprod, cart
where prod_id = cart_prod and
      prod_id = buy_prod and
      (prod_name like '����%' or prod_name like '����%') and
      round((cast(substr(cart_no,1,8) as date) - buy_date),2) > 0
group by substr(prod_name,1,2);


