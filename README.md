# Supysonic docker

This is a **lightweight** Python implementation of the Subsonic project's API - It's perfect if you want to just run a Subsonic compatible API for your streaming media server, and use an external client (such as [Tomahawk Player](https://www.tomahawk-player.org/) or [DSub for Android](https://play.google.com/store/apps/details?id=github.daneren2005.dsub)) to connect to your media library.

Docker image(s) have been modified from ogarcia's original images for use with the  [Ultimate Media Server](https://github.com/ultimate-pms/ultimate-plex-setup) Project.

----------------------------------------
## Configuring:

Configuration is officially done via the `./config/.supysonic` file, however for ease of running the container quickly, you can set the following environment variables in your `docker-compose.yml` file, which are side-loaded in when the container starts:

| Variable | Default value if unset |
| --- | --- |
| `SUPYSONIC_DB_URI` | sqlite:////var/lib/supysonic/supysonic.db |
| `SUPYSONIC_SCANNER_EXTENSIONS` | |
| `SUPYSONIC_SECRET_KEY` | |
| `SUPYSONIC_WEBAPP_CACHE_DIR` | /var/lib/supysonic/cache |
| `SUPYSONIC_WEBAPP_LOG_FILE` | /var/lib/supysonic/supysonic.log |
| `SUPYSONIC_WEBAPP_LOG_LEVEL` | WARNING |
| `SUPYSONIC_DAEMON_LOG_FILE` | /var/lib/supysonic/supysonic-daemon.log |
| `SUPYSONIC_DAEMON_LOG_LEVEL` | INFO |
| `SUPYSONIC_LASTFM_API_KEY` | |
| `SUPYSONIC_LASTFM_SECRET` | |
| `SUPYSONIC_RUN_MODE` | standalone |

### Last.fm

To get up and running quickly, you'll really only need to configure Last.fm

- Create a Last.fm API account key at: [https://www.last.fm/api/account/create](https://www.last.fm/api/account/create)


### Remember that:

- The paths are related to INSIDE Docker.
- Other parts of Supysonic config file that not are referred here (as
  transcoding or mimetypes) will be untouched, you can configure it by hand.
- For performance you will want to setup a FastCGI server, rather than using the default embedded server.
- The `dockerconfig.py` script that configures Supysonic uses Docker environment variables which can be configured in your `docker-compose.yml` file (please refer to the [Supysonic Readme](https://github.com/spl0k/supysonic/blob/master/README.md) for further details on each variable and it's options)


## Running:

The quickest way to get up and running is by using [docker-compose](https://docs.docker.com/compose/):

```
# vi docker-compose.yml
docker-compose up -d --build
```

The container can also be run using a FastCGI socket, however you will need to change (or add) the `SUPYSONIC_RUN_MODE` variable to be: `fcgi`, and you will need to map that socket to your parent host (or another container) if you wish to access it from other services...


## Accessing:

By default, Supysonic will be started with the default configuration in the database with the following login details:

 - Username: `admin`
 - Password: `password`

**BE SURE TO CHANGE THE DEFAULT PASSWORD!**

You may access the login page via your favourite browser (providing you have not changed the port mapping in the docker-compose file) by going to:
`http://<your-hosts-ip>:8888/`

## Running additional CLI shell tools:

If you need to enter in a shell to use `supysonic-cli` first run attach to the running daemon, and then you may run the CLI tools.

```
docker exec -it subsonic bash
```
