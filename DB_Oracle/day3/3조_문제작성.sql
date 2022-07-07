
-- [문제]
-- 예금주의 성이 김씨이고 
-- 거래처 주소의 행정구 이름이 강으로 시작하며 
--   (구분자로 분리하여 조회하시오, 단독 substr 사용 불가)
-- 거래처 팩스번호 가운데 3자리수 중에 3이 들어가고 
--   (구분자로 분리하여 조회하시오, 단독 substr 사용 불가)
-- 제일은행을 사용하는 거래처 상품의 신규 등록일이 1월이며(to_char 사용 불가)
-- 그 중 상품개략설명에 봄, 여름, 가을, 겨울이 있는 상품의 색상, (소비자가-판매가),
-- 매입수량, 매입단가 조회
-- 정렬은 (소비자가-판매가), 매입수량 기준으로 내림차순


select prod_outline, prod_color, 
      (prod_price-prod_sale) as ps,
      buy_cost, buy_qty
       
from buyer, prod, buyprod

where buyer_id = prod_buyer and
      prod_id = buy_prod and
      
      buyer_bankname like '김%' and
      
      SUBSTR(buyer_add1, INSTR(buyer_add1, ' ', 1, 1) + 1, 
      INSTR(buyer_add1, ' ', 1, 2) - INSTR(buyer_add1, ' ', 1, 1) - 1) like '강%' and
      
      SUBSTR(buyer_fax, INSTR(buyer_fax, '-', 1, 1) + 1, 
      INSTR(buyer_fax, '-', 1, 2) - INSTR(buyer_fax, '-', 1, 1) - 1) like '%3%' and
      
      buyer_bank = '제일은행' and
      
      extract(MONTH from prod_insdate) = 1 and
      
      (prod_outline LIKE '%봄%' OR prod_outline LIKE '%여름%' OR prod_outline LIKE '%가을%' OR prod_outline LIKE '%겨울%') 

order by ps, buy_qty desc;

---------------------------------------\

SELECT prod_color, prod_price - prod_sale AS margin, buy_qty, buy_cost
  FROM prod, buyer, buyprod
 WHERE prod_buyer = buyer_id
   AND prod_id = buy_prod
   AND (prod_outline LIKE '%봄%' OR prod_outline LIKE '%여름%' OR prod_outline LIKE '%가을%' OR prod_outline LIKE '%겨울%')
   AND buyer_bank = '제일은행'
   AND EXTRACT(MONTH FROM prod_insdate) = 1
   AND buyer_bankname LIKE '김%'
   AND SUBSTR(buyer_add1, INSTR(buyer_add1, ' ')+1) LIKE '강%'
   AND SUBSTR(buyer_fax, INSTR(buyer_fax, '-')+1, 3) LIKE '%3%'
 ORDER BY margin DESC, buy_qty DESC;
 
 