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


