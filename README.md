# docker-phusion-postfix
Simple postfix relay host for your Docker containers. Based on lates Phusion base image (small footprint Ubuntu 16.04 installation).

Description
This server side image allows you to run POSTFIX internally inside your docker cloud/swarm installation to centralise outgoing email sending. 
The embedded postfix enables you to either send messages directly or relay them to your company's main server. 
That is why it should not be used with any clinet-side security featuers (it should support them if properly configurated, but it is not images main purpose, and has not been tested in those conditions) 

Image exposes standard port 25 for incoming messages. If any other port needed, change it in Dockerfile and it will work fine.

Etc and templates directories are for adding files if you are migrating Postfix from linux install to Docker, or from server to server. Etc directory should use only static, not changable files, and templates files that could be changed, like "main.cf" configuration.
This is great if you have a lot of changes or you are testing differenet configurations.

To run the container, you first need to build image and then run it
```
docker build -t phusion-postfix .
```

And then to run it:
```
docker run -p 25:25 --name postfix  phusion-postfix
```

You can now send emails by using localhost:25 as your SMTP server address.
You can test it via telnet. (just don't forget "." at the end)

```
telnet localhost 25 
MAIL FROM: goran.kelekovic@gmail.com
RCPT TO: goran.kelekovic@gmail.com
data
SUBJECT: Postfix Test
Hi,
Postfix test mail.
Admin
.
```

