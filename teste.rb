require 'rest-client'

response = RestClient.get 'https://dry-waters-79640.herokuapp.com/hotels/2', {accept: :json}
puts response
