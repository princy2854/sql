CREATE DATABASE TASK_32_DML;

USE TASK_32_DML;
RENAME TABLE `insurance_data - insurance_data` TO insurance_data;

-- records of 'male' patient from 'southwest' region
SELECT * FROM INSURANCE_DATA WHERE GENDER='MALE' AND REGION='SOUTHWEST';

--  all records having bmi in range 30 to 45 both inclusive
SELECT * FROM INSURANCE_DATA WHERE BMI BETWEEN 30 AND 45;

-- minimum and maximum bloodpressure of diabetic patient who smokes. Make column names as MinBP and MaxBP respectively
SELECT min(bloodpressure)  AS MinBP,max(bloodpressure) AS  MaxBP FROM INSURANCE_DATA WHERE DIABETIC='Yes' AND SMOKER='Yes';

-- no of unique patients who are not from southwest region
SELECT  COUNT(distinct(patientId)) FROM INSURANCE_DATA WHERE region != 'southeast';

-- Total claim amount from male smoker
SELECT SUM(CLAIM) AS TOTAL FROM INSURANCE_DATA WHERE GENDER='male' AND SMOKER='Yes';

-- Select all records of south region
SELECT  * from insurance_data WHERE	REGION Like 'south%';

-- No of patient having normal blood pressure. Normal range[90-120]
SELECT COUNT(*) AS NO_PATIENT FROM INSURANCE_DATA WHERE BLOODPRESSURE BETWEEN 90 AND 120;

-- No of pateint belo 17 years of age having normal blood pressure as per below formula 
UPDATE INSURANCE_DATA SET AGE=CASE
WHEN PATIENTID=3 THEN 16
WHEN PATIENTID=4 THEN 15
WHEN PATIENTID=5 THEN 14
WHEN PATIENTID=6 THEN 13
WHEN PATIENTID=7 THEN 12
END
WHERE PATIENTID IN (3,4,5,6,7);
SELECT COUNT(*) FROM INSURANCE_DATA WHERE AGE<17 AND (BLOODPRESSURE BETWEEN 80+(AGE*2) AND 100+(AGE*2));
--  average claim amount for non-smoking female patients who are diabetic
SELECT ROUND(avg(CLAIM),2) AS TOTAL FROM INSURANCE_DATA WHERE GENDER='female' AND SMOKER='No' AND DIABETIC='Yes';

-- SQL query to update the claim amount for the patient with PatientID = 1234 to 5000
UPDATE INSURANCE_DATA
SET CLAIM=5000 WHERE PATIENTID=1234;

-- SQL query to delete all records for patients who are smokers and have no children
DELETE FROM INSURANCE_DATA WHERE SMOKER='Yes' AND CHILDREN=0;








