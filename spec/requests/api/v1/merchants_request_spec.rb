require "rails_helper" 

RSpec.describe "Merchants API", type: :request do 
  describe "it sends a list of all merchants" do 
    before(:each) do 
      create_list(:merchant, 10)
      get "/api/v1/merchants" 
      @merchants = JSON.parse(response.body, symbolize_names: true)
    end

    it "has a successful request" do
      expect(response.status).to eq(200)
      expect(@merchants[:data].count).to eq(10)
    end
    
    it "sends serialized data" do
      expect(@merchants[:data].first[:type]).to eq("merchant")
      expect(@merchants[:data].first[:attributes].has_key?(:name)).to be true
      expect(@merchants[:data].first[:id]).to be_a(String)
      expect(@merchants[:data].first[:attributes][:name]).to be_a(String)
    end
  end
  
  describe "it sends a single merchant by id" do 
    before(:each) do 
      @merchant = create(:merchant)
      get "/api/v1/merchants/#{@merchant.id}" 
      @merchant_parsed = JSON.parse(response.body, symbolize_names: true)
    end
    
    it "has a successful request" do 
      expect(response.status).to eq(200)
      expect(@merchant_parsed.count).to eq(1)
    end

    it "sends serialized data" do 
      expect(@merchant_parsed[:data]).to be_a(Hash)
      expect(@merchant_parsed[:data][:id]).to eq(@merchant.id.to_s)
      expect(@merchant_parsed[:data][:type]).to eq("merchant")
      expect(@merchant_parsed[:data][:attributes][:name]).to eq(@merchant.name)
    end
  end
end