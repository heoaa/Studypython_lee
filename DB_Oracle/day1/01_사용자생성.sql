-- ����Ŭ12���� �̻���ʹ� �Ʒ��� �����ؾ� �Ϲ����� ���� �ۼ��� ����
Alter session set "_ORACLE_SCRIPT"=true;

-- ���� ������ ���� �ѹ� ����
-- �� �̽��� �� �Ʒ�ó�� ���� �ۼ� �ʿ�
Create User c##busan_06 IDENTIFIED by dbdb ;


-- 1. ����� �����ϱ�
CREATE User busan_06 IDENTIFIED by dbdb ;

-- 1-1. �н����� ����(������ �ƴ� ���)
-- system ����
-- Alter User busan_06 IDENTIFIED by �����н����� ;

-- 1-2. ����� ����
-- Drop User busan_06 ; 

-- 2. ���� �ο�
GRANT Connect, Resource, DBA to busan_06 ; 

-- 2-1. ��ȯ ȸ��
-- Revoke DBA From busan_06 ; 

-- 3. ���� ���� �����
-- busan_06�̸����� �ʷ�+ ������ ���� ����
-- ���� ���̵� busan_06, �н����� dbdb





