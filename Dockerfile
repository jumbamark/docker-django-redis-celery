FROM python:3.9-alpine

ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN python3 -m pip install --upgrade pip
RUN pip install -r /requirements.txt
RUN pip list
RUN apk del .tmp-build-deps
RUN mkdir /app
COPY ./app /app
WORKDIR /app
