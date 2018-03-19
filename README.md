# docker-centos-znc
## ZNC IRC bouncer running on the latest CentOS docker image (7.4)
### Build Version: 1
Date: 19th March 2018

The Dockerfile should intialise the CentOS image and subscribe to the EPEL repository. The pre-requisites, if any, for znc are then installed via yum.

The EPEL repository provides:

    supervisor
    znc

The ZNC daemon is controlled via the supervisord daemon which has a web front end exposed via port 9011. Default username and password for the web front end is admin:admin.

The container can be run as follows:

    docker pull jervine/docker-centos-znc
    docker run -d -t -n <optional name of container> -h <optional host name of container> -e USER="<user account to run as> -e USERUID="<uid of user account"> -e TZ="<optional timezone> -v /<config directory on host>:/config -p <ports to be exposed> jervine/docker-centos-znc

The USER and UID variables will be used to create an unprivileged account in the container to run the nzbget daemon under. The startup.sh script will create this user and also inject the username into the user= parameter of the znc.ini supervisor file.

The docker container is started with the -t switch to create a pseudo-TTY, as we'll run znc in the background.

The TZ variable allows the user to set the correct timezone for the container and should take the form "Europe/London". If no timezone is specified then UTC is used by default. The timezone is set up when the container is run. Subsequent stops and starts will not change the timezone.

The container can be verified on the host by using:

    docker logs <container id/container name>

At the moment, the znc ocnfig should be present in the /config directory (mapped form the host). If a new config is required, then you should run the --makeconf switch as your ZNC user account in the docker container:

    docker exec -it <container name> /bin/bash

Please note that the SELinux permissions of the config and downloads directories may need to be changed/corrected as necessary. [Currently chcon -Rt svirt_sandbox_file_t <directory>]
