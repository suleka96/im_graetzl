require "rails_helper"

RSpec.describe AddressesController, type: :routing do
  describe "routing" do

    it 'routes GET addresses/registration to #registration' do
      expect(get: 'addresses/registration').to route_to('addresses#registration')
    end

    it 'routes POST addresses/search to #search' do
      expect(post: 'addresses/search').to route_to('addresses#search')
    end

    it 'routes POST addresses/match to #match' do
      expect(post: 'addresses/match').to route_to('addresses#match')
    end
  end
end