$(function () {
    $('#orders_chart').highcharts({
        chart: {
            height: 200,
            type: 'bar'
        },
        title: {
            text: 'Alightings and Boardings'
        },
        tooltip: {
            enabled: false
        },
        legend: {
            enabled: false
        },
        xAxis: {
            categories: ['Alightings', 'Boardings']
        },
        yAxis: {
            title: {
                text: 'Passengers'
            }
        },
        plotOptions: {
            bar: {
                color: '#2e6ab1',
                dataLabels: {
                    enabled: true
                }
            }
        },
        series: [{
            data: $('#orders_chart').data('info')
        }]
    });
});
