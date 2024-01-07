--how long each user spend in our web site

SELECT DISTINCT user_id, user_first_name, user_last_name,
SUM(song_length_in_seconds) OVER(PARTITION BY user_id) USER_DURATIOIN_IN_SECONDS
FROM Events
WHERE song_name IS NOT NULL AND song_played ='NextSong';

--to oreder the users and give them rank according to the duration in seconds descending order

SELECT user_id, DENSE_RANK() OVER(ORDER BY USER_DURATION_IN_SECONDS DESC),
user_first_name, user_last_name, USER_DURATION_IN_SECONDS
FROM
(
SELECT DISTINCT user_id, user_first_name, user_last_name,
SUM(song_length_in_seconds) OVER(PARTITION BY user_id) USER_DURATION_IN_SECONDS
FROM Events
WHERE song_name IS NOT NULL AND song_played = 'NextSong') SUB_QUERY;