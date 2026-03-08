class Document < ApplicationRecord
  belongs_to :company
  has_one_attached :file
end
