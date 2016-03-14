require 'rails_helper'

RSpec.describe DistrictsController, type: :routing do

  describe 'routes' do
    it 'routes GET /wien to #index' do
      expect(get: '/wien').to route_to('districts#index')
    end

    it 'routes GET /wien/district-slug to #show' do
      expect(get: '/wien/district-slug').to route_to('districts#show', id: 'district-slug')
    end

    it 'routes GET /wien/district-slug/graetzls to #graetzls' do
      expect(get: '/wien/district-slug/graetzls').to route_to('districts#graetzls', id: 'district-slug')
    end
  end
  describe 'named routes' do
    it 'routes GET districts_path to #index' do
      expect(get: districts_path).to route_to('districts#index')
    end

    it 'routes GET district_path to #show' do
      expect(get: district_path('district-slug')).to route_to('districts#show', id: 'district-slug')
    end
  end
end
