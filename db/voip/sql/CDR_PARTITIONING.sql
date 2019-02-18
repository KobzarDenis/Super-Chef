DROP PROCEDURE IF EXISTS voip.cdr_partitioning;

DELIMITER $$
$$
CREATE DEFINER=`voip`@`localhost` PROCEDURE `voip`.`cdr_partitioning`()
    MODIFIES SQL DATA
BEGIN
	
 DECLARE v_finished INTEGER DEFAULT 0;
 DECLARE query VARCHAR(1000);
 DECLARE v_date INT DEFAULT NULL;
 DECLARE d_year NUMERIC(4,0) DEFAULT 0;
 
 -- declare cursor for CDR BILL_DATE
 DEClARE date_cursor CURSOR FOR SELECT DISTINCT YEAR(`BILL_DATE`) FROM CDR;

 -- declare NOT FOUND handler
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
 
 SET v_finished=0;
 SET @q = 'ALTER TABLE CDR REMOVE PARTITIONING;';
 PREPARE stmt FROM @q;
 EXECUTE stmt;
 DEALLOCATE PREPARE stmt;
 OPEN date_cursor;


 get_date: LOOP
 
 FETCH date_cursor INTO v_date;
 
 IF v_finished = 1 THEN 
 	LEAVE get_date;
 ELSE
	SET query = CONCAT('ALTER TABLE CDR PARTITION BY RANGE(YEAR(`BILL_DATE`)) SUBPARTITION BY HASH (MONTH(`BILL_DATE`)-1) (PARTITION y', v_date, ' VALUES LESS THAN (', v_date+1 ,') 
						(SUBPARTITION Jan_', v_date,
						', SUBPARTITION Feb_', v_date,
						', SUBPARTITION Mar_', v_date,
						', SUBPARTITION Apr_', v_date,
						', SUBPARTITION May_', v_date,
						', SUBPARTITION Jun_', v_date,
						', SUBPARTITION Jul_', v_date,
						', SUBPARTITION Aug_', v_date,
						', SUBPARTITION Sep_', v_date,
					 	', SUBPARTITION Nov_', v_date,
					 	', SUBPARTITION Oct_', v_date,
					 	', SUBPARTITION Dec_', v_date, '));');
	SET @q = query;
 	PREPARE stmt FROM @q;
 	EXECUTE stmt;
 	DEALLOCATE PREPARE stmt;
	
 END IF;

 END LOOP get_date;
 
 CLOSE date_cursor;

END$$
DELIMITER ;