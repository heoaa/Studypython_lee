-- <<1번문제>>
-- 제품이름이 남성과 여성으로 시작하는 제품의 각각의 소매점 대기시간 평균을 집계하세요
-- 소매점대기시간은 주문일 - 매입일
-- 소매점 대기시간이 0 이하인 값들은 제외
-- 대기시간 평균을 소수점 둘째자리까지만 나타내어주세요
-- alias명을 성별제품, 소매점대기시간으로 나타내어주세요

select substr(prod_name,1,2) as 성별제품, 
       round(avg(cast(substr(cart_no,1,8) as date) - buy_date),2) as 소매점대기시간
from prod, buyprod, cart
where prod_id = cart_prod and
      prod_id = buy_prod and
      (prod_name like '남성%' or prod_name like '여성%') and
      round((cast(substr(cart_no,1,8) as date) - buy_date),2) > 0
group by substr(prod_name,1,2);


