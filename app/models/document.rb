class Document < ApplicationRecord
  belongs_to :company
  belongs_to :uploader, class_name: "User"
  has_one_attached :file

  after_create :generate_share_token

  private

  def generate_share_token
    update_column(:share_token, Digest::MD5.hexdigest("doc-#{id}")[0..7])
  end
end
