class MovieGateway
  def self.get_top_rated
   response = connection.get("/3/movie/top_rated")
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def self.get_searched_movies(search)
    response = connection.get("/3/search/movie", {query: search})
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  private 

  def self.connection 
    Faraday.new(url: "https://api.themoviedb.org" ) do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.tmdb[:key]
    end
  end
end