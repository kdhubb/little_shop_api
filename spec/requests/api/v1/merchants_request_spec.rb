require "rails_helper" 

RSpec.describe "Merchants API", type: :request do 
  describe "it sends a list of all merchants" do 
    before(:each) do 
      get "/api/v1/merchants" 
      @merchants = JSON.parse(response.body, symbolize_names: true)
      @merchants_response = File.read("./spec/fixtures/merchants_all.json")
      @merchants_parsed = JSON.parse(@merchants_response, symbolize_names: true)
    end

    it "has a successful request" do
      expect(response.status).to eq(200)
      expect(response.body).to eq('{"data":[]}')
    end

    it "has serialized content" do 
      expected = {
        id: "1",
        type: "merchant",
        attributes: {
          name: "Schroeder-Jerde"
        }
      }
      expect(@merchants_parsed[:data].first).to eq(expected)
    end
  end
end