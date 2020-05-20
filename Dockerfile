FROM alpine:3.6
# Add the packages
RUN apk add --no-cache python
RUN apk add --no-cache --virtual .build-deps py-pip python-dev musl-dev gcc mariadb-dev py-gunicorn
RUN apk add --no-cache \
    curl \
    bash
RUN mkdir -p /app
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
RUN chown -R 1001:1001 /app
USER 1001
ENTRYPOINT ["python" , "app.py"]
