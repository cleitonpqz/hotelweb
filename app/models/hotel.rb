require 'rest-client'
class Hotel
  include ActiveModel::Model

  attr_accessor :name, :address, :accommodation_type, :star_rating
  attr_accessor :base_path_api

  def initialize(attributes={})
    super
    @base_path_api ||= RestClient::Resource.new('https://dry-waters-79640.herokuapp.com', read_timeout: 30)
  end

  def search(q)
    base_path_api['/hotels/search'].get params: { q: q }, accept: :json
  end

  def getAll
    base_path_api['/hotels'].get accept: :json
  end

  def createOnApi(params)
    base_path_api['/hotels'].post params, accept: :json
  end

  def findById(id)
    _hotel = base_path_api['/hotels/'+id].get accept: :json
    _found_hotel = Hotel.new(name: _hotel.name, address: _hotel.address, accommodation_type: _hotel.accommodation_type, star_rating: _hotel.star_rating)
    _found_hotel
  end
end
