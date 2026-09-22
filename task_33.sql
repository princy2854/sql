USE TASK_32_DML;
SELECT * FROM `task_33 sleep_efficiency`;

-- 1. average sleep duration of top 15 male candidates who's sleep duration are equal to 7.5 or greater than 7.5
SELECT ROUND(AVG(`Sleep duration`),2) AS AVERAGE FROM `task_33 sleep_efficiency` 
WHERE `Sleep duration`>=7.5 AND GENDER='Male' 
ORDER BY `Sleep duration` DESC LIMIT 15;

-- 2. avg deep sleep time for both gender
ALTER TABLE `task_33 sleep_efficiency`
ADD COLUMN `DEEP SLEEP VALUE` DECIMAL;

UPDATE `task_33 sleep_efficiency`
SET `DEEP SLEEP VALUE`=(`SLEEP DURATION`*`DEEP SLEEP PERCENTAGE`)/100;

SELECT GENDER,ROUND(AVG(`DEEP SLEEP VALUE`),2) FROM `task_33 sleep_efficiency` group by GENDER;

-- 3. Find out the lowest 10th to 30th light sleep percentage records where deep sleep percentage values are between 25 to 45
SELECT AGE,`Light sleep percentage`, `Deep sleep percentage` FROM `task_33 sleep_efficiency` 
WHERE `Deep sleep percentage` 
BETWEEN 25 AND 45
ORDER BY `Light sleep percentage` ASC
LIMIT 21 OFFSET 9;

-- 4. Group by on exercise frequency and smoking status and show average deep sleep time, 
-- average light sleep time and avg rem sleep time
SELECT `Exercise frequency` ,`Smoking status` AS SMOKING_STATUS,ROUND(AVG((`Deep sleep percentage`*`Sleep duration`)/100),2)
AS "AVERAGE DEEP SLEEP TIME" ,
ROUND(AVG((`Light sleep percentage`*`Sleep duration`)/100),2)
AS "AVERAGE LIGHT SLEEP TIME",
ROUND(AVG((`REM sleep percentage`*`Sleep duration`)/100),2) 
AS "AVERAGE REM SLEEP TIME"
FROM `task_33 sleep_efficiency` GROUP BY `Exercise frequency`,`Smoking status`;

-- 5. Group By on Awekning and show AVG Caffeine consumption, AVG Deep sleep time and AVG Alcohol consumption only 
-- for people who do exercise atleast 3 days a week. Show result in descending order awekenings
SELECT AWAKENINGS,ROUND(AVG(`Caffeine consumption`),2) AS 'AVERAGE CAFFEINE CONSUMPTION',
ROUND(AVG(`DEEP SLEEP VALUE`),2) AS 'AVERAGE DEEP SLEEP VALUE',
ROUND(AVG(`Alcohol consumption`),2) AS 'AVERAGE ALCOHOL CONSUMPTION'
FROM `task_33 sleep_efficiency` WHERE `Exercise frequency`>=3 
GROUP BY Awakenings 
ORDER BY AWAKENINGS DESC;

-- 6. Display those power stations which have average 'Monitored Cap.(MW)' (display the values) 
-- between 1000 and 2000 and the number of occurance of the power stations (also display these values) 
-- are greater than 200. Also sort the result in ascending order.
SELECT `Power Station`,ROUND(AVG(`Monitored Cap.(MW)`),2) AS AVERAGE_MW_VALUE
,COUNT(*) AS 'no_power_stations'
FROM `task_32_dml`.`task_33 powergeneration` 
GROUP BY `Power Station` 
HAVING (AVG(`Monitored Cap.(MW)`) 
BETWEEN 1000 AND 2000) AND COUNT(*)>200 ORDER BY COUNT(*) ASC;


LOAD DATA LOCAL INFILE 'C:/Users/divya/Downloads/shipping_ecommerce.csv'
INTO TABLE `task_32_dml`.`task_33 shipping_ecommerce`
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 7. Display top 10 lowest "value" State names of which the Year either belong to 2013 or 2017 or 2021 and type is 'Public In-State'. 
-- Also the number of occurance should be between 6 to 10. Display the average value upto 2 decimal places, 
-- state names and the occurance of the states.
SELECT STATE,Count(*) AS OCCURENCE,ROUND(AVG(Value),2) AS 'AVERAGE VALUE' FROM `task_33 nces330_20`
WHERE Year IN (2013,2017,2021) 
AND TYPE='Public In-State' 
GROUP BY STATE HAVING COUNT(*) BETWEEN 6 AND 10
ORDER BY AVG(Value) ASC LIMIT 10;

-- 8. Best state in terms of low education cost (Tution Fees) in 'Public' type university
SELECT STATE FROM `task_33 nces330_20` 
WHERE Type LIKE 'Public%' AND EXPENSE='Fees/Tuition' 
GROUP BY STATE 
ORDER BY SUM(VALUE) 
ASC LIMIT 1;

-- 9. 2nd Costliest state for Private education in year 2021. Consider, Tution and Room fee both.
SELECT STATE FROM `task_33 nces330_20` 
WHERE YEAR=2021 AND TYPE='Private' 
GROUP BY STATE 
ORDER BY SUM(VALUE) 
DESC LIMIT 1 OFFSET 1;

SELECT * FROM `task_33 nces330_20`;

-- 10. Display total and average values of Discount_offered for all the combinations of 'Mode_of_Shipment' (display this feature) 
-- and 'Warehouse_block' (display this feature also) for all male ('M') and 'High' Product_importance. 
-- Also sort the values in descending order of Mode_of_Shipment and ascending order of Warehouse_block
SELECT Mode_of_Shipment,Warehouse_block,SUM(Discount_offered) AS TOTAL,
ROUND(AVG(Discount_offered),2) AS AVERAGE
FROM `task_33 shipping_ecommerce` 
WHERE GENDER='M' AND Product_importance='high' 
GROUP BY Mode_of_Shipment,Warehouse_block 
ORDER BY Mode_of_Shipment DESC,Warehouse_block ASC;