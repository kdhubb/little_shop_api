require "rails_helper" 

RSpec.describe "Item Find/Search", type: :feature do 
  before(:each) do 
    @item1 = Item.create!(name: )
  end
  describe "find an item by fragment" do 
    it "case-insensitive, partial match" do 
      get "/api/v1/items/find"
      @item_parsed = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(@item_parsed.count).to eq(1)
      expect(@item_parsed[:data]).to be_a(Hash)
    end

    it "no params given, no match" do 

    end
  end
end