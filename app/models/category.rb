class Category < ApplicationRecord
  has_many :doctors

  validates :title, uniqueness: true
end
