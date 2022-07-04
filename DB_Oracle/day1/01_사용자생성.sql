-- 오라클12버전 이상부터는 아래를 실행해야 일반적인 구문 작성이 가능
Alter session set "_ORACLE_SCRIPT"=true;

-- 위에 실행은 최초 한번 실행
-- 위 미실행 시 아래처럼 구문 작성 필요
Create User c##busan_06 IDENTIFIED by dbdb ;


-- 1. 사용자 생성하기
CREATE User busan_06 IDENTIFIED by dbdb ;

-- 1-1. 패스워드 수정(계정을 아는 경우)
-- system 접속
-- Alter User busan_06 IDENTIFIED by 수정패스워드 ;

-- 1-2. 사용자 삭제
-- Drop User busan_06 ; 

-- 2. 권한 부여
GRANT Connect, Resource, DBA to busan_06 ; 

-- 2-1. 권환 회수
-- Revoke DBA From busan_06 ; 

-- 3. 접속 새로 만들기
-- busan_06이름으로 초록+ 누르고 새로 생성
-- 접속 아이디 busan_06, 패스워드 dbdb





