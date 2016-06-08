# Orangeindex - Traject for Princeton University Library specific Blacklight 

Bundles up [marc_liberation](https://github.com/pulibrary/marc_liberation/marc_to_solr) to run various rake/indexing tasks from a Docker container.

`sudo` is required for native Linux docker installations. `sudo docker pull pulibrary/orangeindex`

This image is linked on [Docker Hub](https://registry.hub.docker.com/u/pulibrary/orangeindex/) and [Github](https://github.com/pulibrary/dockerhub) under `images/orangeindex`. 

# Usage

To update Solr with today's updates run:
`sudo docker run pulibrary/orangeindex -e SET_URL=http://localhost:8983/solr`

To run a different index function, you can pass the rake task to bash:
`sudo docker run pulibrary/orangeindex bash -c 'rake index'`
