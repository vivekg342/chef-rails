# TODO

* configure logrotate
* install Percona Server and Percona Client (database recipe)
* install Xtrabackup

# chef-solo cookbooks for Ruby on Rails app

Set of roles and recipes for bootstrapping typical Ruby on Rails website. It uses nginx, unicorn and 
MySQL. Has been tested with Ubuntu 12.04.

## Requirements

1. You should be able to login as `root` to the target system.
2. Ruby 1.9.3

## Configuration

Rename ```config/application.json.sample``` to ```config/application.json```.

### user

```chef``` will create user which will be an owner of app directory. ```unicorn``` also will be started by this user. This user should be used when deploying with ```capistrano```.

### redirect_urls

Set if you need to permanently redirect users from some subdomains to the main domain. The most common case
if you need to redirect them from ```www.exacmple.com``` to ```example.com```.

### http_auth

This option can be used if you need to protect the website using HTTP Basic Auth. Simply remove it if you don't need it.

## Passwordless deploys

If you'd like to do passwordless deploys (using SSH public keys), you may wish to add public keys of users which should have such ability to the ```data_bags/authorized_keys/``` folder.

## Usage

```bash
HOST=192.168.2.103 CONFIG=application ./deploy.sh
```

It will install ```ruby``` and ```chef```, copy ```chef``` files to the target hostname, and run the JSON configuration with specified name.

## Available Roles

### application

Cookbook prepares directories for capistrano deployments and does initiall app configuration (```database.yml```, ```unicorn.rb```).

### frontend

Installs ```nginx``` and configures it to use ```unicorn``` as upstream.

### database

Install MySQL server.
