
-- [����]
-- �������� ���� �达�̰� 
-- �ŷ�ó �ּ��� ������ �̸��� ������ �����ϸ� 
--   (�����ڷ� �и��Ͽ� ��ȸ�Ͻÿ�, �ܵ� substr ��� �Ұ�)
-- �ŷ�ó �ѽ���ȣ ��� 3�ڸ��� �߿� 3�� ���� 
--   (�����ڷ� �и��Ͽ� ��ȸ�Ͻÿ�, �ܵ� substr ��� �Ұ�)
-- ���������� ����ϴ� �ŷ�ó ��ǰ�� �ű� ������� 1���̸�(to_char ��� �Ұ�)
-- �� �� ��ǰ�������� ��, ����, ����, �ܿ��� �ִ� ��ǰ�� ����, (�Һ��ڰ�-�ǸŰ�),
-- ���Լ���, ���Դܰ� ��ȸ
-- ������ (�Һ��ڰ�-�ǸŰ�), ���Լ��� �������� ��������


select prod_outline, prod_color, 
      (prod_price-prod_sale) as ps,
      buy_cost, buy_qty
       
from buyer, prod, buyprod

where buyer_id = prod_buyer and
      prod_id = buy_prod and
      
      buyer_bankname like '��%' and
      
      SUBSTR(buyer_add1, INSTR(buyer_add1, ' ', 1, 1) + 1, 
      INSTR(buyer_add1, ' ', 1, 2) - INSTR(buyer_add1, ' ', 1, 1) - 1) like '��%' and
      
      SUBSTR(buyer_fax, INSTR(buyer_fax, '-', 1, 1) + 1, 
      INSTR(buyer_fax, '-', 1, 2) - INSTR(buyer_fax, '-', 1, 1) - 1) like '%3%' and
      
      buyer_bank = '��������' and
      
      extract(MONTH from prod_insdate) = 1 and
      
      (prod_outline LIKE '%��%' OR prod_outline LIKE '%����%' OR prod_outline LIKE '%����%' OR prod_outline LIKE '%�ܿ�%') 

order by ps, buy_qty desc;

---------------------------------------\

SELECT prod_color, prod_price - prod_sale AS margin, buy_qty, buy_cost
  FROM prod, buyer, buyprod
 WHERE prod_buyer = buyer_id
   AND prod_id = buy_prod
   AND (prod_outline LIKE '%��%' OR prod_outline LIKE '%����%' OR prod_outline LIKE '%����%' OR prod_outline LIKE '%�ܿ�%')
   AND buyer_bank = '��������'
   AND EXTRACT(MONTH FROM prod_insdate) = 1
   AND buyer_bankname LIKE '��%'
   AND SUBSTR(buyer_add1, INSTR(buyer_add1, ' ')+1) LIKE '��%'
   AND SUBSTR(buyer_fax, INSTR(buyer_fax, '-')+1, 3) LIKE '%3%'
 ORDER BY margin DESC, buy_qty DESC;
 
 