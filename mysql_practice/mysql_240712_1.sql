--  테이블 생성
USE testdb;

CREATE TABLE vehicles(
	vehicleId INT
    , year INT NOT NULL
    , make VARCHAR(100) NOT NULL,
    PRIMARY KEY(vehicleId)
)
;

ALTER TABLE vehicles
ADD model VARCHAR(100) NOT NULL
;


DESCRIBE vehicles;

ALTER TABLE vehicles
ADD color VARCHAR(100) NOT NULL
;


-- 테이블 생성 시, 테이블 정의서 or 명세서
ALTER TABLE vehicles
ADD NOTE VARCHAR(100) NOT NULL;
DESC vehicles;

-- ALTER TABLE ~ MODIFY
ALTER TABLE vehicles
MODIFY NOTE VARCHAR(100) NOT NULL;

DESC vehicles;

-- 컬럼명 변경
ALTER TABLE vehicles
CHANGE COLUMN note vehicleCondition VARCHAR(50) NOT NULL;

DESC vehicles;


-- 컬럼만 삭제
ALTER TABLE vehicles
DROP COLUMN veicleCondition;

DESC vehicles;

-- 테이블명 변경
ALTER TABLE vehicles
RENAME TO cars;

DESC vehicles;
DESC cars;

COMMIT;


SHOW DATABASES;