</> Markdown
#Recycleable Low fat Products.
## PROBLEM
Find the ids where it is both low fat and recyclable.
###


***+-------------+---------+<br>
| Column Name | Type    |<br>
+-------------+---------+<br>
| product_id  | int     |<br>
| low_fats    | enum    |<br>
| recyclable  | enum    |<br>
+-------------+---------+<br>***

***SOLUTION***
```sql
SELECT
  product_id
FROM
  Products
WHERE
  low_fats = 'Y'
  AND recyclable = 'Y';
```
## Concepts Used

- WHERE clause
- AND operator
- Filtering
