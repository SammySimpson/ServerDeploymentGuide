# Enabling Two Factor Authentication on Ubuntu

## Create and Transfer SSH Certificates

https://www.ssh.com/academy/ssh/keygen

If you do not already have any SSH certificates, generate the them on client:
```shell
ssh-keygen –t rsa –b 4096 –C “your_email@example.com” 
```

Upload public key to server
```shell
ssh-copy-id remote-username@server-ip-address 
```

## Setup 2FA

Open SSH configuration file
```shell
sudo nano /etc/ssh/sshd_config
```

Enable challenge response authentication by changing the following line:
```shell
ChallengeResponseAuthentication yes
```

Restart the SSH service
```shell
sudo systemctl restart ssh
```

Install or open an app that can generate the TOTP token. (ex. - Google Authenticator, Authy, etc.)

Install the Google Authenticator software on the server
```shell
sudo apt install libpam-google-authenticator
```

Configure 2FA
```shell
google-authenticator
```

When asked if you want the token to be time-based, select "Y".

Scan the QR code with the app on your phone.

Copy down the emergency codes too, these allow you to access the server if the TOTP device is lost, without these it is not possible to access the server.

Switch back to your terminal window and answer “Y” when asked whether Google Authenticator should update your ```.google_authenticator``` file.

Then answer “Y” to disallow multiple uses of the same authentication token, “N” to increasing the time skew window, and “Y” to rate limiting in order to protect against brute-force attacks.


## Enabling 2FA and Certificate Authentication

We’re going to use Linux Pluggable Authentication Modules (PAM), which provides dynamic authentication support for applications and services, to add 2FA to SSH on Raspberry Pi.

Now we need to configure PAM to add 2FA:

```
sudo nano /etc/pam.d/sshd
```

At the top of the file add in:

```
auth sufficient pam_google_authenticator.so
```

Now we need to configure 2FA and key authentication to work properly:

```
sudo nano /etc/ssh/sshd_config
```

Uncomment or change the following lines (or add them in if they do not exist):
```
PermitRootLogin no
PasswordAuthentication no
AuthenticationMethods publickey,keyboard-interactive
UsePAM yes
```

Restart the SSH service

```
sudo systemctl restart ssh
```

Now, try to SSH into the server. It should not ask for a password since it will use the SSH key to authenticate and then it will ask for a 2FA code from your mobile device.