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

SELECT userid, AVG(duration)
FROM sessions
GROUP BY userid
HAVING COUNT(*) > 1

/*#######Binary search tree ##############*/
SELECT DISTINCT t1.N,
    CASE 
        WHEN t1.P IS NULL THEN 'Root'
        WHEN t2.N IS NULL THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM BST t1 
LEFT JOIN BST t2 
ON t1.N = t2.P 
ORDER BY t1.N; 

/*New Companies*/
SELECT C.company_code, C.founder, 
       COUNT(DISTINCT L.lead_manager_code),
       COUNT(DISTINCT S.senior_manager_code),
       COUNT(DISTINCT M.manager_code),
       COUNT(DISTINCT E.employee_code)
FROM Company C
INNER JOIN Lead_Manager L 
ON C.company_code = L.company_code
INNER JOIN Senior_Manager S 
ON C.company_code = S.company_code 
INNER JOIN Manager M 
ON C.company_code = M.company_code 
INNER JOIN Employee E 
ON C.company_code = E.company_code 
GROUP BY C.company_code, C.founder
ORDER BY C.company_code;

/*sum lat_n*/
SELECT TRUNCATE(SUM(LAT_N), 4)
FROM STATION
WHERE LAT_N BETWEEN 38.7880 AND 137.2345;

SELECT TRUNCATE(MAX(LAT_N), 4)
FROM STATION
WHERE LAT_N < 137.2345;

SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N < 137.2345
ORDER BY LAT_N DESC
LIMIT 1;

SELECT ROUND(MIN(LAT_N), 4)
FROM STATION
WHERE LAT_N > 38.7780;

SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N > 38.7780
ORDER BY LAT_N
LIMIT 1;

/*PLACEMENTS*/

SELECT S_NAME 
FROM (SELECT S.NAME AS S_NAME, P.SALARY AS STUDENT_SALARY, F.FRIEND_ID, P2.SALARY AS FRIEND_SALARY 
    FROM STUDENTS S 
    INNER JOIN FRIENDS F 
    ON S.ID = F.ID 
    INNER JOIN PACKAGES P 
    ON P.ID = S.ID
    INNER JOIN PACKAGES P2 
    ON P2.ID = F.FRIEND_ID) temp
WHERE STUDENT_SALARY < FRIEND_SALARY
ORDER BY FRIEND_SALARY; 

/*Symmetric Pairs*/
SELECT t1.X, t1.Y
FROM Functions t1 
INNER JOIN Functions t2 
ON t1.X = t2.Y AND t2.X = t1.Y
GROUP BY t1.X, t1.Y
HAVING COUNT(t1.X) > 1 or t1.X < t1.Y
ORDER BY t1.X;

/* Interviews */
SELECT C.contest_id, C.hacker_id, C.name, SUM(S.total_submissions) As total_submissions,
    SUM(S.total_accepted_submissions) AS total_accepted_submissions,
    SUM(V.total_views) AS total_views,
    SUM(V.total_unique_views) AS total_unique_views
FROM Contests C 
LEFT JOIN Colleges Co 
ON C.contest_id = Co.contest_id
LEFT JOIN Challenges Ch 
ON Co.college_id = Ch.college_id
LEFT JOIN (SELECT challenge_id, SUM(total_views) AS total_views, 
                  SUM(total_unique_views) AS total_unique_views
           FROM View_Stats
           GROUP BY challenge_id) AS V 
ON Ch.challenge_id = V.challenge_id
LEFT JOIN (SELECT challenge_id, SUM(total_submissions) AS total_submissions, 
                  SUM(total_accepted_submissions) AS total_accepted_submissions
           FROM Submission_Stats
           GROUP BY challenge_id) AS S 
ON Ch.challenge_id = S.challenge_id
GROUP BY C.contest_id, C.hacker_id, C.name
HAVING (total_submissions + total_accepted_submissions + total_views + total_unique_views) > 0
ORDER BY C.contest_id;

/*15 Days of Learning SQL*/ https://medium.com/@ZhangWenxuan1/hacker-rank-sql-challenge-15-days-of-learning-sql-71caf3696818

SELECT S.submission_date, COUNT(H.hacker_id) AS total,
    H.hacker_id, name 
FROM Hackers H  
INNER JOIN Submissions S 
ON H.hacker_id = S.hacker_id
WHERE S.submission_date BETWEEN 2016-03-01 AND 2016-03-15
AND S.submission_id >=1










 




 