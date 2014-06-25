class RoutesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    all_routes = Route.all
    chart_data = {stops: [], route: []}

    if params[:sort] == 'Stops'
      sorted_routes = all_routes.joins(:stops).group("routes.id").order("COUNT(Stops) #{sort_direction}")
      sorted_routes.each { |route| chart_data[:stops] << route.stops.count; chart_data[:route] << "Route #{route.route_number}" }
    else
      sorted_routes = sort_routes(sort_direction)
      sorted_routes.each { |route| chart_data[:stops] << route.stops.count; chart_data[:route] << "Route #{route.route_number}" }
    end


    @chart = LazyHighCharts::HighChart.new('bar') do |f|
      f.title(:text => "Stops Per Route")
      f.xAxis(:categories => chart_data[:route])
      f.series(:showInLegend => false, :name => "Number of Stops", :yAxis => 0, :data => chart_data[:stops], :color => '#2e6ab1')

      f.yAxis [
        {:title => {:text => "Number of Stops"} },
        {:title => {:text => "Number of Stops"}, :opposite => true},
      ]

      f.chart({:defaultSeriesType => "bar", :height => 4000})
    end
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
    stop_columns = Stop.column_names.to_a
    columns = stop_columns + ['Stops', 'Routes', 'route_number']
    columns.include?(params[:sort]) ? params[:sort] : 'first'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_routes(direction)
    if direction == 'asc'
      routes = Route.all.sort { |a, b| a.route_number.scan(/\d+/).first.to_i <=> b.route_number.scan(/\d+/).first.to_i }
    else
      routes = Route.all.sort { |a, b| b.route_number.scan(/\d+/).first.to_i <=> a.route_number.scan(/\d+/).first.to_i }
    end
    routes
  end
end
