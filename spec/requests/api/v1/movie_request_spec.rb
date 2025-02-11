require "rails_helper"

RSpec.describe "Movies API", type: :request do
  it "can retrieve top-rated movies " do

    json_response = File.read("spec/fixtures/top_rated.json")

    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'Authorization'=>"#{Rails.application.credentials.tmdb[:key]}",
      }).
    to_return(status: 200, body: json_response, headers: {})

    get "/api/v1/movies/top_rated"
    
    expect(response).to be_successful

    results = JSON.parse(response.body, symbolize_names: true)[:data]
    
    results.each do |movie|
      expect(movie[:id].to_i).to be_a(Integer)
      expect(movie[:type]).to be_a(String)
      expect(movie[:attributes]).to have_key(:title)
      expect(movie[:attributes]).to have_key(:vote_average)
    end
  end

  it "retrieve movies from The Movie DB API based on a search query from the request" do
    
    json_response = File.read("spec/fixtures/movie_search.json")

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?query=Lord%20of%20the%20Rings").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>"#{Rails.application.credentials.tmdb[:key]}",
          'User-Agent'=>'Faraday v2.10.1'
           }).
         to_return(status: 200, body: json_response, headers: {})

    get "/api/v1/movies?search=Lord of the Rings" 
    

    expect(response).to be_successful

    results = JSON.parse(response.body, symbolize_names: true)[:data]

    results.each do |movie|
      expect(movie[:id].to_i).to be_a(Integer)
      expect(movie[:type]).to be_a(String)
      expect(movie[:attributes]).to have_key(:title)
      expect(movie[:attributes]).to have_key(:vote_average)
    end
  end
end