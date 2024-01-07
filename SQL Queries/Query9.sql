--analysis the income channel as we can know the income from each user from the level of the song paid or free

--get innformation of each user, count of paid songs and count of free songs

SELECT DISTINCT user_id, user_first_name, user_last_name,
COUNT(CASE song_level WHEN 'paid' THEN 1 END) OVER(PARTITION BY user_id) PAID_SONGS_NUMBER,
COUNT(CASE song_level WHEN 'free' THEN 1 END) OVER(PARTITION BY user_id) FREE_SONGS_NUMBER
FROM Events
WHERE song_name IS NOT NULL AND song_played = 'NextSong'

--calculate the percentage of the paid songs from the total and then order byb teh user id
SELECT user_id, user_first_name, user_last_name, PAID_SONGS_NUMBER, FREE_SONGS_NUMBER,
CAST(PAID_SONGS_NUMBER AS FLOAT)/ (PAID_SONGS_NUMBER + FREE_SONGS_NUMBER) PAID_SONGS_PERCENTAGE
FROM 
(
SELECT DISTINCT user_id, user_first_name, user_last_name,
COUNT(CASE song_level WHEN 'paid' THEN 1 END) OVER(PARTITION BY user_id) PAID_SONGS_NUMBER,
COUNT(CASE song_level WHEN 'free' THEN 1 END) OVER(PARTITION BY user_id) FREE_SONGS_NUMBER
FROM Events
WHERE song_name IS NOT NULL) SUB_QUERY
ORDER BY user_id;