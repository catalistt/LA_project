#Supplier.create(name: "COMERCIAL CCU SPA", rut: "99.554.560-8")
#Product.create(code: "A01", name: "COCA COLA 3L DESECHABLE", category: nil, packaging: "DESECHABLE", format: "3LT", description: "DISPLAY DE 6 UNIDADES", unit: "DISPLAY", extra_tax: 0.205, standard_price: 11862.0, stock: 200, cost: 9882.0, units: 6)
#Product.create(code: "A02", name: "COCA COLA ZERO 3L DESECHABLE", category: nil, packaging: "DESECHABLE", format: "3LT", description: "DISPLAY DE 6 UNIDADES", unit: "DISPLAY", extra_tax: 0.18, standard_price: 11862.0, stock: 200, cost: 9882.0, units: 6)
#Product.create(code: "A03", name: "SPRITE 3 LITROS DESECHABLE", category: nil, packaging: "DESECHABLE", format: "3 LITROS ", description: "display de 6 unidades ", unit: "dsp", extra_tax: 0.18, standard_price: 9000.0, stock: 200, cost: 7000, units: 6)
#Group.create(name: "Almacenes y botillerias")
#Group.create(name: "Distribuidores")
#GroupDiscount.create(product_id: 1, group_id: 1, discount: 0.1416)
#GroupDiscount.create(product_id: 2, group_id: 2, discount: 0.2)
#DeliveryMethod.create(vehicle_plate: "KXRJ78", adquisition_date: nil, policy_number: nil, ensurance_company: nil, brand: "JAC", vehicle_model: "URBAN 1040", max_weight: "3000KG", consume: "6.7KM/LT", emergency_number: "600 786 1000", last_revision: "2020-11-25")
#User.create(email: "test@example.com", role: nil, gender: "femenino", birthday: "1996-05-07 00:00:00", address: "Test address", rut: "12.3456.789-0", phone_number: "12345677", health_system: "Isapre Colmena", afp: "AFP Modelo", emergency_number: "23456789", name: "UsuarioTest", provider: nil, uid: nil)
#Client.create(business_name: "Cliente test", rut: "12.345.678-9", address: "test address", user_id: 1, phone_number: "1234567", schedule: "07:00 - 13:00 / 15:00 - 22:00", special_agreement: "Cheque a 15 días", group_id: 1, line_of_business: "venta al por menor de bebidas alcohólicas")
#Client.create(business_name: "Cliente test", rut: "12.345.678-9", address: "test address", user_id: 1, phone_number: "1234567", schedule: "07:00 - 13:00 / 15:00 - 22:00", special_agreement: "Cheque a 15 días", group_id: 2, line_of_business: "venta en almacenes y botillerias")
Tax.create(name: "IVA" ,percentage: 0.19 , code: 14)
Tax.create(name: "Licores, pisco y destilados" ,percentage: 0.315 , code: 24)
Tax.create(name: "Vinos, chichas y sidras" ,percentage: 0.205 , code: 25)
Tax.create(name: "Cervezas y otras bebidas alcohólicas" ,percentage: 0.205 , code: 26)
Tax.create(name: "Aguas minerales y bebidas analcohólicas" ,percentage: 0.1 , code: 27)
Tax.create(name: "Bebidas analcohólicas con elevado contenido de azucar" ,percentage: 0.18 , code: 271)

Product.create(code: "A05", name: "INKA COLA 3 LITROS DESECHABLE", category: nil, packaging: "DESECHABLE", format: "3 LITROS ", description: "display de 6 unidades", unit: "dsp", tax_id: 6, standard_price: 9000.0, stock: 200, cost: 7000, units: 6)