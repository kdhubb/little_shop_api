class Transaction < ApplicationRecord
  belongs_to :invoice 
  default_scope { order(id: :asc) }
  scope :successful, -> { where(result: "success") }
end
