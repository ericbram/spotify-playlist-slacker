#!/bin/sh -l

ACCESS_TOKEN=$(curl --request POST -H "Authorization: Basic $1" -d grant_type=client_credentials https://accounts.spotify.com/api/token | jq -r .access_token)

TRACK_COUNT=$(curl --request GET --header "Content-Type: application/json" --url https://api.spotify.com/v1/playlists/$2 --header "Authorization: Bearer $ACCESS_TOKEN" | jq .tracks.total )

RANDOM_TRACK=$(( ( RANDOM % $TRACK_COUNT ) ))

TRACK=$(curl --request GET --header "Content-Type: application/json" --url "https://api.spotify.com/v1/playlists/$2/tracks?limit=1&offset=$RANDOM_TRACK" --header "Authorization: Bearer $ACCESS_TOKEN" | jq '.items[] | .track' )

TRACK_NAME=$(echo $TRACK | jq .name )
TRACK_ARTIST=$(echo $TRACK | jq .artists[0].name )
TRACK_URL=$(echo $TRACK | jq .external_urls.spotify )

echo "::set-output name=song-url::$TRACK_URL"
echo "::set-output name=song-name::$TRACK_NAME"
echo "::set-output name=song-artist::$TRACK_ARTIST"