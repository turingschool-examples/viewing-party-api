require "rails_helper"

RSpec.describe "Viewing Party", type: :request do
  it "can create a viewing party" do
    user1 = User.create!(name: "Danny DeVito", username: "danny_de_v", password: "jerseyMikesRox7")
    user2 = User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")
    user3 = User.create!(name: "Lionel Messi", username: "futbol_geek", password: "test123")

    viewing_party_params = {
      host_id: user2[:id],
      name: "Juliet's Bday Movie Bash!",
      start_time: "2025-02-01 10:00:00",
      end_time: "2025-02-01 14:30:00",
      movie_id: 278,
      movie_title: "The Shawshank Redemption",
      invitees: [user1[:id], user3[:id]] 
    } 


    post "/api/v1/viewing_parties", params: viewing_party_params, as: :json

    expect(response).to be_successful
    expect(response.status).to eq(201)

    results = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(results[:type]).to eq("viewing_party")
    expect(results[:attributes][:name]).to eq("Juliet's Bday Movie Bash!")
    # expect(results[:attributes][:start_time]).to eq("2025-02-01 10:00:00")
    # expect(results[:attributes][:end_time]).to eq("2025-02-01 14:30:00")
    expect(results[:attributes][:movie_id]).to eq(278)
    expect(results[:attributes][:movie_title]).to eq("The Shawshank Redemption")
    expect(results[:attributes][:invitees].count).to eq(2)
  end
end