require 'dotenv'
Dotenv.load

server ENV["HOST"], user: "deploy", roles: %w{app db web}