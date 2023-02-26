# Overview
This docker-compose.yml file creates a MongoDB container with authentication and binds port 27017 to the host machine. It also creates a data volume for persisting the database files.

## Prerequisites
Docker and Docker Compose installed on your machine.

## Usage
1. Clone or download the repository to your local machine.
2. Navigate to the directory containing the docker-compose.yml file.
3. Run the following command to start the MongoDB container:
````bash
docker-compose up -d
````
This will start the container in the background and print the container ID.

4. Verify that the container is running:

````bash
docker ps
````
This should display a list of running containers on your machine, including the MongoDB container.

5. To stop the container, run:

````bash
docker-compose down
````
This will stop and remove the container.

## Configuration
The `mongodb_container` service in the `docker-compose.yml` file is configured with the following options:

- `image`: specifies the Docker image to use for the container. In this case, the latest version of the official MongoDB image.
- `environment`: sets environment variables for the container. In this case, sets the MongoDB root user credentials.
- `ports`: maps the container's port 27017 to the host machine's port 27017.
- `volumes`: creates a data volume for persisting the MongoDB data.

The volumes section of the docker-compose.yml file creates a named volume mongodb_data_container for storing the MongoDB data. 
This allows the data to persist even if the container is removed or recreated.