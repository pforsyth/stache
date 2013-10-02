require 'sinatra'
require 'mogreet'
require 'nokogiri'

post '/incoming-messages' do
  xml = Nokogiri::XML(request.body.read)
  mobile_number = xml.at('msisdn').text
  image_url     = xml.at('images/image').text
  # set up config vars, or just put your client/token/mms campaign id below
  client = Mogreet::Client.new(ENV['MOGREET_CLIENT_ID'], ENV['MOGREET_CLIENT_TOKEN'])
  client.transaction.send(
    :to          => mobile_number,
    :campaign_id => ENV['MOGREET_MMS_CAMPAIGN_ID'],
    :message     => "Nice mustache!!!",
    :content_url => "http://mustachify.me/?src=#{image_url}"
  )
  'ok'
end