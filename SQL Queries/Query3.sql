--most played songs in all sessions in events table 

--first, count of users heard this song

SELECT song_name, artist_name, song_level, COUNT(USER_ID) OVER(PARTITION BY song_name) users_number
FROM Events
WHERE SONG_PLAYED = 'NextSong'

--lets use distinct

SELECT DISTINCT song_name, artist_name, song_level, COUNT(user_id) OVER(PARTITION BY song_name) users_number
FROM Events
WHERE song_played = 'NextSong'

--After this we get the rank of each song with dense rank and subquery
SELECT*, DENSE_RANK() OVER(ORDER BY USERS_NUMBER DESC) FROM
(SELECT DISTINCT song_name, artist_name, song_level, COUNT(USER_ID) OVER(partition by song_name) USERS_NUMBER
FROM Events
WHERE song_played = 'NextSong') SUB_QUERY_1
WHERE song_name IS NOT NULL;
