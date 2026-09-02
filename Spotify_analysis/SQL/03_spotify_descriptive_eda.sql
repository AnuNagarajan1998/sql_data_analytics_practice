/*Count the number of data available after cleaning all 
the values, unique artists, albumn_name and genre*/

SELECT  
    COUNT(*) AS Total_count_after_cleaning,
    COUNT(DISTINCT artists) AS unique_artists,
    COUNT(DISTINCT album_name) AS unique_albumn_name,
    COUNT(DISTINCT track_genre) AS unique_genre
FROM    
    spotify_tracks

/*Top 10 tracks with highest popularity*/
SELECT
    artists,
    track_id,
    track_name,
    popularity
FROM    
    spotify_tracks
ORDER BY 
    popularity DESC
LIMIT 10

/*Average popularity of tracks in each genre*/

SELECT
    track_genre,
    ROUND(AVG(popularity),2) AS Average_popularity
FROM    
    spotify_tracks
GROUP BY 
    track_genre
ORDER BY 
    Average_popularity DESC

/*Finding the popularity of explicit and non explicit tracks*/
SELECT
    explicit,
    ROUND(AVG(popularity),2) AS average_popularity
FROM
    spotify_tracks
GROUP BY
    explicit

/*Finding popularity based on mode*/

SELECT
    mode,
    ROUND(AVG(popularity),2) AS Average_popularity
FROM
    spotify_tracks
GROUP BY
    mode

/*Finding average track duration*/

SELECT
    ROUND(AVG(time_signature),2) AS Average_time,
    ROUND(AVG(danceability),2) AS Average_danceability,
    ROUND(AVG(energy),2) AS Average_energy,
    ROUND(AVG(speechiness),2) AS Average_speechiness,
    ROUND(AVG(acousticness),2) AS Average_acousticness,
    ROUND(AVG(instrumentalness),2) AS Average_instumentalness,
    ROUND(AVG(liveness),2) AS Average_liveness,
    ROUND(AVG(valence),2) AS Average_valence,
    ROUND(AVG(tempo),2) AS Average_tempo
FROM
    spotify_tracks

/* Finding average of top 10 artists track popularity*/
SELECT
    artists,
    ROUND(AVG(popularity),2) AS Average_popularity
FROM
    spotify_tracks
GROUP BY 
    artists
ORDER BY 
    Average_popularity DESC
LIMIT 10

/*Finding 10 artists have the highest average popularity among artists with at least 5 tracks*/

SELECT 
    artists,
    ROUND(AVG(popularity),2) AS Average_popularity
FROM
    spotify_tracks
GROUP BY
    artists
HAVING 
    COUNT(*) >= 5
ORDER BY 
    Average_popularity DESC
LIMIT 10

/*Finding 10 genre having highest average energy*/

SELECT
    track_genre,
    ROUND(AVG(energy),2) AS Average_energy
FROM
    spotify_tracks
GROUP BY
    track_genre
ORDER BY
    Average_energy DESC
LIMIT 10


/*Finding 10 genre having highest average danceablitiy*/

SELECT
    track_genre,
    ROUND(AVG(danceability),2) AS Average_danceability
FROM
    spotify_tracks
GROUP BY
    track_genre
ORDER BY
    Average_danceability DESC
LIMIT 10