require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of :unit_price }
    it { should belong_to :merchant }
  end
  describe "associations" do 
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through (:invoice_items)}
  end

  describe "instance methods" do 
    it "single_item_invoice_delete" do 
      merchant = create(:merchant)
      customer = create(:customer)
      item1 = create(:item, merchant_id: merchant.id)
      invoice = item1.invoices.create!(merchant_id: merchant.id, status: :active, customer_id: customer.id)

      expect(item1.invoices.count).to eq(1)
      expect(invoice.items.count).to eq(1)

      item1.single_item_invoice_delete

      expect(item1.invoices.count).to eq(1)
    end
  end
end
