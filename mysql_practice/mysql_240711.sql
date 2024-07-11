-- Churn Rate(%) : 이탈률 구하기
-- 웹사이트 : 사이트에 오늘 방문 ------> 90일 정도 후 방문 후 --
-- 우리 웹사이트는 1주일 기준, 3일 기준, 1달 기준점은 모두 상이
-- 분석하는 사람, 누가 이탈하는지 해석, 보고서를 상급자에 보고
-- 상급자 회의 소집, 마케팅 플랜, 개발자한테 지시, 각 사용자에게 push 메시지

USE classicmodels;

-- 현재 테이블의 가장 최근 날짜
SELECT MAX(orderdate) MX_order
FROM orders
;

-- 현재 테이블의 가장 오래된 날짜
SELECT MIN(orderdate) MN_order
FROM orders
;

-- 각 고객의 마지막 구매일
SELECT 
	customernumber
    ,MAX(orderdate) 마지막구매일
FROM orders 
GROUP BY 1
;

-- 현재 시점은 2006-06-01
/*SELECT 
	customernumber
	,DATEDIFF('2006-06-01', MAX(orderdate))
FROM orders
GROUP BY 1;
*/
-- 구하고 싶은 건, 2006-06-01일 기준으로 가장 마지막에 구매한 날짜를 빼서 기간 구하기
-- DATEDIFF()

SELECT 
	*
    , '2005-06-01' AS 오늘날짜
    , DATEDIFF('2005-06-01', 마지막구매일) DIFF
FROM (
	SELECT 
	customernumber
    ,MAX(orderdate) 마지막구매일
FROM orders 
GROUP BY 1
)A
;

SELECT DATEDIFF(CURRENT_DATE, '2011-03-21');


-- DIFF를 90일 기준으로 Churn, Non-Churn
--                  이탈발생, 이탈미발생 
SELECT 
	customernumber
    , DATEDIFF(CURRENT_DATE, '2011-03-21')
	, CASE 
		WHEN DATEDIFF(CURRENT_DATE, '2011-03-21') >= 90 THEN 'Churn'
		ELSE 'Non-Churn' 
    END AS Y_N
FROM orders
GROUP BY 1
;

SELECT *
	, CASE WHEN DIFF >= 90 THEN '이탈발생' 
    ELSE '이탈미발생' 
    END 이탈유무
FROM(
	SELECT 
	*
    , '2005-06-01' AS 오늘날짜
    , DATEDIFF('2005-06-01', 마지막구매일) DIFF
FROM (
	SELECT 
	customernumber
    ,MAX(orderdate) 마지막구매일
	FROM orders 
	GROUP BY 1
	)A
)A
;

SELECT *
	, CASE WHEN DIFF >= 90 THEN '이탈발생' 
    ELSE '이탈미발생' 
    END 이탈유무
FROM(
	SELECT 
	*
    , '2005-06-01' AS 오늘날짜
    , DATEDIFF('2005-06-01', 마지막구매일) DIFF
FROM (
	SELECT 
	customernumber
    ,MAX(orderdate) 마지막구매일
	FROM orders 
	GROUP BY 1
	)A
)A
;

-- CHURN_LIST 테이블 생성하기
/*CREATE TABLE CLASSICMODELS.CHURN_LIST AS
SELECT CASE WHEN DIFF >= 90 THEN 'CHURN' ELSE 'NON-CHURN' END CHURN_TYPE,
CUSTOMERNUMBER
FROM
(SELECT CUSTOMERNUMBER,
	MX_ORDER,
	'2005-06-01' END_POINT,
	DATEDIFF('2005-06-01',MX_ORDER) DIFF
FROM
	(SELECT CUSTOMERNUMBER,
	MAX(ORDERDATE) MX_ORDER
	FROM CLASSICMODELS.ORDERS
	GROUPBY 1) 
    BASE) BASE
;
*/
-- Churn 고객이 가장 많이 구매한 Productline을 구해보자

SELECT 
	D.churn_type
	, C.productline,
	COUNT(DISTINCT B.customernumber) BU
FROM orderdetails A
LEFT
JOIN orders B
ON A.ordernumber = B.ordernumber
LEFT
JOIN products C
ON A.productcode = C.productcode
LEFT JOIN CHURN_LIST D
ON B.customernumber = D.customernumber
GROUP
BY 1, 2
HAVING churn_type = 'CHURN'
;

-- 4장을 이해하면, 6, 7장도 쉽게 이해할 수 있음
-- 3번 필사
-- 처음은 결과가 동일하게 나오는지 무조건 확인
-- 두번째는 각 메서드, 문법 궁금, 정리
-- 세번째는 살을 좀 더 붙이는 것 

-- Chapter 02
-- mydata
USE mydata;
SELECT * FROM dataset2;