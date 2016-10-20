ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  get '/' do
    erb :'links/welcome'
  end

  get '/register' do
    erb :'links/register'
  end

  post '/welcome' do
    user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
    @links = Link.all
    @name = params[:first_name]
    erb :'links/index'
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
    redirect '/links'
  end

  get '/tags/:filter' do
    tag = Tag.first(name: params[:filter])
    @links = tag ? tag.links : []
    erb :'links/index'
  end
  #
  # get '/tags/:filter' do
  #   tag = Tag.first(name: params[:filter])
  #   @links = tag ? tag.links : []
  #   erb :'links/index'
  # end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
