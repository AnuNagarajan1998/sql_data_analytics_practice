/*Not Boring Movies*/
SELECT
    *
FROM
    Cinema
WHERE
    id%2 != 0 AND description != 'boring'
ORDER BY
    rating DESC
	
/*Average Selling Price*/
SELECT
    p.product_id,
    COALESCE(ROUND(SUM(p.price*u.units)/SUM(u.units),2),0) AS average_price
FROM
    Prices AS p
LEFT JOIN
    UnitsSold AS u
ON
    p.product_id = u.product_id AND
    u.purchase_date BETWEEN p.start_date AND end_date
GROUP BY
    p.product_id
	
/*Project Employees I*/
SELECT
    p.project_id,
    ROUND(AVG(e.experience_years),2) AS average_years
FROM
    Project AS p
LEFT JOIN
    Employee AS e
ON
    p.employee_id = e.employee_id
GROUP BY
    p.project_id

/* Percentage of Users Attended a Contest*/
SELECT
    contest_id,
    ROUND(COUNT(user_id)/(
        SELECT
            COUNT(user_id)
        FROM
            Users
    )*100,2) AS percentage
FROM
    Register
GROUP BY
    contest_id
ORDER BY
    percentage DESC,
    contest_id ASC
	
	
/*Queries Quality and Percentage*/
SELECT
    query_name,
    ROUND(AVG(rating/position),2) AS quality,
    ROUND(AVG(CASE
            WHEN rating < 3 THEN 1
            ELSE 0
            END)*100,2) AS poor_query_percentage    
FROM
    Queries AS q
GROUP BY
    query_name
	
/*Monthly Transactions I*/
SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(amount) AS trans_count,
    COUNT(
        CASE
            WHEN state = 'approved' THEN 1
        END
    ) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(
        CASE
            WHEN state = 'approved' THEN amount
            ELSE 0
        END
    ) AS approved_total_amount
FROM
    Transactions
GROUP BY
    month,
    country
	
/*Immediate Food Delivery II*/
/*SELECT
   ROUND(AVG(CASE
        WHEN d.order_date = d.customer_pref_delivery_date THEN 1
        ELSE 0
    END)*100,2) AS immediate_percentage
FROM
    Delivery AS d
LEFT JOIN
    Delivery AS d1
ON
    d.customer_id = d1.customer_id AND
    d.order_date > d1.order_date
WHERE
    d1.delivery_id IS NULL*/

WITH first_order AS(
SELECT
    customer_id,
    min(order_date) AS date
FROM
    Delivery
GROUP BY
    customer_id
)
SELECT
    ROUND((SUM(CASE
        WHEN f.date = d.customer_pref_delivery_date  THEN 1
    END )/COUNT(*))*100,2) As immediate_percentage
FROM
    Delivery AS d
LEFT JOIN
    first_order AS f
ON
    d.customer_id = f.customer_id AND
    d.order_date-f.date = 0
WHERE 
    f.customer_id IS NOT NULL
	
/*Game Play Analysis IV*/

WITH min_date AS
(SELECT
    player_id,
    device_id,
    MIN(event_date) AS e_date,
    games_played
FROM
    Activity 
GROUP BY
    player_id
)
SELECT
    ROUND(COUNT(CASE
            WHEN DATEDIFF(a.event_date, m.e_date) = 1 THEN 1
        END)/(SELECT COUNT(DISTINCT player_id) FROM Activity),2) AS fraction
FROM
    Activity AS a
LEFT JOIN
    min_date AS m
ON
    a.player_id = m.player_id

 
/*ROUND(COUNT(CASE 
        WHEN a1.player_id IS NOT NULL THEN DATEDIFF(a.event_date, a1.event_date)
    END)/(SELECT COUNT(DISTINCT player_id) FROM Activity),2) AS fraction*/


    