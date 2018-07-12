class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    #all this code is moved to GithubService authenticate function
    #response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    #access_hash = JSON.parse(response.body)
    github = GithubService.new #instantiate a new GithubService object/instance
    #session[:token] = access_hash["access_token"]
    session[:token] = github.authenticate!(ENV['GITHUB_CLIENT'], ENV['GITHUB_SECRET'], params[:code])
    #github.initialize(access_hash)

    #user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    #user_json = JSON.parse(user_response.body)
    #session[:username] = user_json["login"]
    session[:username] = github.get_username
    redirect_to '/'
  end
end
