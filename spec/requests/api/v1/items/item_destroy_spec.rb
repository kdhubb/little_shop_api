require "rails_helper" 

RSpec.describe "Destroy Item Request", type: :request do 
  describe "destroy an item" do 
    it "destroys an item given the id" do 
      item = create(:item)
      
      expect(Item.count).to eq(1)

      delete "/api/v1/items/#{item.id}"
      
      expect(response).to be_successful
      expect(Item.count).to eq(0)
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end