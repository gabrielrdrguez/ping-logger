$(document).ready(function() {
    $('#log').DataTable({});

    var seriesOptions = [],
        seriesCounter = 0,
        names = ['45.32.171.18', '107.191.103.239', '200.147.67.142'];

    /**
     * Create the chart when all data is loaded
     * @returns {undefined}
     */
    $.each(names, function (i, name) {
        $.getJSON(Routes.data_chart_ping_logs_path({format: 'json', ip: name}),    function (data) {

            seriesOptions[i] = {
                name: name,
                data: data
            };

            // As we're loading the data asynchronously, we don't know what order it will arrive. So
            // we keep a counter and create the chart when all the data is loaded.
            seriesCounter += 1;

            if (seriesCounter === names.length) {
                createChart();
            }
        });
    });

    $("#refresh").click(function(){
        seriesCounter = 0;
        $("#container").html("<i class='fa fa-spinner fa-spin fa-5x' style='display: flex; justify-content: center'></i>");
        $.each(names, function (i, name) {
            $.getJSON(Routes.data_chart_ping_logs_path({format: 'json', ip: name}),    function (data) {
                seriesOptions[i] = {
                    name: name,
                    data: data
                };
                // As we're loading the data asynchronously, we don't know what order it will arrive. So
                // we keep a counter and create the chart when all the data is loaded.
                seriesCounter += 1;

                if (seriesCounter === names.length) {
                    $("#container").html("");
                    createChart();
                }
            });
        });
    });

    function createChart() {

        Highcharts.stockChart('container', {

            rangeSelector: {
                buttons: [{
                    type: 'minute',
                    count: 1,
                    text: '1m'
                }, {
                    type: 'minute',
                    count: 3,
                    text: '3m'
                }, {
                    type: 'minute',
                    count: 10,
                    text: '10m'
                }, {
                    type: 'minute',
                    count: 30,
                    text: '30m'
                }, {
                    type: 'hour',
                    count: 1,
                    text: '1h'
                }, {
                    type: 'hour',
                    count: 6,
                    text: '6h'
                }, {
                    type: 'hour',
                    count: 12,
                    text: '12h'
                },{
                    type: 'day',
                    count: 1,
                    text: '10m'
                }, {
                    type: 'hour',
                    text: 'YTD'
                }, {
                    type: 'month',
                    count: 1,
                    text: '1M'
                }, {
                    type: 'all',
                    text: 'All'
                }],
                inputEnabled: true,
                selected: 0
            }
            ,

            yAxis: {
                labels: {
                    formatter: function () {
                        return (this.value > 0 ? ' + ' : '') + this.value;
                    }
                },
                min: 0,
                max: 300
            },

            plotOptions: {
                series: {
                    compare: null
                }
            },

            tooltip: {
                pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y} ms</b> ({point.change} ms)<br/>',
                changeDecimals: 2,
                valueDecimals: 2
            },

            series: seriesOptions
        });
    }

});
