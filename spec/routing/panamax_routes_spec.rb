require 'spec_helper'

describe 'panamax routes' do

  it 'routes GET to the panamax controller show action' do
    expect(get: '/panamax').to route_to(
                                controller: 'panamax',
                                action: 'show'
                            )
  end

end
