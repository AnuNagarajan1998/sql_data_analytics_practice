/*Project Name: Spotify Analysis

Description: This project analyzes a Spotify tracks dataset to 
understand what track characteristics are associated with popularity.

The dataset contains information about artists, albums, tracks, popularity,
and various audio features such as danceability, energy, loudness, acousticness, 
instrumentalness, liveness, valence, and tempo.

The project will use PostgreSQL and SQL to clean, validate, 
explore, and analyze the data, with the goal of identifying patterns and 
factors that may influence a track's popularity.


This file handles
1.Missing values
2.Duplicate Records
3.Data inconsistency
4.Range validation
5.Data Intergrity
*/

/* This block executes to find the missing values*/

SELECT 
    COUNT (*) FILTER (WHERE track_id IS NULL) AS trackid_nullcheck,
    COUNT (*) FILTER (WHERE artists IS NULL) AS artists_nullcheck,
    COUNT (*) FILTER (WHERE album_name IS NULL) AS albumname_nullcheck,
    COUNT (*) FILTER (WHERE track_name IS NULL) AS trackname_nullcheck,
    COUNT (*) FILTER (WHERE popularity IS NULL) AS popularity_nullcheck,
    COUNT (*) FILTER (WHERE duration_ms IS NULL) AS durationms_nullcheck,
    COUNT (*) FILTER (WHERE explicit IS NULL) AS explicit_nullcheck,
    COUNT (*) FILTER (WHERE  danceability IS NULL) AS  danceability_nullcheck,
    COUNT (*) FILTER (WHERE  energy IS NULL) AS  energy_nullcheck,
    COUNT (*) FILTER (WHERE  key IS NULL) AS  key_nullcheck,
    COUNT (*) FILTER (WHERE loudness IS NULL) AS  loudness_nullcheck,
    COUNT (*) FILTER (WHERE  mode IS NULL) AS  mode_nullcheck,
    COUNT (*) FILTER (WHERE  speechiness IS NULL) AS  spechiness_nullcheck,
    COUNT (*) FILTER (WHERE  acousticness IS NULL) AS acousticness_nullcheck,
    COUNT (*) FILTER (WHERE  instrumentalness IS NULL) AS instrumentalness_nullcheck,
    COUNT (*) FILTER (WHERE  liveness IS NULL) AS liveness_nullcheck,
    COUNT (*) FILTER (WHERE  valence IS NULL) AS valence_nullcheck,
    COUNT (*) FILTER (WHERE  tempo IS NULL) AS tempo_nullcheck,
    COUNT (*) FILTER (WHERE  time_signature IS NULL) AS timesignature_nullcheck,
    COUNT (*) FILTER (WHERE  track_genre IS NULL) AS trackgenre_nullcheck
FROM 
    spotify_tracks

/*Helps to view the missing records*/
SELECT
    *
FROM    
    spotify_tracks
WHERE 
    artists IS NULL OR 
    album_name IS NULL OR 
    track_name IS NULL OR 
    track_id = '1kR4gIb7nGxHPI3D2ifs59'

/*This block can be used to find the duplicate values*/
SELECT  
    count_of_duplicates,
    COUNT(count_of_duplicates)
FROM(
    SELECT
        COUNT(track_id) AS count_of_duplicates
    FROM 
        spotify_tracks
    GROUP BY
        track_id,
        artists,
        album_name,
        track_name,
        popularity,
        duration_ms,
        explicit,
        danceability,
        energy,
        key,
        loudness,
        mode,
        speechiness,
        acousticness,
        instrumentalness,
        liveness,
        valence,
        tempo,
        time_signature,
        track_genre
    HAVING
        COUNT(track_id) > 1) AS t
GROUP BY
    count_of_duplicates

SELECT *
FROM spotify_tracks
LIMIT 10

/*This block is used to check for any numerical inconsistency in the dataused

We used universal values for calculating them but
for loudness and time_signature as we have no universal values
we are approcaching with max and min values and then for
time signature we use the count of each signatue*/
SELECT MIN(loudness), MAX(loudness)
FROM spotify_tracks

SELECT
    time_signature,
    COUNT(time_signature)
FROM    
    spotify_tracks
GROUP BY
    time_signature

/*This block checks for incompetencies in numerical data with universal values*/
SELECT
    *
FROM
    spotify_tracks
WHERE
    danceability NOT BETWEEN 0 AND 1
    OR energy NOT BETWEEN 0 AND 1 
    OR speechiness NOT BETWEEN 0 AND 1
    OR acousticness NOT BETWEEN 0 AND 1
    OR instrumentalness NOT BETWEEN 0 AND 1
    OR liveness NOT BETWEEN 0 AND 1
    OR valence NOT BETWEEN 0 AND 1
    OR popularity NOT BETWEEN 0 AND 100
    OR loudness NOT BETWEEN -50 AND 5
    OR key NOT BETWEEN 0 AND 11
    OR tempo <= 0
    OR time_signature NOT BETWEEN 0 AND 5
    OR duration_ms <=0
    
/* This block can be used for text inconsistency*/

/*This checks for trailing and leading spaces, null values and empty cell*/
SELECT
    *
FROM
    spotify_tracks
WHERE
    artists <> TRIM(artists) OR artists IS NULL OR artists = '' OR artists LIKE '%  %'
    OR album_name <> TRIM(album_name) OR album_name IS NULL OR album_name = '' OR album_name LIKE '%  %'
    OR track_name <> TRIM(track_name) OR track_name IS NULL OR track_name = '' OR track_name LIKE '%  %'
    OR track_genre <> TRIM(track_genre) OR track_genre IS NULL OR track_genre = '' OR track_genre LIKE '%  %'

/*check the pattern of track_id*/

SELECT
    *
FROM
    spotify_tracks
WHERE
    LENGTH(track_id) <> 22