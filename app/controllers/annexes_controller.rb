class AnnexesController < ApplicationController
  skip_before_action :require_login

  def about
  end

  def documentation
  end

  def contact
    @contacts = {}
    @contacts[0] = {name: 'Alexander Taborda', username: 'x2l3x2nd3rx', celphone: '3004348412', image: 'http://i62.tinypic.com/314tu6t.jpg'}
    @contacts[1] = {name: 'Fabian Betancur', username: 'dbaines48',celphone: '3007249114', image: 'http://i60.tinypic.com/21nh9ih.jpg'}
    @contacts[2] = {name: 'Daniel Blanco', username: 'faanbece',celphone: '3003392676', image: 'http://i59.tinypic.com/2ui9h1k.jpg'} 
  end
end
