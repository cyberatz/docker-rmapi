# docker-rmapi
Docker container for rmapi

## Build status: 
![Build Status](https://travis-ci.com/cyberatz/docker-rmapi.svg)

## Environment variables
```markdown
RMAPI_CONFIG: filepath used to store authentication tokens. When not set, rmapi uses the file .rmapi in the home directory of the current user.
RMAPI_TRACE=1: enable trace logging.
RMAPI_USE_HIDDEN_FILES=1: use and traverse hidden files/directories (they are ignored by default).
RMAPI_THUMBNAILS: generate a thumbnail of the first page of a pdf document
RMAPI_AUTH: override the default authorization url
RMAPI_DOC: override the default document storage url
```

## Example run
docker run andrevs/rmapi -v 
docker run -v $HOME/.rmapi/:/home/user/.rmapi/ andrevs/rmapi help
