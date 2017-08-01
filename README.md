# Steps:

- Make sure to syncronize all the folders form here to the server

```
export ROOT_FOLDER=/root/iplatform
docker-machine scp -r public mainframe:/root/iplatform.ro
```

- make sure you overwrite the `TLD` and `ROOT_FOLDER` env variable on running docker-compose

```
TLD=iplatform.ro ROOT_FOLDER=/root/iplatform.ro docker-compose up --remove-orphans -d
```
