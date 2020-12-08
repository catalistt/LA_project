# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Supplier.create(name: "COMERCIAL CCU SPA", rut: "	99.554.560-8")
#Product.create(cod: "A01", name: "COCA COLA 3LT DESECHABLE", type: "BEBIDA", packaging: "DESECHABLE", format: "3LT", description: "Display de 6 unidades", unit: "display", extra_tax: 0.18, standard_price: 11862)
#PaymentMethod.create(name: "efectivo")
#Group.create(name: "Almacenes y botillerias")
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?