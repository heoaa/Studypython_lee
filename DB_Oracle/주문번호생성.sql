-- cart ���̺� �ֹ���ȣ ����
-- ���� ��¥�� �������� �ֹ���ȣ�� ������ +1
-- ������ ���� ��¥�� �ű� �ֹ���ȣ 2022071100001�� ����

select*from cart;

select max(cart_no), sysdate
from cart;

select decode(substr(max(cart_no),1,8), 
              to_char(sysdate,'yyyymmdd'), max(cart_no)+1, 
              to_char(sysdate,'yyyymmdd') || '00001') as max_no
from cart;
