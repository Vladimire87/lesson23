#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Best Barber shop app.rb"	
end

get "/about" do
	erb :about
end

get "/appointment" do
	erb :appointment
end

get "/contacts" do
	erb :contacts
end

post "/appointment" do
	@username = params[:username]
	@tel = params[:tel]
	@date = params[:date]
	@barber = params[:barber]

	f = File.open "./public/users.txt", "a"
	f.write "Username: #{@username}, Phone: #{@tel}, Date: #{@date}, Barber: #{@barber}\n"
	f.close
	erb "Спасибо за запись"
end

post "/contacts" do
	@email = params[:email]
	@message = params[:message]
	f = File.open "./public/contacts.txt", "a"
	f.write "Email: #{@email}, Мessage: #{@message}\n"
	f.close
	erb "Ваше сообщение отправленно!"
end