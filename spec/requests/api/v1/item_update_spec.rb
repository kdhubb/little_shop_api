require "rails_helper" 

RSpec.describe "Item Update", type: :request do 
  describe "it can update an item" do 
    it "with valid information" do 
      item = create(:item)
      previous_name = item.name
      previous_description = item.description
      previous_unit_price = item.unit_price

      update_data = {
          "name": "Dogpack",
          "description": "Backpack for your dog to carry their own stuff.",
          "unit_price": 15.00,
          "merchant_id": "#{item.merchant.id}"
        }

      patch "/api/v1/items/#{item.id}", params: update_data
      updated_item = Item.find(item.id)

      expect(response.code).to eq("200")
      expect(updated_item.name).to_not eq(previous_name)
      expect(updated_item.description).to_not eq(previous_description)
      expect(updated_item.unit_price).to_not eq(previous_unit_price)
    end

    it "with missing Merchant id" do 

    end

    it "fails to update with invalid merchant id" do 

    end
  end
end

{"name"=>"Shiny Itemy Item, New and Improved", 
  "description"=>"It does a lot of things even more good than before!", 
  "unit_price"=>65.23, 
  "merchant_id"=>56, 
  "controller"=>"api/v1/items", 
  "action"=>"update", 
  "id"=>"179", 
  "item"=>{
    "name"=>"Shiny Itemy Item, New and Improved", 
    "description"=>"It does a lot of things even more good than before!", 
    "unit_price"=>65.23, 
    "merchant_id"=>56}}