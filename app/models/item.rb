class Item < ApplicationRecord
  belongs_to :merchant
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :unit_price, numericality: true
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def single_item_invoice_delete
    invoices.each do |invoice|
      if invoice.items.count == 1
        invoice.destroy
      end
    end
  end

  def self.keyword_single(params)
    where("LOWER(items.name) LIKE LOWER('%#{params}%')")
    .order(name: :asc)
    .first
  end

  def self.keyword_all(params)
    where("LOWER(items.name) LIKE LOWER('%#{params}%')")
    .order(name: :asc)
  end
end