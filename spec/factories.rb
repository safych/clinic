FactoryBot.define do
  factory :patient do
    id { "1" }
    phone { "+380931232319" }
    password { "1234567" }
    name { "Bob" }
    surname { "Clooney" }
    age { 34 }
    residence { "etghieuhgiotjhijtr" }
  end

  factory :category do
    id { "1" }
    title { "Psychiatrist" }
  end

  factory :doctor do
    id { "1" }
    category_id { "1" }
    phone { "+380962043239" }
    name { "Andriy" }
    surname { "Morgan" }
    password { "123456" }
  end

  factory :appointment do
    doctor_id { "1" }
    patient_id { "1" }
    status { "wait" }
    date { "2022-12-12" }
  end
end