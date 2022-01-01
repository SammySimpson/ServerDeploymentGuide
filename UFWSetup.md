# Setup UFW

Install UFW:

```shell
sudo apt install ufw -y
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw --force enable
sudo ufw status
```

View the status of UFW:

```
sudo ufw status
```

Enable UFW:

```
sudo ufw --force enable
```

Allow an application through the firewall:

```
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
```

See a list of profiles that UFW has:

```
sudo ufw app list
```

See the ports and protocols used by a profile/app:

```
sudo ufw app info <PROFILE>
```