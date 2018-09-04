# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# User.create(name: "Mateo Vidal", email: "mateo@example.com", password: "deportivo", password_confirmation: "deportivo")
ruben = User.create(name: "Ruben Espinosa", email: "ruben@example.com", password: "deportivo", password_confirmation: "deportivo")
jack = User.create(name: "Jack Ibarra", email: "jack@example.com", password: "deportivo", password_confirmation: "deportivo")
alejo = User.create(name: "Alejo", email: "alejandro@example.com", password: "deportivo", password_confirmation: "deportivo")
fabian = User.create(name: "Fabian", email: "fabian@example.com", password: "deportivo", password_confirmation: "deportivo")

globant = Group.create(name: "amiwis")
yuxi = Group.create(name: "yuxi")

globant.users << ruben
globant.users << jack
# ruben.groups  << globant
# jack.groups   << globant

yuxi.users    << jack
yuxi.users    << fabian
yuxi.users    << alejo
# jack.groups   << yuxi
# fabian.groups << yuxi
# alejo.groups  << yuxi
