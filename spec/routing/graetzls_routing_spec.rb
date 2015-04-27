require "rails_helper"

RSpec.describe GraetzlsController, type: :routing do
  describe 'routing' do

    it 'routes /graetzls to #index' do
      expect(get: '/graetzls').to route_to('graetzls#index')
    end

    it 'does not route / to #index' do
      expect(get: '/').not_to route_to('graetzls#index')
    end

    it 'routes /:graetzl_id to #show' do
      expect(get: '/1').to route_to('graetzls#show', id: '1')
    end

    it 'routes /graetzl_short_name to #show' do
      expect(get: '/graetzl_short_name').to route_to('graetzls#show', id: 'graetzl_short_name')
    end
  end


  describe 'named routing' do

    it 'routes to #index' do
      expect(get: graetzls_path).to route_to('graetzls#index')
    end

    it 'routes to #show' do
      expect(get: graetzl_path('graetzl_short_name')).to route_to('graetzls#show', id: 'graetzl_short_name')
    end

    it 'routes to #show (with numeric id)' do
      expect(get: graetzl_path(1)).to route_to('graetzls#show', id: '1')
    end
  end
end