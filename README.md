# Supysonic docker

This is a **lightweight** Python implementation of the Subsonic project's API - It's perfect if you want to just run a Subsonic compatible API for your streaming media server, and use an external client (such as [Tomahawk Player](https://www.tomahawk-player.org/) or [DSub for Android](https://play.google.com/store/apps/details?id=github.daneren2005.dsub)) to connect to your media library.

Docker image(s) have been modified from ogarcia's original images for use with the  [Ultimate Media Server](https://github.com/ultimate-pms/ultimate-plex-setup) Project.

----------------------------------------

### Running

To run this container exposing Supysonic over a FastCGI file socket in the
permanent data volume, mounting your `/media` and using sqlite backend,
simply run.

```
docker run -d \
  --name=supysonic \
  -v /srv/supysonic:/var/lib/supysonic \
  -v /media:/media \
  ogarcia/supysonic
```

This starts Supysonic with a preconfiguration in database so you can login
using `admin` user with same password.

## Configuration via Docker variables

The `dockerconfig.py` script that configures Supysonic use the following
Docker environment variables (please refer to [Supysonic readme][5] to know
more about this settings).

| Variable | Default value |
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
| `SUPYSONIC_RUN_MODE` | fcgi |

Take note that:
- The paths are related to INSIDE Docker.
- Other parts of Supysonic config file that not are referred here (as
  transcoding or mimetypes) will be untouched, you can configure it by hand.
- At this moment the supported values for `SUPYSONIC_RUN_MODE` are only
  `fcgi` to FastCGI file socket and `standalone` to run a debug server on
  port 5000.

  [5]: https://github.com/spl0k/supysonic/blob/master/README.md

## Running a shell

If you need to enter in a shell to use `supysonic-cli` first run Supysonic
Docker as daemon and then enter on it with following command.

```
docker exec -t -i supysonic /bin/sh
```

Remember that `supysonic` is the run name, if you change it you must use the
same here.
