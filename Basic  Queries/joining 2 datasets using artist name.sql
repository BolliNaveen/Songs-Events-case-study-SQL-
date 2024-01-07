SELECT E.ARTIST_NAME, E.SONG_LENGTH_IN_SECONDS,
S.SONG_DURATION_IN_SECONDS, E.SONG_NAME,
S.SONG_ID, S.SONG_RELEASED_YEAR

FROM Events E, songs S
WHERE E.ARTIST_NAME = S.ARTIST_NAME;