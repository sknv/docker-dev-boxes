@REM Run the image.

docker run -dt ^
  --name=<container-name> ^
  -v %cd%:/home/docker ^
  -p <host-port>:<container-port> ^
  <image-name>
