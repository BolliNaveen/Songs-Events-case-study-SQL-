--order of famous artist in all sessions 

--artist information and counnt of songs they made 
SELECT DISTINCT artist_name, song_name, COUNT(song_name) OVER(PARTITION BY artist_name) songs_number
FROM Events
WHERE song_name IS NOT NULL

--artist rank according to the no.of users and sort them in descending order

SELECT*, DENSE_RANK() OVER(ORDER BY songs_number DESC)
FROM(
SELECT DISTINCT artist_name, song_name, COUNT(song_name) OVER(PARTITION BY artist_name) songs_number
FROM Events
WHERE song_name IS NOT NULL) SUB_QUERY
