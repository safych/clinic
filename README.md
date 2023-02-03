## Clinic
This application was created to automate the appointment of a patient to a doctor.

### Table of contents
* [Requirment](#requirment)
* [Setup](#setup)
* [Deploy](#deploy)

## Requirment
* Ruby 3.0.0
* Rails 7.0.4
* PostgreSQL
* Git
* Nodejs v16.18.1
* NPM 8.19.2
* Yarn 1.22.19

## Setup
1) Download the application to your device
```
$ git clone git@github.com:safych/clinic.git
```
2) Create file .env in folder clinic
3) Add to file .env
```
HOST=ip server or server namehost. If you want to deploy the application.
USERNAME=username_postgres_user
PASSWORD=password_postgres_user
CLOUDNAME=cloudname
APIKEY=apikey
APISECRET=apisecretAfter the deployment, do not forget to create an .env file in the application folder
```
4) Install all gems
```
$ bundle install
```
5) Database creation, migration, creation of an administrator and initial categories of doctors
```
$ rails db:create
$ rails db:migrate
$ rails db:seed
```
6) To run the application
```
$ rails s
```
7) To stop the application
```
Ctrl+C
```

## Deploy
1) To perform deployment
```
$ cap production deploy
```
2) Database creation, migration, creation of an administrator and initial categories of doctors
```
$ rake db:create RAILS_ENV=production
$ rake db:migrate RAILS_ENV=production
$ rake db:seed RAILS_ENV=production
```
3) Before starting the rails server, you need to open one of your server's ports to example 80. To start the rails server in process and on 80 port
```
$ RAILS_ENV=production rails s -p 80 --daemon
```
1) Command for check PID process
```
$ lsof -wni tcp:80
```
2) To stop rails server process
```
$ kill PID
```