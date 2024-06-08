# pull official base image
FROM python:3.10

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
# RUN apt-get update && \
#     apt-get install postgresql-dev gcc python3-dev musl-dev

RUN apt-get update && \
    apt-get install -y netcat-traditional && \
    rm -rf /var/lib/apt/lists/*

# install dependencies
COPY ./requirements.txt .
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Surprise package can only be acquired after numpy is already installed 
RUN pip install scikit-surprise

# copy entrypoint.sh
# COPY ./entrypoint.sh .
# RUN sed -i 's/\r$//g' /usr/src/app/entrypoint.sh && \
#     chmod +x /usr/src/app/entrypoint.sh

# copy project
COPY . .

# # run entrypoint.sh
ENTRYPOINT ["./docker/entrypoint.sh"]
