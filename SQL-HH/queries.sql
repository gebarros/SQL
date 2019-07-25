SELECT name, salary, months
FROM Employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id;

/*Calculating Manhattan Distance*/
SELECT ROUND(ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MIN(LONG_W) - MAX(LONG_W)), 4) AS distance
FROM STATION;

/*Calculating Euclidean Distance*/
SELECT ROUND(SQRT(POWER((MAX(LAT_N) - MIN(LAT_N)),2) 
    + POWER((MAX(LONG_W) - MIN(LONG_W)),2)),4)
FROM STATION;

/*Calculating Median*/

SELECT ROUND(AVG(LAT_N),4) AS median
FROM (
        SELECT @counter:=@counter+1 as row_id, t.LAT_N
        FROM STATION t, (select @counter:=0) t0
        ORDER BY t.LAT_N) t1
INNER JOIN (SELECT COUNT(*) AS total_rows
        FROM STATION)t2
WHERE t1.row_id in (FLOOR((t2.total_rows + 1)/2), FLOOR((t2.total_rows + 2)/2))

/*#####################*/
SELECT CITY.NAME 
FROM CITY 
INNER JOIN COUNTRY  
ON CITY.COUNTRYCODE = COUNTRY.CODE 
WHERE COUNTRY.CONTINENT = 'Africa'; 

/*#####################*/
SELECT COUNTRY.CONTINENT, FLOOR(AVG(CITY.POPULATION)) 
FROM CITY 
INNER JOIN COUNTRY  
ON CITY.COUNTRYCODE = COUNTRY.CODE 
GROUP BY COUNTRY.CONTINENT; 

/*#####################*/
SELECT 
    CASE
        WHEN G.GRADE < 8 THEN NULL
        ELSE S.NAME 
    END AS NAME,
    G.GRADE, S.MARKS
FROM STUDENTS S 
INNER JOIN GRADES G 
ON S.MARKS
BETWEEN G.MIN_MARK AND G.MAX_MARK
ORDER BY G.GRADE DESC, S.NAME;  

/*#####################*/
SELECT 
    CASE 
        WHEN A + B  <= C OR B + C <= A OR A + C <= B THEN 'Not A Triangle'
        WHEN A = B AND B = C THEN 'Equilateral'
        WHEN A = B OR B = C OR A = C THEN 'Isosceles'
        WHEN A <> B AND B <> C THEN 'Scalene'        
    END AS forms
FROM TRIANGLES;

/*#####################*/
SELECT CONCAT(Name,'(',SUBSTRING(Occupation, 1, 1),')') As letter
FROM Occupations 
ORDER BY 1;

SELECT CONCAT('There are a total of',' ',total,' ', LOWER(Occupation),'s.')
FROM(
    SELECT Occupation, COUNT(*) AS total
    FROM Occupations
    GROUP BY Occupation
    ORDER BY total) temp;

/*#####################*/
SELECT
   MIN(o.Doctor),MIN(o.Professor),MIN(o.Singer),MIN(o.Actor)
FROM
    (SELECT
        CASE WHEN occupation='Doctor' THEN @d:=@d+1
             WHEN occupation='Professor' THEN @p:=@p+1
             WHEN occupation='Singer' THEN @s:=@s+1
             WHEN occupation='Actor' THEN @a:=@a+1 END AS row,
        CASE WHEN occupation='Doctor' THEN name END AS Doctor,
        CASE WHEN occupation='Professor' THEN name END AS Professor,
        CASE WHEN occupation='Singer' THEN name END AS Singer,
        CASE WHEN occupation='Actor' THEN name END AS Actor
     FROM occupations JOIN (SELECT @d:=0, @p:=0, @s:=0,@a:=0) AS r 
     ORDER BY name) o
GROUP BY row;

/*#####################*/


 




 