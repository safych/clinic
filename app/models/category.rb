class Category < ApplicationRecord
  has_many :doctors, dependent: :nullify

  validates :title, uniqueness: true
end
