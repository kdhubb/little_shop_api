require "rails_helper" 

RSpec.describe "Destroy Item Request", type: :request do 
  describe "destroy an item" do 
    it "destroys an item given the id" do 
      item = create(:item)
      
      expect(Item.count).to eq(1)

      delete "/api/v1/items/#{item.id}"
      
      expect(response.code).to eq("204")
      expect(Item.count).to eq(0)
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "destroys invoice if no items left" do 
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = item.invoices.create!(merchant_id: merchant.id, status: :active, customer_id: customer.id)

      expect(Invoice.count).to eq(1)

      delete "/api/v1/items/#{item.id}"
      
      expect(response.code).to eq("204")
      expect(Invoice.count).to eq(0)
      expect{Invoice.find(invoice.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end