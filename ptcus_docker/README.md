# Docker for Precision LMS

Note that all of the examples in this document call Docker without `sudo` however if your environment is not setup to run
Docker, you may need to add `sudo` to before the commands.


## Building Precision LMS
The image `ptcuops/fusion` is setup to properly build Precision LMS. Due to the various Javascript libraries
used in Precision LMS and the occasional use of somewhat out of date version of the same, Precision LMS can be something
of a bugger to build unless you get your environment setup _exactly_ right.


By using this image and the instructions provided here, you can build Precision LMS in the exact same manner in which
it will be built for production use with no extra setup on your part. The build will occur using your local code
and your local maven repository and will occur with negligible additional performance overhead. Once the Docker
image is cached locally, the container will start almost immediately.

To avoid a lot of unnecessary typing each time you run a maven command, you will want to setup an environment variable
that defines a number of variables used by docker during the build. In Linux, that variable definition should look
something like this:
```
opts="--rm -v /your/project/home:/data/code -w /data/code -v `readlink -f ~/.m2/repository`:/root/.m2/repository ptcuops/build_lms"

```

The first command, `--rm` will remove the built container once the commands you give it have completed. This is fine as the resulting files are actually on
your local drive and not in the container itself and this ensures that you don't end up with hundreds of containers, albeit small ones, taking up space on your drive.
The second command, ``-v /your/project/home:/data/code`` will mount your project directory as the `/data/code` directory in the new Docker container 
you are starting. The `-w /data/code` command simply tells Docker to set the working directory (i.e. the directory one starts in) to `/data/code`. The 
``-v `readlink -f ~/.m2/repository`:/home/fusionuser/.m2/repository``
command tells Docker to mount your local maven repository in the container at the location that maven will expect it to be when it runs inside the container.
Finally, `ptcuops/build-fusion` is, of course, the name of the image from which the container will be built.

To actually perform a build, all you need to do is issue a mvn command similar to the following:
```
docker run $opts /bin/bash -c 'mvn clean compile'
```

That specific command will build from the base project directory. It doesn't matter where you are in your local drive as the
container has your project directory mounted at `/data/code` and starts in that directory. With that in mind, if you wish
to only build a sub-project you can issue a series of commands like this:
```
docker run $opts /bin/bash -c 'cd fusion-service && mvn clean compile'
```

You can obviously get creative with shortcuts and batch files to shorten the command you type even more so that eventually
issuing maven commands with the docker container takes only a few more typed characters that doing the same command locally.

## Creating the Image
Creating an image is not needed for normal usage. An official image already exists in PTCU System's
private Docker Hub repository; however if needed, a local image can be recreated using the Dockerfile
in this directory using the command:
```
docker build -t ptcuops/build-lms .
```

After creating an "official" image, you can tag it with 

```
docker tag 723df52cf225 ptcuops/build-lms:1.0.0
```

You can then push the docker image to our docker hub (make sure you are alread logged in with "docker login" with
```
docker push ptcuops/build-ulc
```


Command to add this codbase as a subtree in an existing project

git stree add ptcus_docker -P ptcus_docker https://github.com/PtcUniversity/ptcus_docker.git
git stree add ptcus_docker -P ptcus_docker git@github.com:PtcUniversity/ptcus_docker.git

git-stree home - http://tdd.github.io/git-stree/


--testing tree updates
