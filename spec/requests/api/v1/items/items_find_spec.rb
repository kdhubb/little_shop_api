require "rails_helper" 

RSpec.describe "Item Find/Search", type: :request do 
  before(:each) do 
    @merchant = create(:merchant)
    @item1 = Item.create!(name: "Little Chonk Pack", description: "Backpack to fit your chonk dog", unit_price: 15.00, merchant_id: @merchant.id)
    @item2 = Item.create!(name: "Doggy Pack", description: "Make your dog carry their own weight.", unit_price: 17.00, merchant_id: @merchant.id)
    @item3 = Item.create!(name: "Dog Leash", description: "Leash that will never rip or become a chew toy.", unit_price: 19.00, merchant_id: @merchant.id)
    @item4 = Item.create!(name: "Cat Fountain", description: "Drinking fountain for your cat", unit_price: 10.00, merchant_id: @merchant.id)
    @item5 = Item.create!(name: "Cat Adventurer", description: "Harness to take your cat climbing... it's a thing", unit_price: 12.00, merchant_id: @merchant.id)
  end

  describe "find an item by fragment" do 
    it "case-insensitive, partial match" do 
      get "/api/v1/items/find?name=DoG"
      @item_parsed = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(@item_parsed.count).to eq(1)
      expect(@item_parsed[:data]).to be_a(Hash)
      expect(@item_parsed[:data][:type]).to eq("item")
      expect(@item_parsed[:data][:attributes][:name]).to eq(@item3.name)
      expect(@item_parsed[:data][:attributes][:description]).to eq(@item3.description)
      expect(@item_parsed[:data][:attributes][:unit_price]).to eq(@item3.unit_price)
      expect(@item_parsed[:data][:attributes][:merchant_id]).to eq(@item3.merchant_id)
    end

    it "no params given, no match" do 
      get "/api/v1/items/find?name="
      @item_parsed = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.code).to eq("400")
      expect(@item_parsed[:errors].first).to be_a(Hash)
      expect(@item_parsed[:errors].first[:status]).to eq("400")
      expect(@item_parsed[:errors].first[:title]).to eq("No search paramater given")
      
      get "/api/v1/items/find?name=abcdefghi3927659hkhjg"
      @item_parsed = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.code).to eq("200")
      expect(@item_parsed).to eq("{data: nil}")
    end
  end
end