Build the image
tessilab@gitlab-runners:~/ubuntu16-opencv-runner$ docker build --tag ubuntu16-opencv-runner .

Run the container
docker run -d -ti --entrypoint /bin/sh --name gitlab-runner-ubuntu16-opcv ubuntu16-opencv-runner
