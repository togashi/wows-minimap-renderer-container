FROM python:3.10-alpine

RUN apk update && apk add git alpine-sdk ffmpeg
RUN pip install --upgrade pip langdetect hanzidentifier
RUN git clone https://github.com/WoWs-Builder-Team/minimap_renderer.git \
    && sed -i s/numpy==1\.23\.2/numpy==2\.2\.3/ minimap_renderer/setup.cfg \
    && sed -i s/numpy==1\.23\.2/numpy==2\.2\.3/ minimap_renderer/requirements.txt \
    && pip install --upgrade --root-user-action warn ./minimap_renderer

COPY Makefile /Makefile

VOLUME /replays

ENTRYPOINT ["make"]
