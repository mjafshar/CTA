class RoutesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @routes = Route.all.sort { |a, b| a.route_number.scan(/\d+/).first.to_i <=> b.route_number.scan(/\d+/).first.to_i }
  end

  def show
    @route = Route.find(params[:id])

    if params[:sort] == 'Routes'
      stops = @route.stops.joins(:routes).group("stops.id").order("COUNT(#{sort_column}) #{sort_direction}")
    else
      stops = @route.stops.order("#{sort_column} #{sort_direction}")
    end

    page_num = params[:page]
    @stops = stops.page(page_num)
    @stop_pages = stops.paginate(:page => page_num)
  end

  private

  def sort_column
    columns = Stop.column_names.to_a + ['Routes']
    columns.include?(params[:sort]) ? params[:sort] : "stop_id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
