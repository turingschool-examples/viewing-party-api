require "rails_helper"

RSpec.describe ViewingParty, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:movie_id) }
    it { should validate_presence_of(:movie_title) }
    it { should validate_presence_of(:host_id) }
  end

  describe "associations" do
    it { should belong_to(:host).class_name('User') }
    it { should have_many(:users_viewing_parties) }
    it { should have_many(:users).through(:users_viewing_parties) }
  end

  describe "#add_user_invitees" do
    it "can add invitees to the viewing party" do
      host = User.create!(name: "Danny DeVito", username: "danny_de_v", password: "jerseyMikesRox7")
      user2 = User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")
      user3 = User.create!(name: "Lionel Messi", username: "futbol_geek", password: "test123")
  
      viewing_party = ViewingParty.create!(host_id: host[:id], name: "Movie Night", start_time: "2025-02-01 18:00:00", end_time: "2025-02-01 20:00:00", movie_id: 101, movie_title: "Inception")
    
      expect(viewing_party.users).to be_empty

      viewing_party.add_user_invitees([user2, user3])

      expect(viewing_party.users).to eq([user2, user3])
      expect(viewing_party.users.count).to eq(2)
    end
  end

  describe "#end_time_before_start_time"
    it " returns error if end_time is before start time" do
      host = User.create!(name: "Danny DeVito", username: "danny_de_v", password: "jerseyMikesRox7")

      viewing_party = ViewingParty.create(host_id: host[:id], name: "Movie Night", start_time: "2025-02-01 20:00:00", end_time: "2025-02-01 18:00:00", movie_id: 101, movie_title: "Inception")

      expect(viewing_party.errors[:end_time]).to match_array("must come after start time")
    end
end