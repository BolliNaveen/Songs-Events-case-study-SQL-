--most conntributed users in the system 
 --users and the no.of songs they heard all over the session

 SELECT DISTINCT session_id, user_id, user_first_name, user_gender, user_last_name, song_name,
 COUNT(song_name) OVER(PARTITION BY user_id) songs_number
 FROM Events
 WHERE song_name IS NOT NULL AND song_played = 'NextSong'

 --give each user a rank and order them in descending order according to songs they hear

 SELECT*, DENSE_RANK() OVER(ORDER BY songs_number) user_rank
 FROM(
 SELECT DISTINCT session_id, user_id, user_first_name, user_gender, user_last_name, song_name,
 COUNT(song_name) OVER(PARTITION BY user_id) songs_number
 FROM Events
 WHERE song_name IS NOT NULL AND song_played = 'NextSong') SUB_QUERY;