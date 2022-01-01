# Nginx Setup with SSL

## Install nginx

Install nginx

```
sudo apt install nginx
```


## Configure Nginx

Remove the default site

```
sudo rm /etc/nginx/sites-available/default
```

Create a new Nginx configuration file with the domain's name

```
sudo nano /etc/nginx/sites-available/example.com.conf
```

Add the configuration for the domain to the file

Symlink the configuration file from sites-available/ to sites-enabled/

```
sudo ln -s /etc/nginx/sites-available/example.com.conf /etc/nginx/sites-enabled/
```

In order to avoid a possible hash bucket memory problem that can arise from adding additional server names, we will also adjust a single value within our /etc/nginx/nginx.conf file. Open the file now:

```
sudo nano /etc/nginx/nginx.conf
```

Within the file, find the ```server_names_hash_bucket_size``` directive. Remove the # symbol to uncomment the line and change the value at the end of the line to ```64```.

Test the new nginx configuration

```
sudo nginx -t
```

Reload Nginx configuration without dropping connections:

```
sudo service nginx reload
```


### Start, Stop and Restart Nginx

To stop the web server when it is running, type:

```
sudo systemctl stop nginx
```

To start the web server when it is stopped, type:

```
sudo systemctl start nginx
```

To stop and then start the service again, type:

```
sudo systemctl restart nginx
```

### Reload Configuration

If you are only making configuration changes, Nginx can often reload without dropping connections. To do this, type:

```
sudo systemctl reload nginx
```

### Start and Stop Nginx on Boot

By default, Nginx is configured to start automatically when the server boots. If this is not what you want, you can disable this behavior by typing:

```
sudo systemctl disable nginx
```

To re-enable the service to start up at boot, you can type:

```
sudo systemctl enable nginx
```


### Server Configuration Locations

```/etc/nginx```: The Nginx configuration directory. All of the Nginx configuration files reside here.

```/etc/nginx/nginx.conf```: The main Nginx configuration file. This can be modified to make changes to the Nginx global configuration.

```/etc/nginx/sites-available/```: The directory where per-site server blocks can be stored. Nginx will not use the configuration files found in this directory unless they are linked to the sites-enabled directory. Typically, all server block configuration is done in this directory, and then enabled by linking to the other directory.

```/etc/nginx/sites-enabled/```: The directory where enabled per-site server blocks are stored. Typically, these are created by linking to configuration files found in the sites-available directory.

```/etc/nginx/snippets```: This directory contains configuration fragments that can be included elsewhere in the Nginx configuration. Potentially repeatable configuration segments are good candidates for refactoring into snippets.


### Server Logs

```/var/log/nginx/access.log```: Every request to your web server is recorded in this log file unless Nginx is configured to do otherwise.

```/var/log/nginx/error.log```: Any Nginx errors will be recorded in this log file unless Nginx is configured to do otherwise.


## Nginx Documentation

More information can be found here - [Nginx Documentation](https://nginx.org/en/docs/)



## Get SSL Certificates

Ensure snapd is installed and up to date

```
sudo snap install core; sudo snap refresh core
```

Remove any pre-installed certbot packages

```
sudo apt remove certbot
```

Install certbot

```
sudo snap install --classic certbot
```

Prepare the Certbot command

Execute the following instruction on the command line on the machine to ensure that the certbot command can be run

```
sudo ln -s /snap/bin/certbot /usr/bin/certbot
```

Get the certificates only

```
sudo certbot certonly --nginx
```

Test automatic renewal

The Certbot packages on your system come with a cron job or systemd timer that will renew your certificates automatically before they expire. You will not need to run Certbot again, unless you change your configuration. You can test automatic renewal for your certificates by running this command:

```
sudo certbot renew --dry-run
```

The command to renew certbot is installed in one of the following locations:

- ```/etc/crontab/```
- ```/etc/cron.*/*```
- ```systemctl list-timers```


### Add the SSL Certificates to the Nginx Configuration File

Open the Nginx configuration file with the domain's name

```
sudo nano /etc/nginx/sites-available/example.com.conf
```

Add in the following lines to the corresponding server block:

```
ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
```