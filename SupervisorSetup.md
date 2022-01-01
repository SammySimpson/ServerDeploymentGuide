# Setup Supervisor

## Install supervisor

Install supervisor

```
sudo apt install supervisor
```


## Configure supervisor

Create supervisor configuration, use an appropriate name, this one is for a web server hosted with Gunicorn

```
nano /etc/supervisor/conf.d/www.example.com.conf
```

Create supervisor configuration

```
[program:www.example.com]
command=/home/sammysimpson/www.example.com/venv/bin/gunicorn -b localhost:5000 -w 4 wsgi:app
directory=/home/sammysimpson/www.example.com
user=sammysimpson
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
```

Restart supervisor

```
sudo supervisorctl reload
```


## Restart the server and check if the supervisor configuration is working correctly

```
sudo reboot
```
