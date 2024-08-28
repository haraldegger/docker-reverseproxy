Introduction
============

docker-reverseproxy is a pure docker container providing the functionality of a reverse proxy web server.
The goal of this project is to provide you a simple standalone solution for a specific problem: reverse proxy in a nutshell.
This project does not use advanced techniques like Kubernetes or Docker Compose to provide you its functionalities.\
It is very much comparable to a virtual private server (VPS), but instead of running on a virtual machine (VM) it is running in a docker container.

Why should I use it?
============
There are already so many docker containers available, which offer similar functionalities and there exist even more providers which offer reverse proxy as a service.\
But: **Don't give away your freedom of such critical infrastructure!**\
This might be the backbone of your online presence, **so don't make you depend on anyone!**
- It is very simple, therefore easy to use and to maintain
- It is extremly easy and fast to set up, you can expect to be ready in under 5 minutes.
- Our project is open source, it uses very reliable software and it is licensed under the most permissive license
- It can run on any hardware, your home computer, your physical server, your VPS, it can run on any hosted server and it can also run in the cloud of each major cloud provider, **you decide** and you do not depend on them in any way. If you want to switch, you can do so at any time, with very little effort.

Is it secure?
============
This service will be most likely facing the internet 24h a day.\
This is very useful in providing service to your users, but it also opens a big attack vector for every bad criminal out there which wants to take you down!\
Therefore security is of highest importance for this project, and we try to keeping you save by the following standards:
- The docker image is based on [Debian], a very robust and reliable operating system. It is very conservative in updating packages to guarantee security and stability over (newer) functionality
- We use nginx to provide reverse proxy functionality, which is one of the most battle-tested webservers in the world
- We expose as little as possible to the internet, in this project basically only the http and https port (80 and 443) and optionally the sftp port (22) for file transfer (ssh login is blocked). The later has only to be opened whenever you want to update your configuration.
- We provide you with an easy update strategy, you basically recreate the docker container with the newest image and all your configuration and data is preserved. Since everything is already prepared beforehand the update process is basically instant.
- If you find any issue with our security concept which we might have missed or not understood in some way, please let us know imediately so that we can fix it asap

How to use it?
============
This service is thought to be working hand in hand with other web servoces, which means that the user requests go to the [reverse proxy] which then forwards it to another entity.\
All scripts and data and everything is saved in the /srv/ folder. If you want to backup or restore your data, everything you need to care about is in the /srv/data/ folder.\
\
**Use the following script to create the docker container:**\
docker run --name *NAME* --restart=always -p 80:80 -p 443:443 -p *SFTPPORT*:22 -e MY_USERNAME="*USERNAME*" -e MY_PASSWORD="*PASSWORD*" -e MY_PACKAGES="*PACKAGES*" haraldegger/docker-reverseproxy
- *NAME*: Name of the instance, we suggest to use the name of the domain, f.ex. github.com
- *SFTPPORT*: Port through which you can connect via SFTP, you need to provide this port only when you want to access your files, f.ex. 10022
- *USERNAME*: Username for the SFTP connection, we recommend to not use an easy to guess user, f.ex. jamesbond006
- *PASSWORD*: Password for the SFTP connection, we commend a very secure password, f.ex. 5RL8~BaJCjw}bW48LL7,wM;P4b7z[7)D,bWctj$0g-y.qN>K,<
- *PACKAGES*: You can specify additional packages, which you want to have installed and we did not forsee, most of the time you will not need this
- Summarizing the above you will get the following command: *docker run --name ReverseProxy --restart=always -p 80:80 -p 443:443 -p 10022:22 -e MY_USERNAME="jamesbond006" -e MY_PASSWORD="5RL8~BaJCjw}bW48LL7,wM;P4b7z[7)D,bWctj$0g-y.qN>K,<" haraldegger/docker-reverseproxy*

**Internal data structure**\
As mentioned before, everyhing we need we can find in the /srv/ directory:
- You are only able to access this folder from SFTP.
- */srv/bin/*: This folder contains the shell scripts, which make this service work
- */srv/data/*: This folder contains all your configuration and data, all you need you will find here
- */srv/data/cert/*: This folder contains the SSL certificates for your website, created through letsencrypt for your https connection.
- */srv/data/cfg/*: This folder contains all configuration files, for example the config file of the nginx server itself and for each individual website.
- */srv/data/log/*: This folder contains all log files. Be aware that most logging is done in a way that docker can read it, so you will find most logs there.
- */srv/tmp/*: This folder contains the temporary files- 

[Debian]: https://www.debian.org/
[reverse proxy]: https://en.wikipedia.org/wiki/Reverse_proxy
