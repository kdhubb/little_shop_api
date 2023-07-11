require "rails_helper"

RSpec.describe "Create Item Request", type: :request do 
  describe "it creates a new item with received data" do 
    before(:each) do
      @merchant = create(:merchant)
    end
    it "accepts valid data" do 
      item_data = {
        "name": "Dogpack",
        "description": "Backpack for your dog to carry their own stuff.",
        "unit_price": 5.00,
        "merchant_id": @merchant.id
      }

      post "/api/v1/items", params: item_data
      new_item = Item.last

      expect(response.code).to eq("201")
      expect(new_item.name).to eq(item_data[:name])
      expect(new_item.description).to eq(item_data[:description])
      expect(new_item.unit_price).to eq(item_data[:unit_price])
      expect(new_item.merchant_id).to eq(item_data[:merchant_id])
    end

    it "ignores disallowed attributes" do 
      item_data = {
        "name": "Dogpack",
        "description": "Backpack for your dog to carry their own stuff.",
        "rating": 5,
        "materials": "ripstop nylon",
        "unit_price": 5.00,
        "merchant_id": @merchant.id
      }

      post "/api/v1/items", params: item_data
      new_item = Item.last

      expect(response.code).to eq("201")
      expect(new_item.name).to eq(item_data[:name])
      expect(new_item.description).to eq(item_data[:description])
      expect(new_item.unit_price).to eq(item_data[:unit_price])
      expect(new_item.merchant_id).to eq(item_data[:merchant_id])
      expect(new_item.attributes[:materials]).to be nil
      expect(new_item.attributes[:rating]).to be nil
    end
    
    it "rejects invalid data" do 
      item_data = {
        "description": "Backpack for your dog to carry their own stuff.",
        "unit_price": 5.00,
        "merchant_id": @merchant.id
      }
  
      post "/api/v1/items", params: item_data
  
      expect(response.code).to eq("422")
    end
  end
end