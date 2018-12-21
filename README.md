# PassMan
![PassMan: Free, open source, online password manager](app/assets/images/passman-medium.png)

## About

 Passman is free and open source online password manager. Although there are tons of free and open source password managers out there, most of them are not really convient to use on multiple devices. And solutions like Dashlane are somehow expensive, not to mention you have no control or knowlege of how they are stored or who has access to them. You can either use the online version, or better yet deploy it to your own server so that you'll feel at ease about the privacy of your passwords. The project uses docker compose so that it's as easy as possible to setup and run.

I hope that with the help of the online comunity, PassMan would grow to be the best and most secure password manager out there.

![Donate](app/assets/images/paypal.png) [Donate to the Project](https://donorbox.org/passman)

## Installation


##### 1. Install Docker and Docker Compose


##### 2. Clone the project

```bash
git clone https://github.com/mnvoh/passman
```


##### 3. Copy `.env.sample` to `.env` and make the necessary changes like changing hostname and postgres password.

```bash
cp .env.sample .env
```

##### 3-1. Generate a secret key and replace it in your `.env` file

```bash
head -n1000 | sha512sum
```

##### 4. Start the containers for the first time and make sure that everything works

```bash
docker-compose up
```
This also builds the containers, so watch out for errors in case any occurs.


##### 4. (for distributions using systemd) Create a systemd unit with this content:

```
[Unit]
Description=PassMan Compose Service
Requires=docker.service
After=docker.service

[Service]
Restart=always
WorkingDirectory=/home/[your-user-name]/passman
# Remove old containers, images and volumes
ExecStartPre=/usr/bin/docker-compose down -v
ExecStartPre=/usr/bin/docker-compose rm -fv
ExecStartPre=-/bin/bash -c 'docker volume ls -qf "name=%i_" | xargs docker volume rm'
ExecStartPre=-/bin/bash -c 'docker network ls -qf "name=%i_" | xargs docker network rm'
ExecStartPre=-/bin/bash -c 'docker ps -aqf "name=%i_*" | xargs docker rm'

# Compose up
ExecStart=/usr/bin/docker-compose up

# Compose down, remove containers and volumes
ExecStop=/usr/bin/docker-compose down -v

[Install]
WantedBy=multi-user.target
```

Then enable the service and start it:

```bash
sudo systemctl enable passman
sudo systemctl start passman
```

##### 5. Create a reverse proxy that points to localhost:3000. For example in Nginx:

```
upstream passman_web {
  server localhost:3069;
}

server {
  listen 80;
  server_name passman.xyz;

  location / {
    proxy_pass        http://passman_web;
    proxy_redirect    off;
    proxy_set_header  Host $host;
    proxy_set_header  X-Real-IP $remote_addr;
    proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header  X-Forwarded-Host $server_name;
    proxy_set_header  X-Forwarded-Proto $scheme;
    proxy_set_header  X-Forwarded-Ssl on;
    proxy_set_header  X-Forwarded-Port $server_port;
  }
}
```

Restart nginx and you should be able to visit the website using your domain.

#### 6. ⚠️ SETUP SSL

At this point without ssl, you have literally no security whatsoever. All your passwords could be easily compromised. So setup an ssl certificate and enable https on your website. The easiest way would be [Let's Encrypt](https://letsencrypt.org/).



## Contribution

All pull requests are welcome. Although considering the nature of the project, they might take a while to be fully verified and merged.

Also you could always [donate to the Project](https://donorbox.org/passman) so that I could keep the servers up and running ;-).

## Roadmap

- [x] Secure Notes
- [ ] Add markdown support to secure notes
- [ ] Import/Export
- [ ] API for future mobile apps