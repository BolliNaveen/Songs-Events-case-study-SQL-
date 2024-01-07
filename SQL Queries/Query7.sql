--longest & shortest song the user heard in each session so we can put average
--for songs to not get the users feel boring

SELECT song_name, artist_name, session_id, song_length_in_seconds, user_id,
FIRST_VALUE(song_name) OVER(PARTITION BY session_id ORDER BY song_length_in_seconds DESC) longest_song,
FIRST_VALUE(song_name) OVER(PARTITION BY session_id ORDER BY song_length_in_seconds) shortest_song
FROM Events
WHERE song_name IS NOT NULL AND song_played = 'NextSong'
ORDER BY session_id;