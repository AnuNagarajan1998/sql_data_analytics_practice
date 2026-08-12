/*Employees Whose Manager Left the Company*/SELECT
    e.employee_id
FROM
    Employees AS e
LEFT JOIN
    Employees AS e1
ON
    e.manager_id = e1.employee_id
    
WHERE 
    e.salary < 30000 AND e1.employee_id IS NULL AND e.manager_id IS NOT NULL
ORDER BY
    employee_id

/*Exchange Seats*/
WITH record AS
(SELECT
    *,
    LAG(student) OVER(ORDER BY id) AS p,
    LEAD(student) OVER(ORDER BY id) AS n
FROM
    Seat)

SELECT
    id,
    CASE
        WHEN id%2 = 0 THEN p
        WHEN id%2 != 0 THEN IF (n IS NULL, student, n)
    END AS student
FROM
    record
	
/*Movie Rating*/
WITH com_table AS
(SELECT
    mr.movie_id,
    m.title,
    mr.user_id,
    u.name,
    mr.rating,
    mr.created_at    
FROM
    MovieRating AS mr
LEFT JOIN
    Movies AS m
ON
    mr.movie_id = m.movie_id
LEFT JOIN
    Users AS u
ON
    mr.user_id = u.user_id
)
(
SELECT
    name AS results
FROM
    com_table
GROUP BY
    user_id
HAVING
    COUNT(user_id) > 0
ORDER BY
    COUNT(user_id) DESC,
    name
LIMIT 1)
UNION ALL
(
SELECT
    title AS results
FROM
    com_table
WHERE 
    created_at BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY
    movie_id
HAVING
    AVG(rating) > 0
ORDER BY
    AVG(rating) DESC,
    title 
LIMIT 1)

/*Restaurant Growth*/
WITH group_date AS
(SELECT
    visited_on,
    SUM(amount) AS total_amount,
    ROW_NUMBER() OVER(ORDER BY visited_on) AS rn
FROM
    Customer
GROUP BY
    visited_on
),
airth_func AS(
SELECT 
    visited_on,
    SUM(total_amount) OVER(ORDER BY visited_on
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
    ROUND(AVG(total_amount) OVER(ORDER BY visited_on 
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS average_amount,
    rn
FROM
    group_date
)
SELECT
    visited_on,
    amount,
    average_amount
FROM
    airth_func
WHERE rn >= 7

/*Friend Requests II: Who Has the Most Friends*/
WITH total_group AS(
SELECT 
    requester_id AS id,
    COUNT(*) AS count_no
FROM
    RequestAccepted
GROUP BY
    requester_id
UNION ALL
SELECT 
    accepter_id AS id,
    COUNT(*) AS count_no
FROM
    RequestAccepted
GROUP BY
    accepter_id)
SELECT
    id,
    SUM(count_no) AS num
FROM
    total_group
GROUP BY
    id
ORDER BY
    num DESC
LIMIT 1

/*Investments in 2016*/
WITH f_same_2015 AS(
SELECT
    tiv_2015
FROM
    Insurance
GROUP BY
    tiv_2015
HAVING
    COUNT(tiv_2015) > 1
),
r_lat_lon AS (
SELECT
    lat,lon
FROM
    Insurance 
GROUP BY 
    lat, lon
HAVING
    COUNT(*) = 1
)
SELECT
    ROUND(SUM(i.tiv_2016),2) AS tiv_2016
FROM
    Insurance AS i
JOIN
    f_same_2015 AS f
ON
    i.tiv_2015 = f.tiv_2015
JOIN
    r_lat_lon AS r
ON
    i.lat = r.lat AND
    i.lon = r.lon

/*Department Top Three Salaries*/
SELECT
    Department,
    Employee,
    Salary
FROM
(SELECT
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary,
    DENSE_RANK() OVER(PARTITION BY e.departmentId ORDER BY e.salary DESC) AS rn
FROM
    Employee AS e
LEFT JOIN
    Department AS d
ON
    e.departmentId = d.id) AS t
WHERE rn <= 3