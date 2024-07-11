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


-- 쇼핑몰, 리뷰 데이터
-- 댓글 분석, 감정 분석

SELECT 
	`Division Name`
    , AVG(RATING) AVG_RATE
FROM dataset2
GROUP BY 1
;
--
SELECT
	`Department Name`
    , AVG(RATING) AVG_RATE
FROM dataset2
GROUP BY 1
;
-- Trend의 평균 평점이 3.85
-- 세부적으로 내용을 확인해봅시당.
-- Department Name이 Trend인 것만 조회
-- RATING이 3점 이하인 것만 조회

SELECT *
FROM dataset2
WHERE `Department Name` = 'Trend' AND rating <=3
;


--
SELECT 
	`Department Name`
    , AVG(RATING) AVG_RATE
FROM dataset2
GROUP BY 1
;


SELECT CASE WHEN AGE BETWEEN 0 AND 9 THEN '0009'
WHEN AGE BETWEEN 10 AND 19 THEN '1019'
WHEN AGE BETWEEN 20 AND 29 THEN '2029'
WHEN AGE BETWEEN 30 AND 39 THEN '3039'
WHEN AGE BETWEEN 40 AND 49 THEN '4049'
WHEN AGE BETWEEN 50 AND 59 THEN '5059'
WHEN AGE BETWEEN 60 AND 69 THEN '6069'
WHEN AGE BETWEEN 70 AND 79 THEN '7079'
WHEN AGE BETWEEN 80 AND 89 THEN '8089'
WHEN AGE BETWEEN 90 AND 99 THEN '9099' END AGEBAND,
AGE
FROM MYDATA.DATASET2
WHERE 'DEPARTMENT NAME' = 'Trend'
AND RATING <= 3
;

-- 쉽게 하는 방법
-- 나눗셈을 이용하기 -> 16/10 1, 6, 6을 버린 후 조작을 하면 됨
-- FLOOR() 함수 사용
SELECT FLOOR(2.4);
SELECT 
	FLOOR(AGE/10) * 10 AS 연령대 -- CAST() 활용하면 형변환 가능 : 문자 -> 숫자, 숫자 -> 문자
    , AGE
FROM dataset2;

-- 연령대별 분포 : 평점 3점 이하 리뷰

SELECT 
	FLOOR(AGE/10) * 10 AS 연령대 -- CAST() 활용하면 형변환 가능 : 문자 -> 숫자, 숫자 -> 문자
    , COUNT(*) AS CNT
FROM dataset2
WHERE `Department Name` = 'Trend' AND rating <=3
GROUP BY 1
ORDER BY 2 DESC; -- 30대가 29명/ 40대가 24명 / 50대는 23명


-- 50대 3점 이하 Trend 리뷰만 추출
SELECT 
	`REVIEW TEXT`,
	FLOOR(AGE/10) * 10 AS 연령대 -- CAST() 활용하면 형변환 가능 : 문자 -> 숫자, 숫자 -> 문자
FROM dataset2
WHERE FLOOR(AGE/10) * 10 = 50 AND`Department Name` = 'Trend' AND rating <=3
;


-- 평점이 낮은 상품의 주요 Complain
SELECT 
	`Department Name`
    , ClothingID
    , AVG(rating) AVG_RATE
FROM dataset2
GROUP BY 1, 2
;

SELECT *
	, ROW_NUMBER() OVER(PARTITION BY `Department Name` ORDER BY AVG_RATE) RNK
FROM(
	SELECT 
		`Department Name`
		, ClothingID
		, AVG(rating) AVG_RATE
	FROM dataset2
	GROUP BY 1, 2
) A
;

-- 위 결과를 토대로,
-- 1-10위 데이터 조회
-- CREATE TABLE mydata.stat AS
SELECT *
FROM(
	SELECT *
		, ROW_NUMBER() OVER(PARTITION BY `Department Name` ORDER BY AVG_RATE) RNK
	FROM(
		SELECT 
			`Department Name`
			, ClothingID
			, AVG(rating) AVG_RATE
		FROM dataset2
		GROUP BY 1, 2
		) A
	)A
WHERE RNK BETWEEN 1 AND 10
;


SELECT ClothingID FROM stat
WHERE `department name` = 'Bottoms'; -- 불만족 1위-10위인 제품의 불만족 리뷰를 가져오는 것이 포인트

SELECT * FROM dataset2;

-- 문제 Department에서 Bottoms 불만족 1위-10위인 리뷰 텍스트를 가져오세요
-- 해당 ClothingID에 해당하는 리뷰 텍스트
-- 메인쿼리 : dataset2에서 review text만 가져오기
-- 서브쿼리 : stat 테이블에서 department가 bottoms인 clothingID
SELECT `review text`
FROM dataset2
WHERE clothingid IN (
	SELECT clothingid 
	FROM stat
	WHERE `department name` = 'bottoms'
)
;

SELECT clothingid 
FROM stat
WHERE `department name` = 'bottoms'
;

--
SELECT 
	`REVIEW TEXT`
    , CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END SIZE_YN
FROM dataset2
;

-- SIZE가 나온 댓글은 총 몇개일까? 
SELECT 
	`REVIEW TEXT`
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE' THEN 1 ELSE 0 END) N_SIZE
    , COUNT(*)N_TOTAL
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE' THEN 1 ELSE 0 END)/COUNT(*) AS ratio
FROM dataset2
;

SELECT SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END ) N_SIZE,
SUM(CASE WHEN `REVIEW TEXT` LIKE '%LARGE%' THEN 1 ELSE 0 END ) N_LARGE,
SUM(CASE WHEN `REVIEW TEXT` LIKE '%LOOSE%' THEN 1 ELSE 0 END ) N_LOOSE,
SUM(CASE WHEN `REVIEW TEXT` LIKE '%SMALL%' THEN 1 ELSE 0 END ) N_SMALL,
SUM(CASE WHEN `REVIEW TEXT` LIKE '%TIGHT%' THEN 1 ELSE 0 END ) N_TIGHT,
SUM(1) N_TOTAL
FROM MYDATA.DATASET2
;

USE titanic;
SELECT * FROM titanic;

-- 중복값 유무 확인
SELECT 
	COUNT(passengerid) N_PASS
    , COUNT(DISTINCT passengerid) N_UNIQUE_PASS
FROM titanic
;

-- 요일별 생존자 여부 집계
SELECT
	sex
	, COUNT(passengerid) AS 승객수
    , SUM(survived) AS 생존자수
    , ROUND(SUM(survived) / COUNT(passengerid), 3) AS 생존률
FROM titanic
GROUP BY 1; -- 0은 사망/ 1은 생존

-- 연령별 승객수, 생존자수, 비율 구하기

SELECT 
	FLOOR(AGE/10) * 10 AS 연령대 -- CAST() 활용하면 형변환 가능 : 문자 -> 숫자, 숫자 -> 문자
	, COUNT(passengerid) AS 승객수
    , SUM(survived) AS 생존자수
    , ROUND(SUM(survived) / COUNT(passengerid), 3) AS 생존률
FROM titanic
GROUP BY 1
ORDER BY 1; -- 0은 사망/ 1은 생존    



