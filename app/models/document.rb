class Document < ApplicationRecord
  belongs_to :company
  belongs_to :uploader, class_name: "User"
  has_one_attached :file
end
