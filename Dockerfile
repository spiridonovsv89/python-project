FROM python:3.10

RUN apt-get -y update
RUN apt-get -y upgrade
COPY . /python-project
WORKDIR /python-project
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
CMD ["python", "app.py"]