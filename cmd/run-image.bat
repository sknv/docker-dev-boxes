@REM Run the image.

@REM TODO: Uncomment required volume.

docker run -dt ^
  --name=<container-name> ^
  -v %cd%:/home/docker ^
  @REM Volume for MongoDB.
  @REM -v <image-name>-mongo-data:/data/mongodb ^
  @REM Volume for PostgreSQL.
  @REM -v <image-name>-pg-data:/data/postgresql ^
  -p <host-port>:<container-port> ^
  <image-name>
