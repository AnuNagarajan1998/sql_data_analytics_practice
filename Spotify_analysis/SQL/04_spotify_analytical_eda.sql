CREATE VIEW spotify_feature_popularity AS(

/* Danceablitiy affect the popularity*/
SELECT 
    'Danceability' AS feature,
    CASE
        WHEN danceability < 0.33 THEN 'Low'
        WHEN danceability >= 0.33  AND danceability < 0.67 THEN 'Medium'
        WHEN danceability >= 0.67 THEN 'High'
    END AS level,
    ROUND(AVG(popularity),2) AS average_popularity
FROM
    spotify_tracks
GROUP BY
    level
/*from this we can see that Medium group has a high popularity average*/
UNION ALL

/* ENergy affect the popularity*/
SELECT 
    'Energy' AS feature,
    CASE
        WHEN energy < 0.33 THEN 'Low'
        WHEN energy >= 0.33  AND energy < 0.67 THEN 'Medium'
        ELSE 'High'
    END AS level,
    ROUND(AVG(popularity),2) AS average_popularity
FROM
    spotify_tracks
GROUP BY
    level

UNION ALL

/*  Acousticness affect the popularity*/
SELECT 
    'Acousticness' AS feature,
    CASE
        WHEN acousticness < 0.33 THEN 'Low'
        WHEN acousticness >= 0.33  AND acousticness < 0.67 THEN 'Medium'
        ELSE 'High'
    END AS level,
    ROUND(AVG(popularity),2) AS average_popularity
FROM
    spotify_tracks
GROUP BY
    level

UNION ALL

/* Valence affect the popularity*/
SELECT 
    'Valence' AS feature,
    CASE
        WHEN valence < 0.33 THEN 'Low'
        WHEN valence >= 0.33  AND valence < 0.67 THEN 'Medium'
        ELSE 'High'
    END AS level,
    ROUND(AVG(popularity),2) AS average_popularity
FROM
    spotify_tracks
GROUP BY
    level

UNION ALL

/* Instrumentalness affect the popularity*/
SELECT 
    'Instrumentalness' AS feature,
    CASE
        WHEN instrumentalness < 0.33 THEN 'Low'
        WHEN instrumentalness >= 0.33  AND instrumentalness < 0.67 THEN 'Medium'
        ELSE 'High'
    END AS level,
    ROUND(AVG(popularity),2) AS average_popularity
FROM
    spotify_tracks
GROUP BY
    level

UNION ALL

/* Liveness affect the popularity*/
SELECT 
    'Liveness' AS feature,
    CASE
        WHEN liveness < 0.33 THEN 'Low'
        WHEN liveness >= 0.33  AND liveness < 0.67 THEN 'Medium'
        ELSE 'High'
    END AS level,
    ROUND(AVG(popularity),2) AS average_popularity
FROM
    spotify_tracks
GROUP BY
    level

UNION ALL

/* Speechiness affect the popularity*/
SELECT 
    'Speechiness' AS feature,
    CASE
        WHEN speechiness < 0.33 THEN 'Low'
        WHEN speechiness >= 0.33  AND speechiness < 0.67 THEN 'Medium'
        ELSE 'High'
    END AS level,
    ROUND(AVG(popularity),2) AS average_popularity
FROM
    spotify_tracks
GROUP BY
    level

UNION ALL

/* Tempo affect the popularity*/
SELECT 
    'Tempo' AS feature,
    CASE
        WHEN tempo < 81.1 THEN 'Low'
        WHEN tempo >= 81.1  AND tempo < 162.2 THEN 'Medium'
        ELSE 'High'
    END AS level,
    ROUND(AVG(popularity),2) AS average_popularity
FROM
    spotify_tracks
GROUP BY
    level
)

