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
	@color = params[:color]

	hh = { 
		:username => "Введите Имя",
		:tel => "Введите Телефон",
		:date => "Введите Дату",
		:barber => "Выберите Барбера",
		:color => "Выберите цвет "
	}
	
	errors_show hh

	if @error != ""
		return erb :appointment
	end

	f = File.open "./public/users.txt", "a"
	f.write "Username: #{@username}, Phone: #{@tel}, Date: #{@date}, Barber: #{@barber}, Color: #{@color}\n"
	f.close
	erb "Спасибо за запись!\nUsername: #{@username}, Phone: #{@tel}, Date: #{@date}, Barber: #{@barber}, Color: #{@color}"
end

post "/contacts" do
	@email = params[:email]
	@message = params[:message]

	hh = { 
		:email => "Введите Имейл",
		:message => "Введите Сообщение"
	}
	
	errors_show hh

	if @error != ""
		return erb :contacts
	end

	f = File.open "./public/contacts.txt", "a"
	f.write "Email: #{@email}, Мessage: #{@message}\n"
	f.close
	erb "Ваше сообщение отправленно!"
end

def errors_show hash
	@error = hash.select { |key, _| params[key] == ""}.values.join(", ")
end