class RoutesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @routes = Route.all

    if params[:sort] == 'Stops'
      routes = @routes.joins(:stops).group("routes.id").order("COUNT(#{sort_column}) #{sort_direction}")
    else
      routes = @routes.order("#{sort_column} #{sort_direction}")
    end

    page_num = params[:page]
    @routes = routes.page(page_num)
    @route_pages = routes.paginate(:page => page_num)
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
    table_columns = Route.column_names.to_a
    columns = table_columns + ['Stops']
    columns.include?(params[:sort]) ? params[:sort] : table_columns.first
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
