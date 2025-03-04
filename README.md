# WoWs Minimap Renderer Conatiner

Containerized [minimap_renderer](https://github.com/WoWs-Builder-Team/minimap_renderer)

## Build image

```shell
> docker compose build default
```

## Render replay to movies

```shell
> docker run -it --rm --mount type=bind,source=<PATH_TO_YOUR_REPLAYS_DIR>,target=/replays wows_minimap_renderer
```

All replay files in the directory which you specified, will be processed.
