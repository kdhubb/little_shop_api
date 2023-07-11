require "rails_helper" 

RSpec.describe "Items API", type: :request do 
  describe "it sends a list of all items" do 
    before(:each) do 
      create_list(:item, 10)
      get "/api/v1/items" 
      @items = JSON.parse(response.body, symbolize_names: true)
    end

    it "has a successful request" do
      expect(response.status).to eq(200)
      expect(@items[:data].count).to eq(10)
    end
    
    it "sends serialized data" do
      expect(@items[:data].first[:type]).to eq("item")
      expect(@items[:data].first[:attributes].has_key?(:name)).to be true
      expect(@items[:data].first[:attributes].has_key?(:description)).to be true
      expect(@items[:data].first[:attributes].has_key?(:unit_price)).to be true
      expect(@items[:data].first[:attributes].has_key?(:merchant_id)).to be true
      expect(@items[:data].first[:id]).to be_a(String)
      expect(@items[:data].first[:attributes][:unit_price]).to be_a(Float)
      expect(@items[:data].first[:attributes][:name]).to be_a(String)
    end
  end
  
  describe "it sends a single item by id" do 
    before(:each) do 
      @item = create(:item)
      get "/api/v1/items/#{@item.id}" 
      @item_parsed = JSON.parse(response.body, symbolize_names: true)
    end
    
    it "has a successful request" do 
      expect(response.status).to eq(200)
      expect(@item_parsed.count).to eq(1)
    end

    it "sends serialized data" do 
      expect(@item_parsed[:data]).to be_a(Hash)
      expect(@item_parsed[:data][:id]).to eq(@item.id.to_s)
      expect(@item_parsed[:data][:type]).to eq("item")
      expect(@item_parsed[:data][:attributes][:name]).to eq(@item.name)
      expect(@item_parsed[:data][:attributes][:description]).to eq(@item.description)
      expect(@item_parsed[:data][:attributes][:unit_price]).to eq(@item.unit_price)
      expect(@item_parsed[:data][:attributes][:merchant_id]).to eq(@item.merchant_id)
    end
  end
end