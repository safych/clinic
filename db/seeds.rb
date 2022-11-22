Category.create([ 
  { title: "Oculist",  }, { title: "Traumatologist" }, { title: "Proctologist" }, { title: "Psychiatrist" }, 
  { title: "Dentist" }, { title: "Therapist" }, { title: "Urologist" }, { title: "Surgeon" }  
])
AdminUser.create!(email: 'admin@example.com', phone: "+380987777777", password: 'password', password_confirmation: 'password') if Rails.env.development?