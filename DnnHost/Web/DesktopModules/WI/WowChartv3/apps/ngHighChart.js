WowChartv3_ngHighChart.$inject = ['$filter', 'ModuleInfo'];
function WowChartv3_ngHighChart($filter, ModuleInfo) {
    return {
        restrict: "A",
        transclude: true,
        scope: {
            settings: '=chartSettings'
        },
        link: function (scope, element, attrs) {
            var $element = $(element), settings, data, additionalDataProps, additionalData, defaultSeries;
            var unregSettings;

            function onSettingsChanged(newValue, oldValue) {
                settings = newValue;
                data = settings.Data;
                additionalDataProps = settings.AdditionalDataProps;
                additionalData = settings.AdditionalData;

                unregSettings();
                buildChart();
            }
            function getQueryString(field, url) {
                var href = url ? url : window.location.href;
                var reg = new RegExp('[?&]' + field + '=([^&#]*)', 'i');
                var string = reg.exec(href);
                return string ? string[1] : null;
            }
            function cachedScript(url, callback) {
                return $.ajax({
                    type: "GET",
                    url: url,
                    success: callback,
                    dataType: "script",
                    cache: true
                });
            };
            function highCharts(hcOptions) {

                if (hcOptions.exporting.enabled == true
                    && hcOptions.exporting.externalServer == false)
                    hcOptions.exporting.url = 'WowChartsv3Export.axd';

                if (hcOptions.exporting.enabled && angular.isUndefinedOrNull(window.ExportingJsUrl)) {
                    cachedScript(ModuleInfo.ExportingJsUrl, function () {
                        window.ExportingJsUrl = 0;
                        highCharts(hcOptions);
                    });
                } else if (hcOptions.exporting.enabled && angular.isUndefinedOrNull(window.OfflineExportingJsUrl)) {
                    cachedScript(ModuleInfo.OfflineExportingJsUrl, function () {
                        window.OfflineExportingJsUrl = 0;
                        highCharts(hcOptions);
                    });
                } else if (hcOptions.exporting.enabled &&
                    (hcOptions.exporting.downloadCSV == true ||
                        hcOptions.exporting.downloadXLS == true ||
                        hcOptions.exporting.viewData == true) &&
                    angular.isUndefinedOrNull(window.ExportCSVJsUrl)) {
                    cachedScript(ModuleInfo.ExportCSVJsUrl, function () {
                        window.ExportCSVJsUrl = 0;
                        highCharts(hcOptions);
                    });
                } else if (hcOptions.chart.options3d.enabled && angular.isUndefinedOrNull(window.Highcharts3dJsUrl)) {
                    cachedScript(ModuleInfo.Highcharts3dJsUrl, function () {
                        window.Highcharts3dJsUrl = 0;
                        highCharts(hcOptions);
                    });
                } else if (hcOptions.chart.type == 'wordcloud' && angular.isUndefinedOrNull(window.HighchartsWordcloudModuleUrl)) {
                    cachedScript(ModuleInfo.HighchartsWordcloudModuleUrl, function () {
                        window.HighchartsWordcloudModuleUrl = 0;
                        highCharts(hcOptions);
                    });
                    /*} else if (angular.isUndefinedOrNull(window.HighchartsParetoModuleUrl)) {
                        cachedScript(ModuleInfo.HighchartsParetoModuleUrl, function () {
                            window.HighchartsParetoModuleUrl = 0;
                            highCharts(hcOptions);
                        });*/
                } else {
                    if (hcOptions.exporting.enabled) {
                        var buttons = Highcharts.getOptions().exporting.buttons;

                        if (hcOptions.exporting.downloadCSV == true) {
                            var result = $filter('filter')(buttons.contextButton.menuItems, { 'textKey': 'downloadCSV' });
                            if (result.length == 0) {
                                buttons.contextButton.menuItems.push({
                                    textKey: 'downloadCSV',
                                    onclick: function () { this.downloadCSV(); }
                                });
                            }
                        }

                        if (hcOptions.exporting.downloadXLS == true) {
                            var result = $filter('filter')(buttons.contextButton.menuItems, { 'textKey': 'downloadXLS' });
                            if (result.length == 0) {
                                buttons.contextButton.menuItems.push({
                                    textKey: 'downloadXLS',
                                    onclick: function () { this.downloadXLS(); }
                                });
                            }
                        }

                        if (hcOptions.exporting.viewData == true) {
                            var result = $filter('filter')(buttons.contextButton.menuItems, { 'textKey': 'viewData' });
                            if (result.length == 0) {
                                buttons.contextButton.menuItems.push({
                                    textKey: 'viewData',
                                    onclick: function () { this.viewData(); }
                                });
                            }
                        }

                        hcOptions.exporting.buttons = buttons;
                    }

                    hcOptions.chart.events.render = function () {
                        var svgSeries = this.container.getElementsByClassName('highcharts-series');
                        if (defaultSeries.fillOpacity < 1) {
                            for (var idx = 0; idx < svgSeries.length; idx++) {
                                svgSeries[idx].setAttribute('fill-opacity', defaultSeries.fillOpacity)
                            }
                        } else {
                            var svgSeriesList = this.container.getElementsByClassName('highcharts-series');
                            for (var idx = 0; idx < this.series.length && idx < svgSeriesList.length; idx++) {
                                var seriesItem = this.series[idx];
                                var svgSeries = svgSeriesList[idx];
                                var svgSeriesPoints = svgSeries.getElementsByClassName('highcharts-point');
                                if (svgSeriesPoints.length == 0)
                                    break;

                                for (var dataIdx = seriesItem.data.length - 1; dataIdx >= 0; dataIdx--) {
                                    var data = seriesItem.data[dataIdx];
                                    if (angular.isUndefinedOrNull(data.opacity) == false) {
                                        if (data.opacity == 0 || data.opacity == '0') {
                                            $(svgSeriesPoints[dataIdx]).remove();
                                        } else {
                                            svgSeriesPoints[dataIdx].setAttribute('fill-opacity', data.opacity);
                                        }
                                    }
                                }
                            }
                        }

                        if (this.series.length > 0) {
                            var yAdditionalBand = this.options.yAxis[0].additionalBand;

                            if (angular.isUndefinedOrNull(yAdditionalBand) == false
                                && angular.isUndefinedOrNull(yAdditionalBand.min) == false) {

                                var getMinY = function (data) {
                                    if (data.length > 0) {
                                        var min = data[0].y;
                                        for (var idx = 1; idx < data.length; idx++) {
                                            min = Math.min(min, data[idx].y);
                                        }
                                        return min;
                                    }
                                }

                                var minY = null;
                                var $container = $(this.container);

                                for (var i = 0; i < this.series.length; i++) {
                                    var ser = this.series[i];
                                    if (ser.options._remove == true) {
                                        $container.find('svg .highcharts-series-group .highcharts-series-' + i).remove();
                                    } else {
                                        minY = minY != null ? Math.min(minY, getMinY(ser.data)) : getMinY(ser.data);
                                    }
                                }

                                if (minY >= yAdditionalBand.min) {
                                    var yAxis = this.yAxis[0];
                                    yAxis.addPlotBand({
                                        from: yAxis.dataMax,
                                        to: yAxis.dataMax + yAdditionalBand.thick,
                                        color: yAdditionalBand.color
                                    });
                                }
                            } else {
                                var $container = $(this.container);
                                for (var i = 0; i < this.series.length; i++) {
                                    var ser = this.series[i];
                                    if (ser.options._remove == true) {
                                        $container.find('svg .highcharts-series-group .highcharts-series-' + i).remove();
                                    }
                                }
                            }
                        }
                    };

                    Highcharts.setOptions({
                        lang: hcOptions.lang
                    });

                    if (angular.isUndefinedOrNull(hcOptions.plotOptions.series.point))
                        hcOptions.plotOptions.series.point = { events: {} };

                    if (angular.isUndefinedOrNull(ModuleInfo.EditMode)) {
                        var driveTablesEnabled = false, driveChartsEnabled = false;

                        if (!angular.isUndefinedOrNull(hcOptions.dataTableIntegration)
                            && hcOptions.dataTableIntegration.enableDriveTables == true
                            && hcOptions.dataTableIntegration.tables.length > 0)
                            driveTablesEnabled = true;

                        if (!angular.isUndefinedOrNull(hcOptions.driveCharts)
                            && hcOptions.driveCharts.enabled == true
                            && hcOptions.driveCharts.charts.length > 0)
                            driveChartsEnabled = true;

                        if (driveTablesEnabled == true || driveChartsEnabled == true) {
                            hcOptions.plotOptions.series.allowPointSelect = true;

                            function onSelectedPointChange(pt) {
                                var point;

                                if (!angular.isUndefinedOrNull(pt)) {
                                    point = {
                                        x: pt.options.name,
                                        y: pt.y,
                                        series: pt.series.name
                                    };
                                } else {
                                    point = null;
                                }

                                if (driveTablesEnabled == true) {
                                    angular.forEach(hcOptions.dataTableIntegration.tables, function (value) {
                                        var $dtModule = $("#module-" + value);
                                        if ($dtModule.length == 1) {
                                            var scope = angular.element($dtModule).scope();
                                            scope.ctrl.loadTable(null, point, null);
                                        } else {
                                            console.error('Data Table Module ' + value + ' is missing');
                                        }
                                    });
                                }

                                if (driveChartsEnabled == true) {
                                    angular.forEach(hcOptions.driveCharts.charts, function (value) {
                                        var $dtModule = $("#module-" + value);
                                        if ($dtModule.length == 1) {
                                            var scope = angular.element($dtModule).scope();
                                            scope.ctrl.loadChart(null, point, null);
                                        } else {
                                            console.error('Chart Module ' + value + ' is missing');
                                        }
                                    });
                                }
                            }

                            hcOptions.plotOptions.series.point.events.select = function () {
                                onSelectedPointChange(this);
                            };
                            hcOptions.plotOptions.series.point.events.unselect = function (e) {
                                if (e.target.state == "select")
                                    onSelectedPointChange(null);
                            };
                        }
                    }

                    if (hcOptions.title.x == 0) delete hcOptions.title.x;
                    if (hcOptions.title.y == 0) delete hcOptions.title.y;
                    if (hcOptions.subtitle.x == 0) delete hcOptions.subtitle.x;
                    if (hcOptions.subtitle.y == 0) delete hcOptions.subtitle.y;

                    hcOptions.plotOptions.series.turboThreshold = 0;

                    var renderImage = false;
                    if (ModuleInfo.PreviewMode) {
                        renderImage = hcOptions.mics.previewAsImage == true
                            && angular.isUndefinedOrNull(ModuleInfo.FrameId) == false;

                        if (renderImage == false) {
                            renderImage = getQueryString('asImage') == '1';
                        }
                    }

                    if (renderImage == true) {
                        hcOptions.exporting.enabled = true;
                    }

                    var chart = $element.highcharts(hcOptions).highcharts();

                    if (hcOptions.xAxis.type == 'category') {
                        var xAxis = chart.xAxis[0];
                        var xTickPositions = xAxis.tickPositions;
                        var lastXPos = xTickPositions[xTickPositions.length - 1];
                        if (hcOptions.series[0].data) {
                            var dataLength = hcOptions.series[0].data.length;
                            if (lastXPos != (dataLength - 1)) {
                                xTickPositions[xTickPositions.length - 1] = dataLength - 1;
                                hcOptions.xAxis.tickPositions = xTickPositions;
                                chart = $element.highcharts(hcOptions).highcharts();
                            }
                        }
                    }

                    var firstYAxis = hcOptions.yAxis[0];
                    if (firstYAxis._plotBands.length > 0) {
                        var yAxis = chart.yAxis[0];
                        var tickPositions = yAxis.tickPositions;
                        if (tickPositions) {
                            var from = tickPositions[0];
                            var tick = tickPositions[1] - tickPositions[0];
                            for (var idx = 0; idx < hcOptions.yAxis[0]._plotBands.length; idx++) {
                                yAxis.addPlotBand({
                                    from: from,
                                    to: from + tick,
                                    color: hcOptions.yAxis[0]._plotBands[idx].color
                                });
                                from += tick
                            }
                        }
                    }

                    if (hcOptions.xAxis._plotBands.length > 0) {
                        var isPolar = hcOptions.chart.polar;
                        var xAxis = chart.xAxis[0];
                        var tickPositions = xAxis.tickPositions;
                        if (tickPositions) {
                            var from = tickPositions[0];
                            var tick = tickPositions[1] - tickPositions[0];
                            for (var idx = 0; idx < hcOptions.xAxis._plotBands.length; idx++) {
                                xAxis.addPlotBand({
                                    from: from - (!isPolar ? 0.5 : 0),
                                    to: from + tick - (!isPolar ? 0.5 : 0),
                                    color: hcOptions.xAxis._plotBands[idx].color
                                });
                                from += tick;
                            }
                        }
                    }

                    var id = $element[0].firstChild.id;
                    window[id] = {};

                    if (renderImage == true) {
                        var sourceWidth, sourceHeight;
                        if (angular.isUndefinedOrNull(settings.Options.style.width) == false) {
                            sourceWidth = settings.Options.style.width.match(/\d+/)[0];
                        } else {
                            sourceWidth = chart.chartWidth;
                        }

                        if (angular.isUndefinedOrNull(settings.Options.style.height) == false) {
                            sourceHeight = settings.Options.style.height.match(/\d+/)[0];
                        } else {
                            sourceHeight = chart.chartHeight;
                        }

                        var svg = chart.getSVG({
                            exporting: {
                                sourceWidth: sourceWidth,
                                sourceHeight: sourceHeight
                            }
                        });

                        var $parent = $(window.parent.document);
                        var $iframe = $parent.find('#' + ModuleInfo.FrameId);
                        $iframe.after(svg);
                        $iframe.remove();
                    }
                }
            }
            function buildChartOptions() {
                var hcOptions = angular.copy(settings.Options);
                try {
                    hcOptions.title.style.fontSize += 'px';

                    delete hcOptions.chart.typeId;
                    delete hcOptions.style;

                    if (hcOptions.chart.margin[0] == 0
                        && hcOptions.chart.margin[1] == 0
                        && hcOptions.chart.margin[2] == 0
                        && hcOptions.chart.margin[3] == 0)
                        hcOptions.chart.margin = [null];

                    defaultSeries = angular.copy(hcOptions.series[0]);
                    hcOptions.series = [];
                    hcOptions.yAxis = [hcOptions.yAxis];
                    hcOptions.xAxis.categories = [];

                    /*
                    hcOptions.series.push({
                        type: 'pareto',
                        name: 'Pareto',
                        yAxis: 1,
                        zIndex: 10,
                        baseSeries: 1,
                        tooltip: {
                            valueDecimals: 2,
                            valueSuffix: '%'
                        }
                    });
                    hcOptions.yAxis.push({
                        title: {
                            text: ''
                        },
                        minPadding: 0,
                        maxPadding: 0,
                        max: 100,
                        min: 0,
                        opposite: true,
                        labels: {
                            format: "{value}%"
                        }
                    });
                    hcOptions.series.push({
                        type: 'pareto',
                        name: 'Pareto',
                        yAxis: 1,
                        zIndex: 10,
                        baseSeries: 1,
                        tooltip: {
                            valueDecimals: 2,
                            valueSuffix: '%'
                        }
                    });
                    hcOptions.yAxis.push({
                        title: {
                            text: ''
                        },
                        minPadding: 0,
                        maxPadding: 0,
                        max: 100,
                        min: 0,
                        opposite: true,
                        labels: {
                            format: "{value}%"
                        }
                    }); */
                    
                    if (hcOptions.chart.type == 'pie') {
                        hcOptions.xAxis.type = 'linear';
                    } else {
                        hcOptions.xAxis.type = 'category';
                    }

                    var seriesColors = {};
                    var seriesCharts = {};

                    angular.forEach(defaultSeries.colors, function (value) {
                        if (!angular.isUndefinedOrNull(value.name) && !angular.isUndefinedOrNull(value.color))
                            seriesColors[value.name] = value.color;
                    });

                    angular.forEach(defaultSeries.types, function (value) {
                        if (!angular.isUndefinedOrNull(value.name)) {
                            seriesCharts[value.name] = {
                                type: value.type,
                                color: value.color,
                                zIndex: value.zIndex
                            };
                        }
                    });

                    var pointsColors = {};
                    angular.forEach(defaultSeries.pointsColors, function (value) {
                        if (angular.isUndefinedOrNull(value.name) == false
                            && angular.isUndefinedOrNull(value.color) == false)
                            pointsColors[value.name] = value.color;
                    });

                    var toJavaScriptValue = function (value) {
                        var pattern = /Date\(([^)]+)\)/;
                        var results = pattern.exec(value);
                        if (results != null && results.length > 0) {
                            return parseFloat(results[1]);
                        } else {
                            return value;
                        }
                    };

                    var calcChartData = function (data, func) {
                        var jstat = this.jStat(data);
                        var funcSplit = func.split("|");
                        if (funcSplit.length == 1) {
                            return jstat[funcSplit[0]]();
                        } else {
                            var input = [funcSplit[1]];
                            var result = jstat[funcSplit[0]](input);
                            if (Array.isArray(result))
                                return result[0];
                            else
                                return result;
                        }
                    }

                    var isPieChart = hcOptions.chart.type == 'pie';
                    var isBubbleChart = hcOptions.chart.type == 'bubble';
                    var isWordcloudChart = hcOptions.chart.type == 'wordcloud';
                    var yPropName = isWordcloudChart ? 'weight' : 'y';
                    var disableLegendClick = hcOptions.legend.enabled == true && hcOptions.legend.disableClick == true;

                    // Pie Chart with Series Dropdown
                    if (isPieChart && settings.Options.mics.showSeriesSelector) {
                        var serItem = {
                            data: [],
                            name: settings.CurrentSeries,
                            colorByPoint: defaultSeries.colorByPoint,
                            events: {}
                        };

                        if (disableLegendClick) {
                            serItem.events.legendItemClick = function () {
                                return false;
                            };
                        }

                        for (var i = 0; i < settings.Labels.length; i++) {
                            var label = settings.Labels[i];
                            var labelName = toJavaScriptValue(label.name);

                            var dataItem = {
                                name: labelName,
                                opacity: label.opacity,
                                drilldown: settings.CurrentSeriesIndex + '-' + label.name,
                                events: {}
                            };

                            if (disableLegendClick) {
                                dataItem.events.legendItemClick = function () {
                                    return false;
                                };
                            }

                            if (angular.isUndefinedOrNull(data[i]) == false) {
                                dataItem[yPropName] = data[i];
                                dataItem.y = dataItem[yPropName];
                            }

                            if (angular.isUndefinedOrNull(label.color) == false) {
                                dataItem.color = label.color;
                            }

                            if (hcOptions.xAxis.categories.indexOf(labelName) == -1)
                                hcOptions.xAxis.categories.push(labelName);

                            serItem.data.push(dataItem);
                        }

                        hcOptions.series.push(serItem);

                        for (var j = 0; j < settings.Labels.length; j++) {
                            var dict = {};

                            var label = settings.Labels[j];

                            for (var i = 0; i < label.drillDownData.length; i++) {
                                var ddItem = label.drillDownData[i];
                                if (ddItem.series == settings.CurrentSeriesIndex
                                    && ddItem.data[0] != undefined
                                    && ddItem.data[1] != undefined) {
                                    if (dict[ddItem.series] == undefined) {
                                        dict[ddItem.series] = {
                                            name: settings.Series[ddItem.series],
                                            id: ddItem.series + '-' + label.name,
                                            data: []
                                        };
                                    }

                                    if (ddItem.data[0]) ddItem.data[0] += '';

                                    dict[ddItem.series].data.push(ddItem.data);
                                }
                            }

                            for (key in dict) {
                                var value = dict[key];
                                hcOptions.drilldown.series.push(value);
                            }
                        }
                    } else {

                        for (var sIdx = 0; sIdx < settings.Series.length; sIdx++) {
                            angular.forEach(data[sIdx], function (value, key) {
                                if (data[sIdx][key] != null)
                                    data[sIdx][key] = Number(data[sIdx][key]);
                            });

                            var serItem = {
                                name: settings.Series[sIdx],
                                data: [],
                                colorByPoint: defaultSeries.colorByPoint
                            };

                            if (isWordcloudChart == true) {
                                serItem.type = 'wordcloud';
                            }

                            if (!angular.isUndefinedOrNull(seriesColors[serItem.name])) {
                                serItem.color = seriesColors[serItem.name];
                            }

                            if (!angular.isUndefinedOrNull(seriesCharts[serItem.name])) {
                                if (!angular.isUndefinedOrNull(seriesCharts[serItem.name].type)) {
                                    serItem.type = seriesCharts[serItem.name].type;
                                }

                                if (!angular.isUndefinedOrNull(seriesCharts[serItem.name].color)) {
                                    serItem.color = seriesCharts[serItem.name].color;
                                }

                                if (!angular.isUndefinedOrNull(seriesCharts[serItem.name].zIndex)) {
                                    serItem.zIndex = seriesCharts[serItem.name].zIndex;
                                }
                            }

                            for (var lIdx = 0; lIdx < settings.Labels.length; lIdx++) {
                                var label = settings.Labels[lIdx], name;

                                if (isPieChart && settings.Series.length > 1 && hcOptions.legend.enabled)
                                    name = serItem.name + ' - ' + toJavaScriptValue(label.name);
                                else
                                    name = toJavaScriptValue(label.name);

                                var dataItem = {
                                    name: name,
                                    opacity: label.opacity,
                                    drilldown: label.drillDownData.length > 0 ? sIdx + '-' + label.name : null,
                                    events: {}
                                };

                                if (disableLegendClick) {
                                    dataItem.events.legendItemClick = function () {
                                        return false;
                                    };
                                }

                                if (isBubbleChart == true) {
                                    dataItem.x = name;
                                } else {
                                    dataItem.name = name;
                                }

                                if (!angular.isUndefinedOrNull(data[sIdx][lIdx])) {
                                    dataItem[yPropName] = data[sIdx][lIdx];
                                    dataItem.y = dataItem[yPropName];
                                }

                                if (!angular.isUndefinedOrNull(label.zAxisDataSeries) &&
                                    !angular.isUndefinedOrNull(label.zAxisData)) {
                                    var zDataIdx = label.zAxisDataSeries.indexOf(serItem.name);
                                    dataItem.z = label.zAxisData[zDataIdx];
                                    if ($.isNumeric(dataItem.z)) {
                                        dataItem.z = Number(dataItem.z);
                                    }
                                }

                                if (!angular.isUndefinedOrNull(pointsColors[dataItem.name])) {
                                    dataItem.color = pointsColors[dataItem.name];
                                } else if (!angular.isUndefinedOrNull(label.color)) {
                                    dataItem.color = label.color;
                                }

                                if (additionalDataProps != undefined) {
                                    for (var pIdx = 0; pIdx < additionalDataProps.length; pIdx++) {
                                        dataItem[additionalDataProps[pIdx]] = additionalData[sIdx][pIdx][lIdx];
                                    }
                                }

                                if (hcOptions.xAxis.categories.indexOf(dataItem.name) == -1)
                                    hcOptions.xAxis.categories.push(dataItem.name);

                                serItem.data.push(dataItem);
                            }

                            if (hcOptions.chart.type == 'pie' && settings.Series.length > 1) {
                                var itemSize = 100 / settings.Series.length;
                                serItem.size = (itemSize * (sIdx + 1)) + '%';
                                serItem.innerSize = (itemSize * sIdx) + '%';
                            }

                            hcOptions.series.push(serItem);
                        }

                        for (var j = 0; j < settings.Labels.length; j++) {
                            var dict = {};

                            var label = settings.Labels[j];
                            for (var i = 0; i < label.drillDownData.length; i++) {
                                var ddItem = label.drillDownData[i];
                                if (ddItem.series != undefined
                                    && ddItem.data[0] != undefined
                                    && ddItem.data[1] != undefined) {
                                    if (dict[ddItem.series] == undefined) {
                                        dict[ddItem.series] = {
                                            name: settings.Series[ddItem.series],
                                            id: ddItem.series + '-' + label.name,
                                            data: []
                                        };
                                    }

                                    if (ddItem.data[0]) ddItem.data[0] += '';

                                    dict[ddItem.series].data.push(ddItem.data);
                                }
                            }

                            for (key in dict) {
                                var value = dict[key];
                                hcOptions.drilldown.series.push(value);
                            }
                        }
                    }

                    if (hcOptions.exporting.enabled == true) {
                        if (angular.isUndefinedOrNull(settings._name) == false && settings._name != "") {
                            hcOptions.exporting.filename = settings._name;
                        }

                        if (angular.isUndefinedOrNull(hcOptions.title.text) == false && hcOptions.title.text != "") {
                            hcOptions.exporting.filename = hcOptions.title.text;
                        }

                        hcOptions.exporting.chartOptions = {
                            plotOptions: hcOptions.plotOptions
                        };
                    }

                    var containsHdnSeries = false;
                    for (var idx = 0; idx < hcOptions.series.length; idx++) {
                        var ser = hcOptions.series[idx];
                        if (ser.name == 'hdn') {
                            ser.showInLegend = false;
                            ser._remove = true;
                            containsHdnSeries = true;
                        }
                    }

                    if (containsHdnSeries) {
                        hcOptions.tooltip.additionalDataProps = additionalDataProps;

                        delete hcOptions.tooltip.pointFormat;
                        hcOptions.tooltip.followPointer = true;
                        hcOptions.tooltip.formatter = function () {
                            var getPointCustomFormattedValue = function (item) {
                                var result = '<span style="color:' + item.point.color + '">●</span> ' + item.series.name + ': <b>' + item.y;

                                var additionalDataProps = item.series.chart.options.tooltip.additionalDataProps;
                                if (angular.isUndefinedOrNull(additionalDataProps) == false
                                    && additionalDataProps.length > 0) {
                                    var ar = [];
                                    for (var idx = 0; idx < additionalDataProps.length; idx++) {
                                        ar.push(item.point[additionalDataProps[idx]]);
                                    }
                                    result += ar.join('');
                                }

                                result += '</b><br/>';

                                return result;
                            }

                            if (this.points) {
                                var result = "";
                                var item = {};

                                for (var idx = 0; idx < this.points.length; idx++) {
                                    item = this.points[idx];
                                    if (angular.isUndefinedOrNull(item.series.options._remove)
                                        || item.series.options._remove == false)
                                        result += getPointCustomFormattedValue(item);
                                }

                                return '<span style="font-size: 10px">' + item.key + '</span><br/>' + result;
                            } else {
                                return '<span style="font-size: 10px">' + this.key + '</span><br/>' + getPointCustomFormattedValue(this);
                            }
                        };
                    }

                    hcOptions.plotOptions.pie.innerSize += '%';
                    hcOptions.plotOptions.pie.size += '%';

                    if (!angular.isUndefinedOrNull(hcOptions.drilldown)
                        && !angular.isUndefinedOrNull(hcOptions.drilldown.series)
                        && hcOptions.drilldown.series.length > 0) {
                        delete hcOptions.xAxis.categories;
                    }

                    var chartXData = [], chartYData = [];

                    if (!angular.isUndefinedOrNull(hcOptions.xAxis.categories)) {
                        hcOptions.xAxis.categories.forEach(function (n) {
                            if (angular.isUndefinedOrNull(n) == false) {
                                chartXData.push(n);
                            }
                        });
                    }

                    data.forEach(function (item) {
                        if (angular.isArray(item)) {
                            item.forEach(function (n) {
                                if (angular.isUndefinedOrNull(n) == false) {
                                    chartYData.push(n);
                                }
                            });
                        } else if (angular.isNumber(item)) {
                            chartYData.push(item);
                        }
                    });

                    if (!angular.isUndefinedOrNull(hcOptions.xAxis._plotLines)) {
                        hcOptions.xAxis.plotLines = [];
                        for (var idx = 0; idx < hcOptions.xAxis._plotLines.length; idx++) {
                            var line = hcOptions.xAxis._plotLines[idx];
                            if (line.TypeId == 1) {//fixed value
                                line.Options.value = line.Value;
                            } else if (line.TypeId == 2) { // sql data
                                line.Options.value = settings.PlotLinesData[line.id];
                            } else if (line.TypeId == 3) {
                                line.Options.value = calcChartData(chartXData, line.StatFunction);
                            }

                            if (!angular.isUndefinedOrNull(line.Options.label)
                                && !angular.isUndefinedOrNull(line.Options.label.text)) {
                                line.Options.label.text = Highcharts.format(line.Options.label.text, line.Options);
                            }

                            hcOptions.xAxis.plotLines.push(line.Options);
                        }
                        delete hcOptions.xAxis._plotLines;
                    }

                    var firstYAxis = hcOptions.yAxis[0];
                    if (!angular.isUndefinedOrNull(firstYAxis._plotLines)) {
                        firstYAxis.plotLines = [];
                        for (var idx = 0; idx < firstYAxis._plotLines.length; idx++) {
                            var line = firstYAxis._plotLines[idx];
                            if (line.TypeId == 1) {//fixed value
                                line.Options.value = line.Value;
                            } else if (line.TypeId == 2) { // sql data
                                line.Options.value = settings.PlotLinesData[line.id];
                            } else if (line.TypeId == 3) {
                                line.Options.value = calcChartData(chartYData, line.StatFunction);
                            }

                            if (!angular.isUndefinedOrNull(line.Options.label)
                                && !angular.isUndefinedOrNull(line.Options.label.text)) {
                                line.Options.label.text = Highcharts.format(line.Options.label.text, line.Options);
                            }

                            firstYAxis.plotLines.push(line.Options);
                        }
                        delete firstYAxis._plotLines;
                    }

                    if (isBubbleChart == true) {
                        delete hcOptions.xAxis.categories;
                        delete hcOptions.xAxis.type;
                    }

                    if (angular.isUndefinedOrNull(hcOptions.plotOptions.series.events)) {
                        hcOptions.plotOptions.series.events = {};
                    }

                    if (disableLegendClick) {
                        hcOptions.plotOptions.series.events.legendItemClick = function () {
                            return false;
                        };
                    } else {
                        delete hcOptions.plotOptions.series.events.legendItemClick;
                    }
                } catch (error) {
                    alert(error.message);
                    console.error(error.stack);
                }
                return hcOptions;
            }

            function buildChart() {
                if (angular.isUndefinedOrNull(settings.Options.chart.type)) {
                    alert('This Chart Type is not Supported');
                    return;
                }

                var hcOptions = buildChartOptions();
                highCharts(hcOptions);
            }

            unregSettings = scope.$watch(function () { return scope.settings; }, onSettingsChanged, true);

            scope.$on('onDataChanged', function (e) {
                if (!angular.isUndefinedOrNull(e.targetScope.ctrl.data)) {
                    data = e.targetScope.ctrl.data;
                    buildChart();
                }
                else {
                    onSettingsChanged(e.targetScope.ctrl.settings, settings);
                }
            });
        }
    };
}