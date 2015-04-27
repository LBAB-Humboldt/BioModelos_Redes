# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Create active admin user.
AdminUser.create!(:email => 'miguelstratoss@gmail.com', :password => 'abejamaya', :password_confirmation => 'abejamaya')

GroupState.create(:id => 1, :name => "Aprobado")
GroupState.create(:id => 2, :name => "Pendiente Aprobación")
GroupState.create(:id => 3, :name => "Rechazado")
GroupState.create(:id => 4, :name => "Inactivo")

GroupUserState.create(:id => 1, :name => "Aprobado")
GroupUserState.create(:id => 2, :name => "Pendiente Aprobación")
GroupUserState.create(:id => 3, :name => "Rechazado")
GroupUserState.create(:id => 4, :name => "Inactivo")

SpeciesGroupState.create(:id => 1, :name => "Aprobado")
SpeciesGroupState.create(:id => 2, :name => "Pendiente Aprobación")
SpeciesGroupState.create(:id => 3, :name => "Rechazado")
SpeciesGroupState.create(:id => 4, :name => "Inactivo")

Periodicity.create(:id => 1, :name => "Inmediata", :days => 0)
Periodicity.create(:id => 2, :name => "Diario", :days => 1)
Periodicity.create(:id => 3, :name => "Semanal", :days => 7)
Periodicity.create(:id => 4, :name => "Mensual", :days => 30)




