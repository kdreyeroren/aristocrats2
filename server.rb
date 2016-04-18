require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'twilio-ruby'

def send_text(number)
  # put your own credentials here 
	account_sid = 'AC89ba97d70c09db4dbdadc687a65c6152' 
	auth_token = '7b961188fb43f66b4438036ee26054cd' 
 
# set up a client to talk to the Twilio REST API 
	@client = Twilio::REST::Client.new account_sid, auth_token 
 
	@client.account.messages.create({
		:to => number,
		:from => '+18575760930',  
		:body => 'The Aristocrats.',  
	})
end

get '/' do
	erb :index
end

post '/senttext' do
	"You have artistogrammed this number: #{params['phone_number']}!"
	phone_number = params['phone_number']
	good_phone_number = phone_number.gsub(/\D/,"")
	if good_phone_number.size != 10
		erb :index
	else
		send_text(phone_number)
		"Texting #{phone_number}..."
	end
end


