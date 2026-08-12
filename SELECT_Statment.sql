/*Recyclable products*/
SELECT
    product_id
FROM
    Products
WHERE
    low_fats = recyclable AND low_fats != 'N'


/*Find Customer Referee*/
SELECT 
   name
FROM 
    Customer AS c
WHERE
    referee_id != 2 OR referee_id IS NULL


/*Big Countries*/
SELECT
    name,
    population,
    area
FROM
    World
WHERE
    area >= 3000000 OR population >= 25000000;
	
/*Article_view*/
SELECT
    DISTINCT author_id AS id
FROM
    Views
WHERE 
    author_id = viewer_id
ORDER BY 
    id
	
/*Invlaid_tweet*/
SELECT
    tweet_id
FROM
    Tweets
WHERE
    LENGTH(content) > 15