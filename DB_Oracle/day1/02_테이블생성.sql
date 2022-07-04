-- ** DB ������Ÿ��
-- varchar2 : �������� ���ڿ�����(ȿ����)
-- char : �������� ���ڿ�����(ex. �ֹε�Ϲ�ȣ, �޴�����ȣ �� ������ ���̿� ���)
-- --nchar, nvarchar2 : �ѱ��� ���� ����ϴ� ��� n ���
-- number
-- date : ��¥ ��������

-- ** Ű key
-- Primary Key : ������ ��
-- ����Ű(Foreign key) : 


-- 1. ��ǰ�з��������̺� ����
CREATE TABLE lprod(
   lprod_id number(5) NOT NULL,                 -- ��ǰ�з���ȣ
   lprod_gu char(4) NOT NULL,                   -- ��ǰ�з��ڵ�
   lprod_nm varchar2(40) NOT NULL,              -- ��ǰ�з��̸�
   Constraint pk_lprod Primary key (lprod_gu)   -- ���������߰�
);


SELECT * From lprod;


insert into lprod (lprod_id, lprod_gu,lprod_nm)
    values(1, 'P101', '��ǻ����ǰ') ;
insert into lprod (lprod_id, lprod_gu,lprod_nm)
    values(2, 'P102', '��ǻ����ǰ') ;    

    
SELECT lprod_gu, lprod_nm From lprod;

commit;
rollback;

-- ���̽����̺�� ���̺� ����


-- 2. �ڷ� ��ȸ
-- 2-1. ȸ������ ���̺�
SELECT * From member;

-- 2-2. �ֹ��������� ���̺�
SELECT * From cart;

-- 2-3. ��ǰ���� ���̺�
SELECT * From prod;

-- 2-4. ��ǰ�з����� ���̺�
SELECT * From lprod;

-- 2-5. �ŷ�ó���� ���̺�
SELECT * From buyer;

-- 2-6. �԰��ǰ���� ���̺�
SELECT * From buyprod;



-- [����]
-- 1) ȸ�����̺��� ȸ�����̵�, ȸ���̸� ��ȸ
select mem_id, mem_name from member;

-- 2) ��ǰ�ڵ�� ��ǰ�� ��ȸ
select prod_id, prod_name from prod;

-- 3) ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ� ��ȸ
-- ��, �Ǹűݾ� = �ǸŰ� * 55 �� ����ؼ� ��ȸ
-- �Ǹűݾ��� 4�鸸 �̻��� �����͸� ��ȸ
-- ������ �Ǹűݾ��� �������� ��������
-- select > from ���̺� > where > �÷���ȸ > order by ��
-- ��Ī�� �÷���ȸ ���� ��� ����(order by������ ��밡��)
select prod_id, prod_name,
      (prod_sale*55) as prod_sale
from prod
WHERE (prod_sale*55) >= 4000000
order by prod_sale desc;

-- 4) ��ǰ�������� �ŷ�ó�ڵ� ��ȸ
-- �� �ߺ��� �����ϰ� ��ȸ
select distinct prod_buyer 
from prod ; 

-- 4-1) ��ǰ�߿� �ǸŰ����� 17������ ��ǰ ��ȸ
select prod_name, prod_sale 
from prod
where prod_sale = 170000;

-- 4-2) ��ǰ�߿� �ǸŰ����� 17������ �ƴ� ��ǰ ��ȸ
select prod_name, prod_sale 
from prod
where prod_sale != 170000;

-- 4-3) ��ǰ�߿� �ǸŰ����� 17���� �̻��̰� 20���� ������ ��ǰ ��ȸ
select prod_name, prod_sale 
from prod
where prod_sale >= 170000 and prod_sale <= 200000;

-- 4-4) ��ǰ�߿� �ǸŰ����� 17���� �̻� �Ǵ� 20���� ������ ��ǰ ��ȸ
select prod_name, prod_sale 
from prod
where prod_sale >= 170000 or prod_sale <= 200000;


-- 5) ��ǰ �ǸŰ����� 10���� �̻��̰�, 
-- ��ǰ�ŷ�ó(���޾�ü) �ڵ尡 P30203 �Ǵ� P10201��
-- ��ǰ�ڵ�, �ǸŰ���, ���޾�ü �ڵ� ��ȸ
select prod_id, prod_sale, prod_buyer
from prod
where prod_sale >= 100000 and (prod_buyer='P30203' or prod_buyer='P10201');

-- ���� ����
select prod_id, prod_sale, prod_buyer
from prod
where prod_sale >= 100000 and prod_buyer in ('P30203', 'P10201');
--
select prod_id, prod_sale, prod_buyer
from prod
where prod_sale >= 100000 and prod_buyer not in ('P30203', 'P10201');


select distinct prod_buyer
from prod
order by prod_buyer asc;

SELECT * 
FROM buyer
where buyer_id in ( select distinct prod_buyer
                    from prod);
    
-- 6) �ѹ��� �ֹ��� ���� ���� ȸ�����̵�, �̸��� ��ȸ
SELECT mem_id, mem_name
from member
where mem_id not in (select distinct cart_member from cart);

-- 7) ��ǰ�з� �߿� ��ǰ������ ���� �з��ڵ常 ��ȸ
select lprod_gu
from lprod
where lprod_gu not in (select distinct prod_lgu from prod);

-- 8) ȸ���� ���� �߿� 75����� �ƴ� ȸ�����̵�, ���� ��ȸ
-- ���� �������� ��������
select mem_id, mem_bir 
from member
where mem_bir not like '75/%/%'
order by mem_bir desc ; 

-- 
select mem_id, mem_bir 
from member
where mem_bir not between '1975-01-01' and '1975-12-31'
order by mem_bir desc ;

-- 9) ȸ�� ���̵� a001�� ȸ���� �ֹ��� ��ǰ�ڵ� ��ȸ
-- ��ȸ�÷��� ȸ�����̵�, ��ǰ�ڵ�
select cart_prod, cart_member 
from cart
where cart_member = 'a001';