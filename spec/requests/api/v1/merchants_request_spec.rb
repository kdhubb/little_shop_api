require "rails_helper" 

RSpec.describe "Merchants API" do 
  it "sends a list of all merchants" do
    get "/api/v1/merchants" 

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merchants["data"].count).to eq(3)
    expect(merchants).to include(:data)
  end
end