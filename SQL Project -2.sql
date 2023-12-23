-- question 1
CREATE SCHEMA alumni;

-- question 3
USE alumni;
DESC college_a_hs;
DESC college_a_se;
DESC college_a_sj;
DESC college_b_hs;
DESC college_b_se;
DESC college_b_sj;

-- question 6
CREATE VIEW college_a_hs_v AS (SELECT * FROM college_a_hs WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND
Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch IS NOT NULL AND
Degree IS NOT NULL AND PresentStatus IS NOT NULL AND HSDegree IS NOT NULL AND EntranceExam IS NOT NULL AND
Institute IS NOT NULL AND Location IS NOT NULL);

-- question 7
CREATE VIEW college_a_se_v AS (SELECT * FROM college_a_se WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND
Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch IS NOT NULL AND
Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization IS NOT NULL AND Location IS NOT NULL);

-- question 8
CREATE VIEW college_a_sj_v AS (SELECT * FROM college_a_sj WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND
Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch IS NOT NULL AND
Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization IS NOT NULL AND Designation IS NOT NULL AND
Location IS NOT NULL);

-- question 9
CREATE VIEW college_b_hs_v AS (SELECT * FROM college_b_hs WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND
Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND Branch IS NOT NULL AND Batch IS NOT NULL AND
Degree IS NOT NULL AND PresentStatus IS NOT NULL AND HSDegree IS NOT NULL AND EntranceExam IS NOT NULL AND
Institute IS NOT NULL AND Location IS NOT NULL);

-- question 10
CREATE VIEW college_b_se_v AS (SELECT * FROM college_b_se WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND
Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND Branch IS NOT NULL AND Batch IS NOT NULL AND
Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization IS NOT NULL AND Location IS NOT NULL);

-- question 11
CREATE VIEW college_b_sj_v AS (SELECT * FROM college_b_sj WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND
Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND  Branch IS NOT NULL AND Batch IS NOT NULL AND
Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization IS NOT NULL AND Designation IS NOT NULL AND
Location IS NOT NULL);

-- question 12
DELIMITER $$
USE `alumni`$$
CREATE PROCEDURE proc_college_a_hs ()
BEGIN
SELECT lower(Name),lower(FatherName),lower(MotherName) FROM college_a_hs_v;
END$$

DELIMITER ;
CALL proc_college_a_hs;

DELIMITER $$
USE `alumni`$$
CREATE PROCEDURE proc_college_a_se ()
BEGIN
SELECT lower(Name),lower(FatherName),lower(MotherName) FROM college_a_se_v;
END$$

DELIMITER ;
CALL proc_college_a_se;

DELIMITER $$
USE `alumni`$$
CREATE PROCEDURE proc_college_a_sj ()
BEGIN
SELECT lower(Name),lower(FatherName),lower(MotherName) FROM college_a_sj_v;
END$$

DELIMITER ;
CALL proc_college_a_sj;

DELIMITER $$
USE `alumni`$$
CREATE PROCEDURE proc_college_b_hs ()
BEGIN
SELECT lower(Name),lower(FatherName),lower(MotherName) FROM college_b_hs_v;
END$$

DELIMITER ;
CALL proc_college_b_hs;

DELIMITER $$
USE `alumni`$$
CREATE PROCEDURE proc_college_b_se ()
BEGIN
SELECT lower(Name),lower(FatherName),lower(MotherName) FROM college_b_se_v;
END$$

DELIMITER ;
CALL proc_college_b_se;

DELIMITER $$
USE `alumni`$$
CREATE PROCEDURE proc_college_b_sj ()
BEGIN
SELECT lower(Name),lower(FatherName),lower(MotherName) FROM college_b_sj_v;
END$$

DELIMITER ;
CALL proc_college_b_sj;

-- question 14
DELIMITER $$
CREATE PROCEDURE get_name_collegeA(INOUT com_nameA TEXT(20000))
BEGIN
DECLARE finished INT DEFAULT 0;
DECLARE nameA VARCHAR(16000) DEFAULT " ";
DECLARE nameA_details CURSOR FOR SELECT Name FROM college_a_hs UNION SELECT Name FROM college_a_se
UNION SELECT Name FROM college_a_sj;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
OPEN nameA_details;
loop1:LOOP
FETCH nameA_details INTO nameA;
IF finished = 1 THEN
LEAVE loop1;
END IF;
SET com_nameA = CONCAT(nameA,";",com_nameA);
END LOOP loop1;
CLOSE nameA_details;
END $$

DELIMITER ;

SET @A_name = " ";
CALL get_name_collegeA(@A_name);
SELECT @A_name;


-- question 15
DELIMITER $$
CREATE PROCEDURE get_name_collegeB(INOUT com_nameB TEXT(20000))
BEGIN
DECLARE finished INT DEFAULT 0;
DECLARE nameB VARCHAR(16000) DEFAULT " ";
DECLARE nameB_details CURSOR FOR SELECT Name FROM college_b_hs UNION SELECT Name FROM college_b_se
UNION SELECT Name FROM college_b_sj;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
OPEN nameB_details;
loop1:LOOP
FETCH nameB_details INTO nameB;
IF finished = 1 THEN
LEAVE loop1;
END IF;
SET com_nameB = CONCAT(nameB,";",com_nameB);
END LOOP loop1;
CLOSE nameB_details;
END $$

DELIMITER ;

SET @B_name = " ";
CALL get_name_collegeB(@B_name);
SELECT @B_name;

-- question 16
USE alumni;
SELECT 'HigherStudies' AS PresentStatus,(SELECT COUNT(*)FROM college_a_hs)/((SELECT COUNT(*)FROM college_a_hs)+(SELECT COUNT(*)FROM college_a_se)+(SELECT COUNT(*)FROM college_a_sj))*100 College_A_percentage,
(SELECT COUNT(*)FROM college_b_hs)/((SELECT COUNT(*) FROM college_b_hs)+(SELECT COUNT(*)FROM college_b_se)+(SELECT COUNT(*) FROM college_b_sj))*100 College_B_percentage
UNION
SELECT 'Self Employed' AS PresentStatus,(SELECT COUNT(*)FROM college_a_se)/((SELECT COUNT(*)FROM college_a_hs)+(SELECT COUNT(*)FROM college_a_se)+(SELECT COUNT(*) FROM college_a_sj))*100 College_A_percentage,
(SELECT COUNT(*) FROM college_b_se)/((SELECT COUNT(*) FROM college_b_hs)+(SELECT COUNT(*) FROM college_b_se)+(SELECT COUNT(*) FROM college_b_sj))*100 College_B_percentage
UNION
SELECT 'Service Job'PresentStatus,(SELECT COUNT(*)FROM college_a_sj)/((SELECT COUNT(*)FROM college_a_hs)+(SELECT COUNT(*) FROM college_a_se)+(SELECT COUNT(*) FROM college_a_sj))*100 College_A_percentage,
(SELECT COUNT(*)FROM college_b_sj)/((SELECT COUNT(*)FROM college_b_hs)+(SELECT COUNT(*)FROM college_b_se)+(SELECT COUNT(*) FROM college_b_sj))*100 College_B_percentage