FROM python:3.10-alpine as builder

RUN apk update && apk add --no-cache git alpine-sdk ffmpeg
RUN pip install --upgrade pip langdetect hanzidentifier
RUN git clone https://github.com/WoWs-Builder-Team/minimap_renderer.git \
    && sed -i s/numpy==1\.23\.2/numpy==2\.2\.3/ minimap_renderer/setup.cfg \
    && sed -i s/numpy==1\.23\.2/numpy==2\.2\.3/ minimap_renderer/requirements.txt \
    && pip install --upgrade --root-user-action warn ./minimap_renderer

FROM python:3.10-alpine

RUN apk update && apk add --no-cache ffmpeg make && rm -rf /var/cache/apk/*
RUN pip install --upgrade pip langdetect hanzidentifier

COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages

ENV REPLAYDIR=/replays
COPY Makefile /Makefile
COPY entrypoint.py /entrypoint.py
VOLUME ${REPLAYDIR}

ENTRYPOINT ["make"]
