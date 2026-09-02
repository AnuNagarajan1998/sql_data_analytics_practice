
/*This block can be used to find the duplicate values*/

DELETE FROM spotify_tracks
WHERE ctid  IN (
SELECT
    ctid
FROM(
    SELECT
        ctid,
        ROW_NUMBER() OVER(PARTITION BY track_id,
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
                    ORDER BY track_id) AS rn
    FROM 
        spotify_tracks) AS t
WHERE
    rn > 1
)


ALTER TABLE spotify_tracks
DROP COLUMN unnamed_column
