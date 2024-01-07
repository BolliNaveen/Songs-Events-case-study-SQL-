--most famous song with session distribution among users 

--we get no.of users, session id and some info about each song in this session

SELECT session_id, song_name, COUNT(user_id) OVER(PARTITION BY session_id, song_name) users_number,
artist_name, song_level
FROM Events
WHERE song_name IS NOT NULL AND song_played = 'NextSong'

--rank of each song in each partition but with distinct to prevent the duplication as the user
--may hear the same song in the same session
SELECT DISTINCT session_id, song_name, users_number,
artist_name, song_level, DENSE_RANK() OVER(PARTITION BY session_id ORDER BY users_number DESC) song_rank FROM 
(SELECT session_id, song_name, COUNT(user_id) OVER(PARTITION BY session_id, song_name) users_number,
artist_name, song_level
FROM Events
WHERE song_name IS NOT NULL AND song_played = 'NextSong')SUB_QUERY

--to group the information by all selected column and order them by session number and rank number
SELECT* FROM
(
SELECT DISTINCT session_id, song_name, users_number,artist_name, song_level,
DENSE_RANK() OVER(PARTITION BY session_id ORDER BY users_number DESC) song_rank 
FROM (SELECT session_id, song_name, COUNT(user_id) OVER(PARTITION BY session_id, song_name) users_number, artist_name, song_level
FROM Events
WHERE song_name IS NOT NULL AND song_played = 'NextSong') SUB_QUERY) SUB_QUERY_2
GROUP BY session_id, song_name, song_level, users_number, artist_name, song_rank
ORDER BY session_id, song_rank;