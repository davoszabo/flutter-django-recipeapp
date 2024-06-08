# Overview
A mobile application for recipe recommendations. Huge recipe datasets trained for different recommendation system algorithms using collaboration (user) based filtering. Algorithms like k-Nearest Neighbor (kNN), Singular Value Decomposition (SVD), used to examine efficiency, and time cost in different sized datasets. Raw data needed to be finalized and manipulated to a solid form. Full-stack mobile application made to test out in a production-like environment.

### Used tools
- Flutter frontend
- Django backend and API, integration of trained ML model.
- PostgreSQL database
- Python machine learning, data manipulation tools and libraries.

# Getting started
The installation consist of several parts: Download datasets, refine them, run backend, import database, etc. This phase will go through how to make it running on your system.

### Prerequisites
- docker-compose for backend and db
- devcontainer CLI or VS Code remote dev exetension for frontend (recommended), or you can use installed flutter SDK on your system with version 2.2.0

## Data refinement
In `model/notebooks/datasets` you will find links that redirects to Kaggle. This is where the recipe database is coming from and they need to be saved in the `datasets` folder. This instruction won't go through how the dataset merge, refinement and sampling works. The notebooks contains enough information about that.

### Notebooks
Start Jupyter Notebook:
> [!IMPORTANT]
> This is a computational heavy platform so it is recommended to use at least 8 GB RAM and 4 cores.
```
cd model

docker-compose -f docker-compose-model.yaml up
```
Connect to the platform. The address, port and token are visible from the container output.

The following notebooks are used to create the database, which has been formatted for use. It is important to run them in this order!

> [!NOTE]
> There might be issues with the notebooks, because they are no longer maintained. Please get your bearings from the information in the files!

1. recipes_refine1-merge.ipynb
2. recipes_refine2-characteristic.ipynb
3. recipes_sampling.ipynb

You can leave the `recipes_sampling_quick-refine.ipynb` file.

The sampling part will make a test database with 25k lines if recipes. 

## Train model (Optional)
This is where the recipe recommendation system (RecRecSys) development, experimentation and polishing play a role. Take a look at the file: `recipes_model-reviews.ipynb`. Partly the model, and the training functionality has been integrated into the Django backend, so here only further improvement should happen.

The algorithms reviewed so far include KNN (K-Nearest Neighbor) and SVD (Singular Value Decomposition).

## Run Django backend
> [!NOTE]
> Production environment did not tested!

```
docker-compose up -d
```

Access the backend via `127.0.0.1:8000/admin`. To create a new admin user you have to run this command inside the container:
```
docker exec -it django_app bash -c "python manage.py createsuperuser"
```

Fill in the prompts with your user credentials.

Try it out! `127.0.0.1:8000/api/recipes`

## Import database
You'll see that the Recipes model is completely empty. This is where the previously generated .csv file is getting handy. 

There are two option:
1. Using psql CLI
2. Using pgadmin4

### 1. Using psql CLI
Copy sample dataset to postgres container:
```
docker cp model/notebooks/datasets/sample/recipes_sample_main.csv postgres_db:/tmp
```
Exec into postgres container and enter to the database:
```
docker exec -it postgres_db bash

psql -U postgres -w postgres
```
Import database:
> [!IMPORTANT]
> The refinement for the dataset is not 100% covered. If a message telling "ERROR:  malformed array literal:" You should search for that mentioned element and remove the whole row in the .csv file!
```
\copy api_recipe FROM '/tmp/recipes_sample_main.csv' DELIMITER ';' CSV HEADER
```

### 2. Using pgadmin4
If you ran docker compose, there is a pgadmin4 container also initiated. Access the site via `127.0.0.1:5050`. Enter admin credentials from compose file. Go for "Add New Server" and fill out the parameters. Name can be anything. The address is the container's address or `host.docker.interal` if you are running on Windows (not sure), the rest is obvious from compose file.

Look for `api_recipe` in `Databases > postgres > Schemes > public > Tables` and import the .csv file (right click > Import). If a message telling "ERROR:  malformed array literal:" You should search for that mentioned element and remove the whole row in the .csv file!


If everything worked fine, you are good to go!

## Connecting Flutter frontend
Go to `flutter_frontend/flutter_app/lib/global/globals.dart` and edit the `url` variable. There are instructions inside the file on what address should be used whether you use emulator or web server, etc.
