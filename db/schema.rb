# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_27_174554) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "add_items", force: :cascade do |t|
    t.integer "product_id"
    t.integer "quantity"
    t.float "total_product_amount"
    t.float "price"
    t.date "expiration_date"
    t.date "second_expiration_date"
    t.integer "purchase_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_add_items_on_product_id"
    t.index ["purchase_id"], name: "index_add_items_on_purchase_id"
  end

  create_table "add_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
    t.string "price"
    t.float "discount"
    t.integer "quantity"
    t.float "total_product_amount"
    t.float "packaging_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "extra_tax"
    t.float "net_product_amount"
    t.index ["extra_tax"], name: "index_add_products_on_extra_tax"
    t.index ["order_id"], name: "index_add_products_on_order_id"
    t.index ["product_id"], name: "index_add_products_on_product_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "adquisition_costs", force: :cascade do |t|
    t.integer "product_id"
    t.float "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_adquisition_costs_on_product_id"
  end

  create_table "cash_registers", force: :cascade do |t|
    t.string "initial_cash"
    t.string "final_cash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "business_name"
    t.string "rut"
    t.string "address"
    t.integer "user_id"
    t.string "phone_number"
    t.string "schedule"
    t.string "special_agreement"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "line_of_business"
    t.integer "city"
    t.integer "town"
    t.integer "commune_id"
    t.integer "city_id"
    t.index ["city_id"], name: "index_clients_on_city_id"
    t.index ["commune_id"], name: "index_clients_on_commune_id"
    t.index ["group_id"], name: "index_clients_on_group_id"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "communes", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_communes_on_city_id"
  end

  create_table "consumes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "resource_id"
    t.integer "quantity"
    t.float "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.index ["resource_id"], name: "index_consumes_on_resource_id"
    t.index ["user_id"], name: "index_consumes_on_user_id"
  end

  create_table "delivery_methods", force: :cascade do |t|
    t.string "vehicle_plate"
    t.datetime "adquisition_date"
    t.integer "policy_number"
    t.string "ensurance_company"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "brand"
    t.string "vehicle_model"
    t.string "max_weight"
    t.string "consume"
    t.string "emergency_number"
    t.date "last_revision"
  end

  create_table "group_discounts", force: :cascade do |t|
    t.integer "product_id"
    t.integer "group_id"
    t.float "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_discounts_on_group_id"
    t.index ["product_id"], name: "index_group_discounts_on_product_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "money_movements", force: :cascade do |t|
    t.integer "movement_type"
    t.date "check_date"
    t.string "received_by"
    t.string "movement_category"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_payed"
    t.integer "payment_method"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "client_id"
    t.integer "user_id"
    t.integer "delivery_method_id"
    t.float "net_amount"
    t.float "total_iva"
    t.float "total_extra_taxes"
    t.float "total_amount"
    t.float "total_packaging_amount"
    t.datetime "visit_start"
    t.datetime "visit_end"
    t.float "discount_amount"
    t.string "discount_comment"
    t.boolean "create_invoive"
    t.string "responsable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date"
    t.string "detail"
    t.float "freight"
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["delivery_method_id"], name: "index_orders_on_delivery_method_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "packaging_convertions", force: :cascade do |t|
    t.string "name"
    t.integer "cost"
    t.integer "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_packaging_convertions_on_supplier_id"
  end

  create_table "packaging_receptions", force: :cascade do |t|
    t.integer "client_id"
    t.integer "total_box_amount"
    t.integer "total_payed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "delivery_method_id"
    t.integer "turn"
    t.index ["client_id"], name: "index_packaging_receptions_on_client_id"
    t.index ["delivery_method_id"], name: "index_packaging_receptions_on_delivery_method_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "order_id"
    t.integer "payment_method_id"
    t.float "amount_payed"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "check_date"
    t.index ["order_id"], name: "index_payments_on_order_id"
    t.index ["payment_method_id"], name: "index_payments_on_payment_method_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "category"
    t.string "packaging"
    t.string "format"
    t.string "description"
    t.string "unit"
    t.float "standard_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stock"
    t.float "cost"
    t.integer "units"
    t.integer "tax_id"
    t.integer "packaging_amount"
    t.index ["tax_id"], name: "index_products_on_tax_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "supplier_id"
    t.integer "invoice_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_amount"
    t.index ["supplier_id"], name: "index_purchases_on_supplier_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "group"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "stock_movements", force: :cascade do |t|
    t.integer "product_id"
    t.integer "initial_stock"
    t.integer "final_stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "movement_type"
    t.integer "stock_quantity"
    t.string "id_document"
    t.index ["product_id"], name: "index_stock_movements_on_product_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "rut"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taxes", force: :cascade do |t|
    t.string "name"
    t.float "percentage"
    t.integer "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "role"
    t.integer "gender"
    t.datetime "birthday"
    t.string "address"
    t.string "rut"
    t.string "phone_number"
    t.string "health_system"
    t.string "afp"
    t.string "emergency_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
