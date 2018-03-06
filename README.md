# docker-dev-boxes

A collection of Docker images for application development.

## Fixing Docker permissions

If you get an error message like this:

    $ docker: Got permission denied while trying to connect to the Docker daemon socket at unix...

Run the following command to add the current user to the docker group:

    sudo usermod -a -G docker $USER
