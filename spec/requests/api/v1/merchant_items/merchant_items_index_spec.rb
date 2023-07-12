require "rails_helper" 

RSpec.describe "Merchant Items", type: :request do 
  before(:each) do 
    @merchant = create(:merchant)
    create_list(:item, 10, merchant_id: @merchant.id)
  end

  describe "find all items for given merchant" do 
    it "with valid merchant data" do 
      get "/api/v1/merchants/#{@merchant.id}/items"
      @items = JSON.parse(response.body, symbolize_names: true)
      expect(response.code).to eq("200")
      expect(@items[:data].count).to eq(10)
      expect(@items[:data].first[:attributes][:merchant_id]).to eq(@merchant.id)
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
end