#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'

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
	email = params[:email]
	message = params[:message]

	hh = { 
		:email => "Введите Имейл",
		:message => "Введите Сообщение"
	}

	errors_show hh

	if @error != ""
		return erb :contacts
	end
	
	Pony.options = {
		via: :smtp,
		via_options: {
			address: 'smtp.gmail.com',
			port: '587',
			enable_starttls_auto: true,
			user_name: '',
			password: '',
			authentication: :plain,
			domain: 'localhost:4567'
		}
	}

	Pony.mail(
		:to => '', 
		:from => email,
		:reply_to => email,
		:sender => email,
		:subject => 'Test Mail', 
		:body => message,
	)

 erb "Email sent successfully!" 
end

def errors_show hash
	@error = hash.select { |key, _| params[key] == ""}.values.join(", ")
end