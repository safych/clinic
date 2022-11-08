json.extract! patient, :id, :name, :surname, :age, :gender, :phone, :password, :created_at, :updated_at
json.url patient_url(patient, format: :json)
