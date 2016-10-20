ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  attr_reader :first_name

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    erb :'links/welcome'
  end

  get '/register' do
    erb :'links/register'
  end

  post '/welcome' do
    #welcome new users
    user = User.create(first_name: params[:first_name],
                       last_name: params[:last_name],
                       email: params[:email],
                       password: params[:password])
    session[:user_id] = user.id
    @links = Link.all

     redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/create_link'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    tags = params[:tags].split(", ")
    tags.each do |tag|
      link.tags << Tag.create(name: tag)
      link.save
    end
    # @user = User.get(session[:user_id])
    redirect '/links'
  end

  get '/tags/:filter' do
    tag = Tag.first(name: params[:filter])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
