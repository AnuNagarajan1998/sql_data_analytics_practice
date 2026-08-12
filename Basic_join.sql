/*replace employee id with unique identifier*/
SELECT
    EU.unique_id,
    E.name
FROM
    Employees AS E
LEFT JOIN
    EmployeeUNI AS EU
ON
    E.id = EU.id;


/*Product Sales Analysis I*/
SELECT
    p.product_name,
    s.year,
    s.price
FROM
    Sales AS s
LEFT JOIN
    Product AS p
ON
    s.product_id = p.product_id


/*Customer who visitied but not made transaction*/
SELECT
    v.customer_id,
    COUNT(*) AS count_no_trans
FROM
    Visits AS v
LEFT JOIN
    Transactions AS t
ON
    v.visit_id = t.visit_id
WHERE
    t.transaction_id IS NULL
GROUP BY
    v.customer_id
	
/*Rising Temperature*/
SELECT
    w.id
FROM
    Weather AS w
JOIN
    Weather AS we
ON
    w.recordDate = DATE_ADD(we.recordDate, INTERVAL 1 DAY)
WHERE 
    w.temperature > we.temperature
	
	
/*Average Time of Process per Machine*/
SELECT
    a.machine_id,
    ROUND(AVG(a1.timestamp - a.timestamp), 3) AS processing_time
FROM
    Activity AS a
JOIN
    Activity AS a1
ON
    a.process_id = a1.process_id AND
    a.machine_id = a1.machine_id
WHERE
    a.activity_type = 'start' AND
    a1.activity_type = 'end'
GROUP BY
    a.machine_id


/*Employee Bonus*/
SELECT
    name,
    bonus
FROM
    Employee AS e
LEFT JOIN 
    Bonus AS b
ON
    e.empId = b.empId
WHERE
    bonus IS NULL OR bonus < 1000
	
/*Students and Examinations*/
WITH Record AS(
    SELECT
        *
    FROM
        Students
    CROSS JOIN
        Subjects
)
SELECT
    r.student_id,
    r.student_name,
    r.subject_name,
    COUNT(e.student_id) AS attended_exams
FROM
    Record AS r
LEFT JOIN
    Examinations AS e
ON
    r.subject_name = e.subject_name AND
    r.student_id = e.student_id
GROUP BY
    r.subject_name,
    r.student_name,
    r.student_id
ORDER BY
    r.student_id,
    r.subject_name

/*Managers with at Least 5 Direct Reports*/
WITH manager_count AS
(SELECT
    e.name,
    COUNT(e1.managerId) AS count
FROM
    Employee AS e
INNER JOIN
    Employee AS e1
ON
    e.id = e1.managerId
GROUP BY 
    e1.managerId
)
SELECT
    name
FROM 
    manager_count
WHERE
    count >= 5


/*Confirmation Rate*/
SELECT
    s.user_id,
    ROUND(SUM(
        CASE
            WHEN action = 'timeout' THEN 0
            WHEN action = 'confirmed' THEN 1
            ELSE 0
        END
    )/COUNT(s.user_id),2) AS confirmation_rate
FROM
    Signups AS s
LEFT JOIN
    Confirmations AS c
ON
    s.user_id = c.user_id
GROUP BY
    s.user_id
