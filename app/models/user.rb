class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :documents, foreign_key: :uploader_id, dependent: :nullify
  belongs_to :company

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  enum :role, { normal: 0, admin: 1 }
end
