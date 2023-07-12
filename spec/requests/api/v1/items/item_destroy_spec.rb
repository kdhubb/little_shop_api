require "rails_helper" 

RSpec.describe "Destroy Item Request", type: :request do 
  describe "destroy an item" do 
    it "with valid data" do 
      item = create(:item)
      
      expect(Item.count).to eq(1)

      delete "/api/v1/items/#{item.id}"

      expect(response).to be_successful
      expect(Item.count).to eq(0)
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "with invalid data" do 
      item = create(:item)

    end
  end
end