$(document).ready(function() {
    $('#log').DataTable({});



    $.getJSON(Routes.data_chart_ping_logs_path({format: 'json'}), function (data) {
        // Create the chart
        Highcharts.stockChart('container', {


            rangeSelector: {
                selected: 1
            },

            title: {
                text: 'ping'
            },

            series: [{
                name: 'Oing',
                data: data,
                tooltip: {
                    valueDecimals: 0
                }
            }]
        });
    });

});