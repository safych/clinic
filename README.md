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
APISECRET=apisecret
4) Enter the command
bundle install
5) Enter the commands
rails db:create
rails db:migrate
6) Enter the command
rails s
7) Сommand to stop the rails server
Ctrl+C

If you want to run the application on the server
1) Enter the command
cap production deploy