class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :documents, dependent: :destroy
end
