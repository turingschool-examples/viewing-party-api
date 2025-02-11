require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
    it { should have_secure_token(:api_key) }
  end

  describe "associations" do
    it { should have_many(:users_viewing_parties) }
    it { should have_many(:viewing_parties).through(:users_viewing_parties) }
  end

  describe "#find_user_id" do
    it "can find users whose IDs match those in the invitees array" do
      user2 = User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")
      user3 = User.create!(name: "Lionel Messi", username: "futbol_geek", password: "test123")

      invitees = [user2[:id], user3[:id]]
      result = User.find_user_id(invitees)

      expect(result).to match_array([user2, user3])
    end
  end
end