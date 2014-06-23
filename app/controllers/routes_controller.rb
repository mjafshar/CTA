class RoutesController < ApplicationController
  def index
    @routes = Route.all.sort { |a, b| a.route_number.scan(/\d+/).first.to_i <=> b.route_number.scan(/\d+/).first.to_i }
  end
end
