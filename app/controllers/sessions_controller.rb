class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    req = GithubService.new
    
    req.authenticate!(ENV['GITHUB_CLIENT'], ENV['GITHUB_SECRET'], params[:code])
    
    session[:token] = req.access_token
    
    session[:username] = req.get_username

    redirect_to '/'
  end
end