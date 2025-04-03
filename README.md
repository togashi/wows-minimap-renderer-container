# WoWs Minimap Renderer Container

Containerized [minimap_renderer](https://github.com/WoWs-Builder-Team/minimap_renderer)

## Build image

```shell
> docker compose build default
```

## Render single replay file to video

```shell
> docker run -i --rm wows_minimap_renderer < file.wowsreplay > file.mp4
```

## Render all replay files to videos

```shell
> docker run -it --rm --mount type=bind,source=<PATH_TO_YOUR_REPLAYS_DIR>,target=/replays wows_minimap_renderer all
```

All replay files in the directory which you specified, will be processed.
