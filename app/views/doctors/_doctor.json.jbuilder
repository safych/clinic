json.extract! doctor, :id, :name, :surname, :phone, :password, :created_at, :updated_at
json.url doctor_url(doctor, format: :json)
