# Install and Setup ddclient for Dynamic DNS Updates

## Install
```
sudo apt update -y
sudo apt install ddclient libio-socket-ssl-perl
```


## Setup and Configuration

Open the ddclient configuration file:

```
sudo nano /etc/ddclient.conf
```

Create the configuration similar to the below one:

```
use=web
web=ipv4.icanhazip.com
protocol=googledomains
server=domains.google.com
ssl=yes
login=username
password='password'
www.sammysimpson.me

use=web
web=ipv4.icanhazip.com
protocol=googledomains
server=domains.google.com
ssl=yes
login=username
password='password'
sammysimpson.me
```

```use``` tells ddclient how to get the IP address to update the Dynamic DNS server.

```web``` is the domain of the web site to query to get the IP address to send to the Dynamic DNS service.

```protocol``` is set by the Dynamic DNS provider. For Google Domains this is ```googledomains```

```server``` is the hostname of the dynamic DNS server. This is given by the Dynamic DNS provider.

```ssl``` when set to ```yes``` will force ddclient to send the password using SSL so that the password cannot be sniffed. This needs to go above the ```protocol``` parameter in the configuration file.

```login``` is the passsword provided for the Dynamic DNS record.

```password``` is the passsword provided for the Dynamic DNS record. This needs to have single quotes around the password.

At the bottom of the block add the domains that you want to update.


## Verify Configuration

You can check if the pre-defined ```use``` values can detect your WAN IP by running this command:

```
sudo ddclient -query
```

To test your ddclient configuration with really verbose output, printing all possible configuration parameters and their values, you can use this command:

```
sudo ddclient -debug -verbose -noquiet
```

Check in the previous output that there is a line matching the following:

```
CONNECTED:  using SSL
```

## Run ddclient as a daemon

Since we don't just want the IP address to update once, we still need to set up ddclient to run as a daemon so it can check for a change of IP address periodically and notify the dynamic DNS provider if necessary.

Open the configuration file:

```
/etc/default/ddclient
```

Add or change the following line:

```
run_daemon="true"
```

The value for ```daemon_interval``` can also be changed too.

Save and close the file then run:

```
sudo service ddclient start
```

to start the daemon, and then run:

```
sudo service ddclient status
```