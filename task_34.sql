use `task_32_dml`;
LOAD DATA LOCAL INFILE 'C:/Users/divya/Downloads/country_cl.csv'
INTO TABLE `task_32_dml`.`task_34 country_cl`
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

select * from `task_34 country_cl`;
-- 1. top 10 countries' which have maximum A and D values
SELECT AB.COUNTRY,ROUND(AVG(AB.A),2) AS AVG_A,ROUND(AVG(CD.D),2) AS AVG_D FROM `task_34 country_ab` AB
JOIN `task_34 country_cd` CD
on AB.Country=CD.Country 
GROUP BY AB.COUNTRY
ORDER BY AVG_A DESC, AVG_D DESC
LIMIT 10;

-- 2. Find out highest CL value for 2020 for every region. 
-- Also sort the result in descending order. Also display the CL values in descending order.
SELECT REGION,MAX(CL) AS 'HIGHEST_CL' FROM `task_34 country_cd` C 
join `task_34 country_cl` D 
ON C.COUNTRY=D.COUNTRY 
AND C.EDITION=D.EDITION
WHERE C.EDITION=2020
GROUP BY REGION
ORDER BY MAX(CL) DESC;

-- 3. top-5 most sold products
SELECT P.NAME,SUM(S.QUANTITY) AS "TOTAL QUANTITY"
FROM `task_34 products` P 
JOIN `task_34 sales1` S 
on P.PRODUCTID=S.PRODUCTID
GROUP BY P.NAME
ORDER BY `TOTAL QUANTITY` DESC
LIMIT 5;

-- 4. sales man who sold most no of products.
SELECT * FROM `task_34 EMPLOYEES`;
SELECT I.SALESPERSONID,CONCAT(E.FIRSTNAME,' ',E.MIDDLEINITIAL,' ',E.LASTNAME) AS NAME FROM (SELECT SALESPERSONID,SUM(QUANTITY) AS "TOTAL" FROM `task_34 sales1`
GROUP BY SALESPERSONID
ORDER BY TOTAL DESC) I
JOIN `task_34 EMPLOYEES` E
ON E.EMPLOYEEID=I.SALESPERSONID LIMIT 1;


-- 5. Sales man name who has most no of unique customer.
SELECT SALESPERSONID,concat(E.FIRSTNAME,' ',E.MIDDLEINITIAL,' ',E.LASTNAME) AS 'NAME',COUNT(DISTINCT(S.CUSTOMERID)) AS "UNIQUE_CUSTOMERS" FROM `task_34 sales1` S
JOIN `task_34 employees` E 
ON S.SALESPERSONID=E.EMPLOYEEID
GROUP BY S.SALESPERSONID,NAME
ORDER BY COUNT(DISTINCT(S.CUSTOMERID)) DESC
LIMIT 1;

-- 6. Sales man who has generated most revenue.
SELECT SALESPERSONID,concat(E.FIRSTNAME,' ',E.MIDDLEINITIAL,' ',E.LASTNAME) AS Name, Revenue FROM (SELECT S.SALESPERSONID,ROUND(SUM(QUANTITY*PRICE),2) AS REVENUE
FROM `task_34 products` P 
JOIN `task_34 sales1` S 
on P.PRODUCTID=S.PRODUCTID
GROUP BY S.SALESPERSONID
ORDER BY REVENUE DESC LIMIT 5) I
JOIN `task_34 employees` E
ON E.EMPLOYEEID=I.SALESPERSONID;

-- 7. all customers who have made more than 10 purchases.
SELECT C.CUSTOMERID,concat(C.FIRSTNAME,' ',C.MIDDLEINITIAL,' ',C.LASTNAME) AS NAME FROM (SELECT CUSTOMERID,COUNT(PRODUCTID) as 'no of purchases' 
FROM `task_34 sales1` 
GROUP BY CUSTOMERID 
HAVING `no of purchases`>10 
order by `no of purchases` DESC) I
JOIN `task_34 customers` C
ON C.CUSTOMERID=I.CUSTOMERID; 

-- 8. all salespeople who have made sales to more than 5 customers
SELECT SALESPERSONID,concat(E.FIRSTNAME,' ',E.MIDDLEINITIAL,' ',E.LASTNAME) AS 'NAME',COUNT(DISTINCT(S.CUSTOMERID)) AS "UNIQUE_CUSTOMERS" FROM `task_34 sales1` S
JOIN `task_34 employees` E 
ON S.SALESPERSONID=E.EMPLOYEEID
GROUP BY S.SALESPERSONID,NAME
HAVING UNIQUE_CUSTOMERS>=5;

-- 9. all pairs of customers who have made purchases with the same salesperson.
SELECT  DISTINCT S1.CUSTOMERID,S2.CUSTOMERID,S1.SALESPERSONID 
FROM `task_34 sales1` S1 
JOIN `task_34 sales1` S2 
ON S1.SALESPERSONID=S2.SALESPERSONID 
AND S1.CUSTOMERID<S2.CUSTOMERID;






