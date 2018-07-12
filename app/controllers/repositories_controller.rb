class RepositoriesController < ApplicationController
  def index
    #response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    #@repos_array = JSON.parse(response.body)
    access_hash = {"access_token" => session[:token]}
    github = GithubService.new(access_hash)
    @repos_array = github.get_repos #returns an array of ruby objects

  end

  def create
    #response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    access_hash = {"access_token" => session[:token]}
    github = GithubService.new(access_hash)
    github.create_repo(params[:name])
    redirect_to '/'
  end
end
