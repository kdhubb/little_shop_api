class Invoice < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions

  enum status: { cancelled: 0, active: 1 }
end
