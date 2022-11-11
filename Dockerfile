FROM python:3.7-slim-buster

#creating app directory and copying the source code
RUN mkdir /app
COPY . /app
WORKDIR /app

EXPOSE 8000

#installing pip libraries
RUN pip install -r requirements.txt

CMD export $(cat .env | xargs) && python hello.py

