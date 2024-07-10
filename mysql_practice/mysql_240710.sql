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
SELECT *
FROM orders A
LEFT JOIN customers B
ON A.customerNumber = B.customernumber
LEFT JOIN orderdetails C
ON A.orderNumber = C.orderNumber
;