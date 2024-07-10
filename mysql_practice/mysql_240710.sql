-- Ch04. 자동차 매출 데이터를 이용한 리포트 작성
-- 일별 매출액 조회
-- AS : 약어 

SELECT 
	A.Orderdate
    , priceeach * quantityordered AS 매출액
FROM ORDERS A 
LEFT JOIN orderdetails B
ON A.ordernumber = B.ordernumber
;

-- GROUP BY 절을 활용해서 
-- 일별 매출액 조회
SELECT 
	A.Orderdate
    , SUM(priceeach * quantityordered) AS 매출액
FROM ORDERS A 
LEFT JOIN orderdetails B
ON A.ordernumber = B.ordernumber
GROUP BY 1
ORDER BY 1
;

-- SUBSTR : Python에서 말하는 슬라이싱 개념
-- 인덱스 번호가 1부터 시작
SELECT SUBSTR("ABCDE", 1, 2);
SELECT SUBSTR('2003-01-06', 1, 7);

-- 월별 매출액
SELECT 
	SUBSTR(A.Orderdate, 1, 7) AS 월별
    , SUM(priceeach * quantityordered) AS 매출액
FROM ORDERS A 
LEFT JOIN orderdetails B
ON A.ordernumber = B.ordernumber
GROUP BY 1
ORDER BY 1
;


-- 91p
-- 일자별, 월별, 연도별 구매자 수
SELECT 
	COUNT(ordernumber) N_ORDERS
    , COUNT(DISTINCT ordernumber) N_ORDERS_DISTINCT
FROM
	ORDERS
;


-- 출력 필드명 : 연도, 구매고객수, 매출액
-- 테이블 : orders, oderdetails
SELECT COUNT(*)
FROM orders A
LEFT JOIN orderdetails B
ON A.ordernumber = B.ordernumber
LEFT JOIN products C 
ON B.productcode = C.productcode
LEFT JOIN productlines D 
ON C.productline = D.productline
;

SELECT COUNT(*)
FROM products A
LEFT JOIN productlines B
ON A.productline = B.productline
LEFT JOIN orderdetails C 
ON A.productcode = C.productcode
LEFT JOIN orders D
ON C.ordernumber = D.ordernumber
;

-- 연도별 매출액과 구매자 수
SELECT 
	SUBSTR(A.orderdate, 1, 4) YY
    , COUNT(DISTINCT A.customernumber) 구매고객수
    , SUM(B.priceeach * B.quantityordered) AS 매출
FROM orders A
LEFT JOIN orderdetails B
ON A.ordernumber = B.ordernumber
GROUP BY 1
ORDER BY 1
;

-- 인당 구매금액 (AMV)
SELECT 
	SUBSTR(A.orderdate, 1, 4) YY
    , COUNT(DISTINCT A.customernumber) 구매고객수
    , SUM(B.priceeach * B.quantityordered) AS 매출
    , SUM(B.priceeach * B.quantityordered)/COUNT(DISTINCT A.customernumber) AS AMV
FROM orders A
LEFT JOIN orderdetails B
ON A.ordernumber = B.ordernumber
GROUP BY 1
ORDER BY 1
;
  
  
-- 건당 구매금액(ATV)
SELECT 
	SUBSTR(A.orderdate, 1, 4) YY
    , COUNT(DISTINCT A.ordernumber) 구매횟수
    , SUM(B.priceeach * B.quantityordered) AS 매출
    , SUM(B.priceeach * B.quantityordered)/COUNT(DISTINCT A.ordernumber) AS ATV
FROM orders A
LEFT JOIN orderdetails B
ON A.ordernumber = B.ordernumber
GROUP BY 1
ORDER BY 1
;
 
 
-- 국가별, 도시별 매출액을 구하기(ERD 참고)
-- 국가, 도시 
SELECT 
	B.country 국가
    , B.city 도시
    , SUM(C.priceeach * C.quantityordered) AS 매출
FROM orders A
LEFT JOIN customers B
ON A.customerNumber = B.customernumber
LEFT JOIN orderdetails C
ON A.orderNumber = C.orderNumber
GROUP BY 1, 2
ORDER BY 1, 2
;


-- CASE WHEN
-- 조건문, IF-ELSE를 대신함
-- 북미 VS 비북미
/*
SELECT 
	CASE WHEN country IN ('USA', 'Canada') THEN 'North America'
    ELSE 'Others' END country_grp
FROM customers
;
*/

SELECT
	CASE WHEN country IN ('USA', 'Canada') THEN 'North America'
    ELSE 'Others' END country_grp
    , SUM(C.priceeach * C.quantityordered) AS 매출
FROM orders A
LEFT JOIN customers B
ON A.customerNumber = B.customernumber
LEFT JOIN orderdetails C
ON A.orderNumber = C.orderNumber
GROUP BY 1
ORDER BY 1
;

USE classicmodels;
-- p.103 매출 Top5 국가 및 매출
-- row_number, rank, dense_rank

-- CREATE TABLE CLASSICMODELS.STAT AS
SELECT C.COUNTRY,
SUM(PRICEEACH*QUANTITYORDERED) SALES
FROM CLASSICMODELS.ORDERS A
LEFT
JOIN CLASSICMODELS.ORDERDETAILS B
ON A.ORDERNUMBER = B.ORDERNUMBER
LEFT
JOIN CLASSICMODELS.CUSTOMERS C
ON A.CUSTOMERNUMBER = C.CUSTOMERNUMBER
GROUP
BY 1
ORDER
BY 2 DESC
;

SELECT * FROM stat;

/* SELECT 
	country
    , sales
    , DENSE_RANK() OVER(ORDER BY SALES DESC) RNK
FROM stat
WHERE RNK BETWEEN 1 AND 5
; -- 에러가 난다. 
*/

-- QUERY 실행하는 순서
-- FROM > WHERE > GROUP BY > HAVING > SELECT > ORDER BY 

-- CREATE TABLE stat_rnk AS
SELECT 
	country
    , sales
    , DENSE_RANK() OVER(ORDER BY SALES DESC) RNK
FROM stat
;

SELECT *
FROM stat_rnk
WHERE RNK BETWEEN 1 AND 5
;

-- USA에 거주하는 직원의 이름을 출력하세요
SELECT lastName, firstName
FROM employees A
LEFT JOIN offices B
ON A.officecode = B.officecode
WHERE country = 'USA'
;

-- 서브쿼리
SELECT 
	lastName, firstName
FROM employees
WHERE officeCode IN (
	SELECT officeCode 
    FROM offices
	WHERE country = 'USA'
)
;
-- officeCode = 1, 2, 3
SELECT officeCode
FROM offices
WHERE country = 'USA'
;


-- 문제, amount가 최대값인 것을 조회하세요
-- 조회해야 할 필드명 : customerNumber, checkNumber, amount
SELECT * FROM payments;

SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount = (SELECT max(amount) FROM payments)
;


-- 테이블 : customers, orders
-- 문제 : 전체 고객 중에서 주문을 하지 않은 고객을 찾기
-- 조회해야 할 필드명 : customerName
-- 메인쿼리 : 고객명 조회 from customers
-- 서브쿼리 : 주문한 고객, from orders

SELECT customerName 
FROM customers
WHERE customerNumber NOT IN (
	SELECT DISTINCT customerNumber FROM orders
)
;


-- 인라인 뷰 : FROM 

SELECT
	ordernumber
    , COUNT(ordernumber) AS items
FROM orderdetails
GROUP BY 1
;

-- 각 주문건당 위 코드를 기반으로 최소, 최대, 평균을 구하기

SELECT 
	MIN(items)
    ,MAX(items)
    ,AVG(items)
FROM (
	SELECT
		ordernumber
		, COUNT(ordernumber) AS items
	FROM orderdetails
	GROUP BY 1
) A
;

-- stat 테이블 저장
-- stat_rnk 테이블 저장
SELECT *
FROM stat_rnk
WHERE RNK BETWEEN 1 AND 5
;


-- 위 쿼리와 결과는 동일
-- 인라인 뷰 서브쿼리가 2번 사용 됨
SELECT *
FROM
(SELECT COUNTRY,
SALES,
DENSE_RANK() OVER(ORDER BY SALES DESC) RNK
FROM
(SELECT C.COUNTRY,
SUM(PRICEEACH*QUANTITYORDERED) SALES
FROM CLASSICMODELS.ORDERS A
LEFT
JOIN CLASSICMODELS.ORDERDETAILS B
ON A.ORDERNUMBER = B.ORDERNUMBER
LEFT
JOIN CLASSICMODELS.CUSTOMERS C
ON A.CUSTOMERNUMBER = C.CUSTOMERNUMBER
GROUP
BY 1) A) A
WHERE RNK <= 5
;

