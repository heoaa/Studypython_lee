-- like

-- ������ �����ϴ� ��� ��ǰ�� ��ȸ
select prod_id, prod_name
from prod
where prod_name like '��%';

-- �ι�° ���ڰ� ���� ��� ��ǰ�� ��ȸ
select prod_id, prod_name
from prod
where prod_name like '_��%';

-- ġ�� ������ ��� ��ǰ�� ��ȸ
select prod_id, prod_name
from prod
where prod_name like '%ġ';

--------------------------------------------------------------------------------

-- escape '������' 
select lprod_gu, lprod_nm
from lprod
where lprod_nm like '%ȫ\%' escape '\';

--------------------------------------------------------------------------------

-- �Լ�-���ڿ� (oracle ���� �Լ�)
-- x || x ---------------------------------------------------------------
select 'a' || 'bcde' from dual ; 

select mem_id || 'name is ' || mem_name 
from member;

-- concat ---------------------------------------------------------------
select concat('My name is ', mem_name)
from member;

-- trim ---------------------------------------------------------------
select '<' || trim('   A AA   ') || '>' as trim1,
       -- a�� �����ϴ� ���� ��� �����
       '<' || trim(LEADING 'a' from 'aaAaBaAaa') || '>' as trim2,
       '<' || trim('a' from 'aaAaBaAaa') || '>' trim3
from dual;

-- substr(���ڿ�, ��ġ, ����) -----------------------------------------
select mem_id, substr(mem_name, 1, 1) as ����
from member;

select mem_id, substr(mem_name, 2, 2) as �̸�
from member;

-- [����]
-- ��ǰ���̺� ��ǰ���� 4°�ڸ����� 2���ڰ� 'Į��'�� ��ǰ�� 
-- ��ǰ�ڵ�, ��ǰ�� ��ȸ
select prod_id, 
       substr(prod_name, 4, 2) as subnm
from prod
where substr(prod_name, 4, 2) = 'Į��';

select prod_id, prod_name
from prod
where prod_name like '___Į��%' ;

-- replace ---------------------------------------------------------------
select buyer_name,
       replace(buyer_name, '��', '��') as "�� -> ��"
from buyer;

-- [����]
-- ȸ�����̺��� ȸ������ �� '��'�� ���� '��'�� ������ ġȯ �˻�
select replace(substr(mem_name, 1, 1), '��', '��') || substr(mem_name, 2, 3)
from member;

-- ��ǰ�з��� �߿� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ
-- ȸ�����̵�, ȸ���̸� ��ȸ
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ��
-- �׸���, ȸ���� ��̰� ������ ȸ��
select mem_id, mem_name
from member
where mem_like = '����' and
      mem_id in (
        select cart_member 
        from cart
        where cart_prod in (
            select prod_id 
            from prod
            where prod_name like '%�Ｚ����%' and
                  prod_lgu in (
                    select lprod_gu from lprod
                    where lprod_nm like '%����&')));
                                                         

-- round : �ݿø�, trunc : ���� -----------------------------------------
select mem_mileage,
       round(mem_mileage/12, 2),
       trunc(mem_mileage/12, 2)
from member;

-- mod : ���� ������ ----------------------------------------------------
select mod(10,3) from dual;

-- ���� ����
select mod(substr(mem_regno2,1,1),2) as sex
from member;

-- sysdate ---------------------------------------------------------------
select sysdate "����ð�",
       sysdate - 1 "���� �̽ð�",
       sysdate + 1 "���� �̽ð�"
from dual;

-- ȸ�����̺��� ���ϰ� 12000��° �Ǵ³� �˻�
select mem_name, mem_bir, mem_bir+12000
from member;

-- add_months ---------------------------------------------------------------
select add_months(sysdate, 5) from dual;

-- next_day : ������ �������� ���� ���� ���� ã��
-- last_day : �ش� ���� ���� ������ ���� ã��
select next_day(sysdate, '������'),
       last_day(sysdate)
from dual;

-- �̹����� ��ĥ�� ���Ҵ��� �˻�
select last_day(sysdate)-sysdate
from dual;

select round(sysdate, 'yyyy'),
       round(sysdate, 'q')
from dual;

-- extract : ��,��,�� ���� -----------------------------------------------
select extract(YEAR from sysdate) "�⵵",
       extract(MONTH from sysdate) "��",
       extract(day from sysdate) "��"
from dual;

-- ������ 3���� ȸ�� �˻�
select *
from member
where extract(month from mem_bir) = 3;

-- cast : ����ȯ -------------------------------------------------------------
select '[' || cast('Hello' as char(30)) || ']' as ����ȯ
from dual;

select '[' || cast('Hello' as varchar(30)) || ']' as ����ȯ
from dual;

-- 0000-00-00, 0000/00/00, 0000.00.00, 00000000,
--   00-00-00,   00/00/00,  00.00.00
select cast('1997/12/25' as date) from dual;

-- to_char ---------------------------------------------------------------
select to_char(sysdate, 'AD YYYY, CC"����"')
from dual;

select to_char(cast('2008-12-25' as date), 'yyyy.mm.dd hh24:mi')
from dual;

-- ��ǰ���̺��� ��ǰ�԰����� '2008-09-28' �������� ������ �˻�
select to_char(buy_date, 'yyyy-mm-dd')
from buyprod;


-- ȸ���̸��� ���Ϸ� ����ó�� ��µǰ� �ۼ��Ͻÿ�
-- ��������� 1976�� 1�� ����̰� �¾ ������ ����� ...
select mem_name || '���� ' || to_char(mem_bir, 'yyyy"��" mm"��"') || 
      ' ����̰� �¾ ������ ' || to_char(mem_bir, 'day')
from member;


select to_char(1234.6, '99,999.00'),
       to_char(1234.6, '9999.99'),
       to_char(1234.6, '999,999,999.99')
from dual;

-- to_char���� ��ȭ ǥ�� 
select to_char(1234.6, 'L99,999.00PR'),
       to_char(-1234.6, 'L99,999.99PR')
from dual;


-- ������ ȸ���� ������ ��ǰ ��
-- ��ǰ�з��� ���ڰ� ���ԵǾ� �ְ�,
-- �ŷ�ó�� ������ ������
-- ��ǰ�ڵ�, ��ǰ�� ��ȸ
select prod_id, prod_name
from prod
where prod_id in (select cart_prod from cart
                  where cart_member in (select mem_id from member 
                                         where mod(substr(mem_regno2,1,1),2) = 0)) and
      prod_lgu in (select lprod_gu from lprod where lprod_nm like '%����%') and
      prod_buyer in (select buyer_id from buyer where substr(buyer_add1,1,2) = '����');



-- avg ---------------------------------------------------------------
select round(avg(distinct prod_cost), 2), round(avg(all prod_cost), 2),
       round(avg(prod_cost), 2) ���԰����
from prod;

-- count 
select count(distinct prod_cost), count(all prod_cost),
       count(prod_cost), count(*)
from prod;

select count(distinct mem_mileage), count(all mem_mileage),
       count(mem_mileage), count(*)
from member;


-- �׷�(����)�Լ��� ����ϴ� ����
-- group by�� ������� �ʾƵ� ��
-- ��ü �࿡ ���� �Ϲ�����
-- sum(), avg(), min(), max(), count()
select count(mem_job), count(*)
from member;

-- @@�� ���� �� �Ϲ��÷� �����Ϳ� group by�� �ʿ�
-- ��ȸ�� �Ϲ��ø��� ���Ǵ� ��쿣 group by�� tkdyd
-- group by������ ��ȸ�� ���� �Ϲ��÷��� ������ �־��ݴϴ�.
-- �Լ��� ����� ��쿡�� �Լ��� ����� ���� �״�θ� �־��ݴϴ�.
-- order by���� ����ϴ� �Ϲ��÷� �Ǵ� �Լ��� �̿��� �÷���
-- ������ group by���� �־��ݴϴ�.

-- ȸ�����̺��� ������ count �����Ͻÿ� 
select mem_job, count(mem_job) as cnt1, count(*) as cnt2
from member
where mem_mileage > 10 and
      mem_mileage >= 10
group by mem_job
order by cnt1 desc;



-- ��ٱ��� ���̺��� ȸ���� count ����
select cart_member, cart_prod,
       count(cart_member), count(*)
from cart
group by cart_member, cart_prod;


-- ������ ��̷��ϴ� ȸ����
-- �ַ� �����ϴ� ��ǰ�� ���� ������ ��ȸ�Ϸ��� �մϴ�.
-- ��ǰ���� count�����մϴ�.
-- ��ȸ�÷�, ��ǰ��, ��ǰcount
-- ������ ��ǰ�ڵ� �������� ��������


select prod_name, 
       count(prod_name)
from prod
where prod_id in (
    select cart_prod from cart 
    where cart_member in (
        select mem_id from member
        where mem_like = '����'))
group by prod_name, prod_id
order by prod_id desc;