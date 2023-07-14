class Invoice < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions

  enum status: { cancelled: 0, active: 1 }

  def self.most_expensive(limit = 5, sorting = "DESC")
    select("invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("revenue #{sorting}")
    .limit(limit)
  end
end
