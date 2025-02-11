class Api::V1::MoviesController < ApplicationController
  def index
    if params[:search]
      movies = MovieGateway.get_searched_movies(params[:search])
    else
      movies = MovieGateway.get_top_rated
    end
    render json: MovieSerializer.format_movie_list(movies)
  end
end