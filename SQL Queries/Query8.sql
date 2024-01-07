--get teh no.of trails for each user and the no.of successful trails

SELECT user_id, user_first_name, user_last_name,
COUNT(user_id) OVER(PARTITION BY user_id) number_of_trails,
COUNT(CASE WHEN song_status = 200 THEN 1 END) OVER(PARTITION BY user_id) SUCCESSFUL_TRAILS
FROM Events
WHERE song_name IS NOT NULL AND song_played = 'NextSong'

--calculate the percentage of successful connection to teh website by successful trails by the no.of trails
--the result will be between [0,1]

SELECT DISTINCT user_id, user_first_name, user_last_name, number_of_trails, SUCCESSFUL_TRAILS,
CAST(SUCCESSFUL_TRAILS AS FLOAT)/ number_of_trails SUCCESSFUL_PERCENTAGE
FROM
(
SELECT user_id, user_first_name, user_last_name,
COUNT(user_id) OVER(PARTITION BY user_id) number_of_trails,
COUNT (CASE WHEN song_status=200 THEN 1 END) OVER(PARTITION BY user_id) SUCCESSFUL_TRAILS
FROM Events
WHERE song_name IS NOT NULL AND song_played = 'NextSong') SUB_QUERY
ORDER BY user_id;
