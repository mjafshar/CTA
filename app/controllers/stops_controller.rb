class StopsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @stops = Stop.all

    if params[:sort] == 'Routes'
      stops = @stops.joins(:routes).group("stops.id").order("COUNT(#{sort_column}) #{sort_direction}")
    else
      stops = @stops.order("#{sort_column} #{sort_direction}")
    end

    page_num = params[:page]
    @stops = stops.page(page_num)
    @stop_pages = stops.paginate(:page => page_num)
  end

  def show
    @stop = Stop.find(params[:id])

    @chart = LazyHighCharts::HighChart.new('bar') do |f|
      f.title(:text => "Alightings and Boardings")
      f.xAxis(:categories => ['Alightings', 'Boardings'])
      f.series(:showInLegend => false, :yAxis => 0, :data => [@stop.alightings, @stop.boardings], :color => '#2e6ab1')

      f.yAxis [
        {:title => {:text => "Passengers"} },
      ]

      f.chart({:defaultSeriesType => "bar", :height => 200})
    end
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
