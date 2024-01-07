--most famous songs & some other information by joining two tables

SELECT * FROM
(
SELECT song_id, s.song_name, s.artist_id, e.artist_name, e.song_length_in_seconds,
COUNT(user_id) OVER(PARTITION BY song_id) users_number
FROM events E, songs S

WHERE E.song_name = S.song_name AND song_played = 'NextSong'
) SUB_QUERY ORDER BY users_number DESC;