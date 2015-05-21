class AnnexesController < ApplicationController
  skip_before_action :require_login

  def about
  end

  def documentation
  end

  def contact
    @contacts = {}
    @contacts[0] = {name: 'Alexander Taborda', username: 'x2l3x2nd3rx', celphone: '3004348412', image: 'http://i62.tinypic.com/314tu6t.jpg'}
    @contacts[1] = {name: 'Fabian Betancur', username: 'faanbece',celphone: '3007249114', image: 'http://i60.tinypic.com/21nh9ih.jpg'}
    @contacts[2] = {name: 'Daniel Blanco', username: 'dbaines48',celphone: '3003392676', image: 'http://i62.tinypic.com/5y6fdi.jpg'} 
  end
end
