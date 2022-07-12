-- cart 테이블 주문번호 생성
-- 오늘 날짜를 기준으로 주문번호가 있으면 +1
-- 없으면 오늘 날짜의 신규 주문번호 2022071100001번 생성

select*from cart;

select max(cart_no), sysdate
from cart;

select decode(substr(max(cart_no),1,8), 
              to_char(sysdate,'yyyymmdd'), max(cart_no)+1, 
              to_char(sysdate,'yyyymmdd') || '00001') as max_no
from cart;
