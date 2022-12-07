FROM python:latest

RUN apt-get -y update
RUN apt-get -y upgrade
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . /python-project
WORKDIR /python-project

CMD ["python", "app.py"]