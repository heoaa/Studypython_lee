-- like

-- 삼으로 시작하는 모든 상품명 조회
select prod_id, prod_name
from prod
where prod_name like '삼%';

-- 두번째 글자가 성인 모든 상품명 조회
select prod_id, prod_name
from prod
where prod_name like '_성%';

-- 치로 끝나는 모든 상품명 조회
select prod_id, prod_name
from prod
where prod_name like '%치';

--------------------------------------------------------------------------------

-- escape '구분자' 
select lprod_gu, lprod_nm
from lprod
where lprod_nm like '%홍\%' escape '\';

--------------------------------------------------------------------------------

-- 함수-문자열 (oracle 종속 함수)
-- x || x ---------------------------------------------------------------
select 'a' || 'bcde' from dual ; 

select mem_id || 'name is ' || mem_name 
from member;

-- concat ---------------------------------------------------------------
select concat('My name is ', mem_name)
from member;

-- trim ---------------------------------------------------------------
select '<' || trim('   A AA   ') || '>' as trim1,
       -- a로 시작하는 문자 모두 지우기
       '<' || trim(LEADING 'a' from 'aaAaBaAaa') || '>' as trim2,
       '<' || trim('a' from 'aaAaBaAaa') || '>' trim3
from dual;

-- substr(문자열, 위치, 길이) -----------------------------------------
select mem_id, substr(mem_name, 1, 1) as 성씨
from member;

select mem_id, substr(mem_name, 2, 2) as 이름
from member;

-- [연습]
-- 상품테이블 상품명의 4째자리부터 2글자가 '칼라'인 상품의 
-- 상품코드, 상품명 조회
select prod_id, 
       substr(prod_name, 4, 2) as subnm
from prod
where substr(prod_name, 4, 2) = '칼라';

select prod_id, prod_name
from prod
where prod_name like '___칼라%' ;

-- replace ---------------------------------------------------------------
select buyer_name,
       replace(buyer_name, '삼', '육') as "삼 -> 육"
from buyer;

-- [연습]
-- 회원테이블의 회원성명 중 '이'씨 성을 '리'씨 성으로 치환 검색
select replace(substr(mem_name, 1, 1), '이', '리') || substr(mem_name, 2, 3)
from member;

-- 상품분류명 중에 '전자'가 포함된 상품을 구매한 회원 조회
-- 회원아이디, 회원이름 조회
-- 단, 상품명에 삼성전자가 포함된 상품을 구매한 회원
-- 그리고, 회원의 취미가 수영인 회원
select mem_id, mem_name
from member
where mem_like = '수영' and
      mem_id in (
        select cart_member 
        from cart
        where cart_prod in (
            select prod_id 
            from prod
            where prod_name like '%삼성전자%' and
                  prod_lgu in (
                    select lprod_gu from lprod
                    where lprod_nm like '%전자&')));
                                                         

-- round : 반올림, trunc : 절삭 -----------------------------------------
select mem_mileage,
       round(mem_mileage/12, 2),
       trunc(mem_mileage/12, 2)
from member;

-- mod : 나눈 나머지 ----------------------------------------------------
select mod(10,3) from dual;

-- 성별 구분
select mod(substr(mem_regno2,1,1),2) as sex
from member;

-- sysdate ---------------------------------------------------------------
select sysdate "현재시간",
       sysdate - 1 "어제 이시간",
       sysdate + 1 "내일 이시간"
from dual;

-- 회원테이블의 생일과 12000일째 되는날 검색
select mem_name, mem_bir, mem_bir+12000
from member;

-- add_months ---------------------------------------------------------------
select add_months(sysdate, 5) from dual;

-- next_day : 오늘을 기준으로 가장 빠른 요일 찾기
-- last_day : 해당 월의 가장 마지막 일자 찾기
select next_day(sysdate, '월요일'),
       last_day(sysdate)
from dual;

-- 이번달이 며칠이 남았는지 검색
select last_day(sysdate)-sysdate
from dual;

select round(sysdate, 'yyyy'),
       round(sysdate, 'q')
from dual;

-- extract : 년,월,일 추출 -----------------------------------------------
select extract(YEAR from sysdate) "년도",
       extract(MONTH from sysdate) "월",
       extract(day from sysdate) "일"
from dual;

-- 생일이 3월인 회원 검색
select *
from member
where extract(month from mem_bir) = 3;

-- cast : 형변환 -------------------------------------------------------------
select '[' || cast('Hello' as char(30)) || ']' as 형변환
from dual;

select '[' || cast('Hello' as varchar(30)) || ']' as 형변환
from dual;

-- 0000-00-00, 0000/00/00, 0000.00.00, 00000000,
--   00-00-00,   00/00/00,  00.00.00
select cast('1997/12/25' as date) from dual;

-- to_char ---------------------------------------------------------------
select to_char(sysdate, 'AD YYYY, CC"세기"')
from dual;

select to_char(cast('2008-12-25' as date), 'yyyy.mm.dd hh24:mi')
from dual;

-- 상품테이블에서 상품입고일을 '2008-09-28' 형식으로 나오게 검색
select to_char(buy_date, 'yyyy-mm-dd')
from buyprod;


-- 회원이름과 생일로 다음처럼 출력되게 작성하시오
-- 김은대님은 1976년 1월 출생이고 태어난 요일은 목요일 ...
select mem_name || '님은 ' || to_char(mem_bir, 'yyyy"년" mm"월"') || 
      ' 출생이고 태어난 요일은 ' || to_char(mem_bir, 'day')
from member;


select to_char(1234.6, '99,999.00'),
       to_char(1234.6, '9999.99'),
       to_char(1234.6, '999,999,999.99')
from dual;

-- to_char에서 원화 표시 
select to_char(1234.6, 'L99,999.00PR'),
       to_char(-1234.6, 'L99,999.99PR')
from dual;


-- 여자인 회원이 구매한 상품 중
-- 상품분류에 전자가 포함되어 있고,
-- 거래처의 지역이 서울인
-- 상품코드, 상품명 조회
select prod_id, prod_name
from prod
where prod_id in (select cart_prod from cart
                  where cart_member in (select mem_id from member 
                                         where mod(substr(mem_regno2,1,1),2) = 0)) and
      prod_lgu in (select lprod_gu from lprod where lprod_nm like '%전자%') and
      prod_buyer in (select buyer_id from buyer where substr(buyer_add1,1,2) = '서울');



-- avg ---------------------------------------------------------------
select round(avg(distinct prod_cost), 2), round(avg(all prod_cost), 2),
       round(avg(prod_cost), 2) 매입가평균
from prod;

-- count 
select count(distinct prod_cost), count(all prod_cost),
       count(prod_cost), count(*)
from prod;

select count(distinct mem_mileage), count(all mem_mileage),
       count(mem_mileage), count(*)
from member;


-- 그룹(집계)함수만 사용하는 경우는
-- group by절 사용하지 않아도 됨
-- 전체 행에 대한 일반집계
-- sum(), avg(), min(), max(), count()
select count(mem_job), count(*)
from member;

-- @@별 집계 시 일반컬럼 데이터와 group by절 필요
-- 조회할 일반컬림이 사용되는 경우엔 group by절 tkdyd
-- group by절에는 조회에 사용된 일반컬럼은 무조건 넣어줍니다.
-- 함수를 사용한 경우에는 함수를 사용한 원형 그대로를 넣어줍니다.
-- order by절에 사용하는 일반컬럼 또는 함수를 이용한 컬럼은
-- 무조건 group by절에 넣어줍니다.

-- 회원테이블의 직업별 count 집계하시오 
select mem_job, count(mem_job) as cnt1, count(*) as cnt2
from member
where mem_mileage > 10 and
      mem_mileage >= 10
group by mem_job
order by cnt1 desc;



-- 장바구니 테이블의 회원별 count 집계
select cart_member, cart_prod,
       count(cart_member), count(*)
from cart
group by cart_member, cart_prod;


-- 수영을 취미로하는 회원이
-- 주로 구매하는 상품에 대한 정보를 조회하려고 합니다.
-- 상품명별로 count집계합니다.
-- 조회컬럼, 상품명, 상품count
-- 정렬은 상품코드 기준으로 내림차순


select prod_name, 
       count(prod_name)
from prod
where prod_id in (
    select cart_prod from cart 
    where cart_member in (
        select mem_id from member
        where mem_like = '수영'))
group by prod_name, prod_id
order by prod_id desc;