/*The Number of Employees Which Report to Each Employee*/
SELECT
    e.employee_id,
    e.name,
    COUNT(*) AS reports_count,
    ROUND(AVG(e1.age)) AS average_age
FROM
    Employees AS e
LEFT JOIN
    Employees AS e1
ON
    e.employee_id = e1.reports_to 
WHERE 
    e1.employee_id IS NOT NULL
GROUP BY
    e.employee_id
ORDER BY
    e.employee_id

/*Primary Department for Each Employee*/
WITH primary_dept AS(
SELECT
   employee_id,
   department_id
FROM
    Employee 
WHERE
    primary_flag = 'Y'
),
unique_count AS(
    SELECT
        employee_id,
        department_id
    FROM
        Employee 
    GROUP BY
        employee_id
    HAVING
        COUNT(employee_id) = 1
)
SELECT * FROM unique_count 
UNION ALL
SELECT * FROM primary_dept

/*Triangle Judgement*/
WITH side_cal AS
(SELECT
    *,
    CASE
        WHEN x > y and x > z THEN y+z
        WHEN y > z THEN x+z
        ELSE x+y
    END AS sum_of_sides
FROM 
    Triangle),
largest_side_cal AS
(SELECT
    *,
    CASE
        WHEN x > y and x > z THEN x
        WHEN y > z THEN y
        ELSE z
    END AS largest_side
FROM 
    Triangle)
SELECT
    s.x,
    s.y,
    s.z,
    CASE
        WHEN l.largest_side >= s.sum_of_sides THEN 'No'
        ELSE 'Yes'
    END AS triangle
    
FROM
    side_cal AS s
LEFT JOIN
    largest_side_cal AS l
ON
    s.x = l.x AND s.y = l.y AND s.z = l.z
ORDER BY
    s.x


/*Consecutive Numbers*/
SELECT
    DISTINCT num AS ConsecutiveNums
FROM(
    SELECT
        *,
        LAG(num,1) OVER (ORDER BY id) AS p1,
        LAG(num,2) OVER (ORDER BY id) AS p2
    FROM
        Logs
) AS l1
WHERE 
    num = p1 AND num = p2
	
/*Product Price at a Given Date*/
WITH date_rank AS(
SELECT
    *,
    ROW_NUMBER() OVER(PARTITION BY product_id 
    ORDER BY
        CASE
            WHEN change_date = '2019-08-16' THEN 1
            WHEN change_date < '2019-08-16' THEN 2
            ELSE 3
        END,
        CASE
            WHEN change_date < '2019-08-16' THEN change_date
        END DESC,
        CASE
            WHEN change_date > '2019-08-16' THEN change_date
        END ASC
    ) AS rn
 FROM 
    Products
)
SELECT
    product_id,
    CASE
        WHEN change_date <= '2019-08-16' THEN new_price
        WHEN change_date > '2019-08-16' THEN 10
    END AS price
FROM
    date_rank
WHERE 
    rn = 1
	
/*Last Person to Fit in the Bus*/
WITH find_sum AS(
SELECT
    *,
    SUM(weight) OVER (ORDER BY turn) AS total_sum
FROM
    Queue
)

SELECT
    person_name
FROM
    find_sum
WHERE
    total_sum <= 1000
ORDER BY
    turn DESC
LIMIT 1
    
/*Count Salary Categories*/
WITH fixed_category AS
(SELECT 'Low Salary' AS category
UNION ALL
SELECT 'Average Salary'
UNION ALL
SELECT 'High Salary'
),
Account_data AS(
SELECT
    *,
    CASE
        WHEN income < '20000' THEN 'Low Salary'
        WHEN income > '50000' THEN 'High Salary'
        ELSE 'Average Salary'
    END AS category_table
FROM 
    Accounts)

SELECT
    category,
    COUNT(income) AS accounts_count
FROM
    fixed_category AS f
LEFT JOIN
    Account_data AS a
ON 
    f.category = a.category_table
GROUP BY
    f.category