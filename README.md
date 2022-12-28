# README
Description application
This application was created to automate the appointment of a patient to a doctor.

The setups steps expect following tools installed on the system
* Ruby 3.0.0
* Rails 7.0.4
* PostgreSQL
* Git
* Nodejs v16.18.1
* NPM 8.19.2
* Yarn 1.22.19

If you want to run the application locally:
1) Enter the command
git clone git@github.com:safych/clinic.git
2) Create file .env in folder clinic
3) Add to file .env
HOST=ip server or server namehost. If you want to deploy the application.
USERNAME=username_postgres_user
PASSWORD=password_postgres_user
CLOUDNAME=cloudname
APIKEY=apikey
APISECRET=apisecretAfter the deployment, do not forget to create an .env file in the application folder
4) Enter the command
bundle install
5) Enter the commands
rails db:create
rails db:migrate
6) Enter the command
rails s
7) To stop the rails server
Ctrl+C

If you managed to successfully launch the project locally, you can try to deploy it to the server.
Before deploying, make sure that everything you need is on the server and that a user has been created in Postgres!!!
1) Enter the command
cap production deploy
After the deployment, do not forget to create an .env file in the clinic folder!!!
2) Enter the commands for database
rake db:create RAILS_ENV=production
rake db:migrate RAILS_ENV=production
rake db:seed RAILS_ENV=production
Before starting the rails server, you need to open one of your server's ports to example 80
3) To start the rails server in process and on 80 port
RAILS_ENV=production rails s -p 80 --daemon
To stop rails server:
1) Command for check PID
lsof -wni tcp:80
2) Enter the command
kill PID