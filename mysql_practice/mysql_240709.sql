USE classicmodels; -- 해당 Database를 사용하겠음
SHOW databases;


SELECT * FROM customers; -- Ctrl + Enter
SELECT * FROM classicmodels.customers; -- 이렇게 매번 하기 귀찮음
USE classicmodels; -- 사용
SHOW tables;

-- 현재 사용 중인 스키마를 확인
SELECT DATABASE();
SELECT * FROM customers; -- 간결하게

DESC customers;

-- SELECT : 필드를 선택하다
SELECT * FROM customers; -- customer에서 전체 필드를 출력하기

SELECT customerNumber, customerName, contactFirstName FROM customers;
SELECT 
	customerNumber
    , customerName
    , contactFirstName
FROM
	customers
;

-- customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit 전체 필드

SELECT *
FROM
	customers
WHERE country = 'USA'
;

SELECT *
FROM
	customers
WHERE customerNumber = 112
;


-- 연산자 사용하기
-- 112 보다 크거나 같을 때
SELECT *
FROM
	customers
WHERE customerNumber >= 112
;

-- 112 보다 작을 때
SELECT *
FROM
	customers
WHERE customerNumber < 112
;


-- 112 보다 작거나 같을 때
SELECT *
FROM
	customers
WHERE customerNumber <= 112
;


-- 112 보다 클 때
SELECT *
FROM
	customers
WHERE customerNumber > 112
;


-- 112와 같지 않음
SELECT *
FROM
	customers
WHERE customerNumber != 112
;


SELECT *
FROM
	customers
WHERE customerNumber <> 112
;


-- 문자열과 무등호 연산자
SELECT *
FROM
	customers
WHERE 
	state <= 'C'
;


SELECT *
FROM
	customers
WHERE 
	state != 'MA'
;

-- WHERE LIKE 연산자
-- customer 데이터 테이블에서 customerName이 gifts인 것만 모두 출력하기
-- %gifts : 뒤에서 시작하는게 gifts인 경우만
-- gifts% : 앞에서 시작하는게 gifts인 경우만
-- %gifts% : gifts가 포함된 경우만
SELECT * 
FROM 
	customers
WHERE customerName LIKE '%Gifts%'
;



-- 문자열을 검색할 때 가장 유용한 것 : 정규표현식을 활용한 검색
-- 매우 어렵지만, 무조건 필요함!!!

SELECT * 
FROM 
	customers 
WHERE customerName REGEXP '^La'
;


-- AND
-- country가 USA 이면서 city NYC인 고객을 조회하기
-- 필드는 전체 조회
SELECT *
FROM 
	customers
WHERE country = 'USA' AND city = 'NYC'
;


-- OR 조건문
SELECT *
FROM 
	customers
WHERE country = 'USA' OR contactLastName = 'Lee'
;


-- 테이블 Payments

SELECT * FROM payments;

-- BETWEEN 연산자
SELECT *
FROM 
	payments
WHERE amount BETWEEN 10000 AND 50000
AND paymentDate BETWEEN 2003-06-05 AND 2003-12-31
;

