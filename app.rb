#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'pony'

set :database, "sqlite3:leprosorium.db"

class Post < ActiveRecord::Base
	validates :date, presence: true
end

class User < ActiveRecord::Base
	validates :username, presence: true, length: {minimum: 3} #функция с параметром1 и параметром2 (хэш):  http://guides.rubyonrails.org/active_record_validations.html
	validates :email, presence: true 
	validates :date, presence: true
end

class Comment < ActiveRecord::Base
	validates :date, presence: true
end

before do
	@posts = Post.order 'created_at'
end

get '/' do
	@posts = Post.new 
  erb :index
end

get '/new' do
	@users = User.new params[:name]
  erb :new
end

# post '/new' do
# 	@users = User.new params[:name]
# 	@posts = Post.new params[:content]

# 	if @posts.save && @users.save # .save принимает значение false если пустой
# 		erb "<h2>Спасибо! Мир Вас не забудет!</h2>"
# 	else
# 		@error = @posts.errors.full_messages.first # http://guides.rubyonrails.org/active_record_validations.html
# 		erb :index
# 	end
# end