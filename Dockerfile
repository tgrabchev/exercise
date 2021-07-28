FROM ubuntu

RUN apt-get update
RUN apt-get install -y python python3-pip
RUN pip install flask

COPY flask.py /opt/flask.py

ENTRYPOINT FLASK_APP=/opt/flask.py flask run
