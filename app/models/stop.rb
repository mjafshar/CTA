class Stop < ActiveRecord::Base
  has_and_belongs_to_many :routes

  def location=(coords)
    data = coords.scan(/-?\d+\.\d+/)
    self.latitude = data[0]
    self.longitude = data[1]
  end

  def routes=(routes)
    routes = '' if routes == nil
    routes = routes.scan(/\w+/).to_a
    routes.each do |route|
      self.routes << Route.create(route_number: route)
    end
  end
end
