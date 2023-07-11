require "rails_helper" 

RSpec.describe "Merchants API", type: :request do 
  describe "it sends a list of all merchants" do 
    before(:each) do 
      get "/api/v1/merchants" 
      @merchants = JSON.parse(response.body, symbolize_names: true)
    end

    it "has a successful request" do
      expect(response.status).to eq(200)
      expect(response.body).to eq('{"data":[]}')
    end

    it "has keys" do 
      expect(@merchants[:data].first).to eq("x")
    end
  end
end