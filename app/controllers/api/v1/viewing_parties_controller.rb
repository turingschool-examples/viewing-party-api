class Api::V1::ViewingPartiesController < ApplicationController
  def create 
    viewing_party = ViewingParty.create!(viewing_party_params)
    users_invitees = User.find_user_id(params[:invitees])
    viewing_party.add_user_invitees(users_invitees)
    render json: ViewingPartySerializer.format_party(viewing_party), status: :created
  end
  
  private 
  
  def viewing_party_params
    params.permit(:name, :start_time, :end_time, :movie_id, :movie_title, :host_id)
  end
end