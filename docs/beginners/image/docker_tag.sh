#!/usr/bin/env bash

# Gets all tags for a given docker image.

# Examples:

# retrieve all tags for a single library
# docker-tags "library/redis" | jq --raw-output '.[]'

# retrieve all tags for multiple libraries
# docker-tags "library/mongo" "library/redis" "microsoft/nanoserver" "microsoft/dotnet" | jq --raw-output '.[]'

# retrieve first 10 tags for multiple libraries
# docker-tags "library/mongo" "library/redis" "microsoft/nanoserver" "microsoft/dotnet" | jq --raw-output '.[][0:9]'

docker-tags() {
    arr=("$@")

    for item in "${arr[@]}";
    do
        tokenUri="https://auth.docker.io/token"
        data=("service=registry.docker.io" "scope=repository:$item:pull")
        token="$(curl --silent --get --data-urlencode ${data[0]} --data-urlencode ${data[1]} $tokenUri | jq --raw-output '.token')"
        listUri="https://registry-1.docker.io/v2/$item/tags/list"
        authz="Authorization: Bearer $token"
        result="$(curl --silent --get -H "Accept: application/json" -H "Authorization: Bearer $token" $listUri | jq --raw-output '.')"
        echo $result
    done
}
