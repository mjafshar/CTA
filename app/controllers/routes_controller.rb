class RoutesController < ApplicationController
  def index
    @routes = Route.all.sort { |a, b| a.route_number.scan(/\d+/).first.to_i <=> b.route_number.scan(/\d+/).first.to_i }
  end

  def show
    @route = Route.find(params[:id])
    page_num = params[:page]
    stops = @route.stops
    @stops = stops.page(page_num)
    @stop_pages = stops.paginate(:page => page_num)
  end
end
