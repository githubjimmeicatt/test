WowChartv3_mainAppCtrl.$inject = ['$scope', 'chartService', 'utils', 'toastrService', 'ModuleInfo'];
function WowChartv3_mainAppCtrl($scope, chartService, utils, toastrService, ModuleInfo) {
    var self = this, data;

    self.init = init;
    self.onSeriesChange = onSeriesChange;
    self.loadChart = loadChart;
    self.onChartChange = onChartChange;

    function onChartChange() {
        var settings, chartId;
        if (self.selectedChart) {
            chartId = self.selectedChart.Id;
            settings = angular.fromJson(self.selectedChart.ChartSettings);
        } else {
            settings = utils.getInitialChartSettings();
            chartId = null;
        }
        self.doRefreshChartData = true;
        initChart(chartId, settings);
    }

    function loadChart(reportId, chartPoint, filters) {
        if (!angular.isUndefinedOrNull(reportId)) {
            self.reportId = reportId;
            delete self.chartId;
        } else {
            self.reportId = null;
        }

        if (!angular.isUndefinedOrNull(chartPoint)) self.chartPoint = chartPoint; else self.chartPoint = null;
        if (!angular.isUndefinedOrNull(filters)) self.filters = filters; else self.filters = null;

        self.doRefreshChartData = true;
        init();
    }
    function onSeriesChange() {
        self.data = data[self.currentSeries];

        var settings = self.settings;
        settings.CurrentSeries = settings.Series[self.currentSeries];
        settings.CurrentSeriesIndex = self.currentSeries;

        $scope.$broadcast('onDataChanged');
    }
    function initChart(chartId, settings) {
        delete self.settings;

        self.chartId = chartId;

        if (settings.Options.chart.typeId == null) {
            self.emptyData = true;
            settings.Options = utils.getInitialChartOptions();
            self.settings = settings;
            return;
        }

        settings.Options = angular.deepExtend(utils.getInitialChartOptions(), settings.Options);

        if (settings.Options.series[0].colors == undefined) settings.Options.series[0].colors = [];
        if (settings.Options.series[0].pointsColors == undefined) settings.Options.series[0].pointsColors = [];

        if (settings.DataSource == undefined || settings.DataSource == null || settings.DataSource == 1) {
            self.emptyData = utils.isEmptyData(settings);

            if (settings.Options.mics.showSeriesSelector && settings.Series.length > 0) {
                self.currentSeries = 0;
                data = angular.copy(settings.Data);

                settings.Data = data[0];
                settings.CurrentSeries = settings.Series[0];
                settings.CurrentSeriesIndex = 0;
            }
            self.settings = settings;
        } else {
            var requestInput = {};
            if (!angular.isUndefinedOrNull(self.chartId)) requestInput.chartId = self.chartId;
            if (!angular.isUndefinedOrNull(self.reportId)) requestInput.reportId = self.reportId;
            if (!angular.isUndefinedOrNull(self.filters)) requestInput.filters = self.filters;
            if (!angular.isUndefinedOrNull(self.chartPoint)) requestInput.chartPoint = self.chartPoint;

            self.appPromise = chartService.getChartData(requestInput);
            utils.ajaxSuccess(self.appPromise, function (response) {
                var result = response.data;
                if (!angular.isUndefinedOrNull(result.d)
                    && !angular.isUndefinedOrNull(result.d.Error)) {
                    toastrService.error(result.d.Error);
                    self.emptyData = true;
                    return;
                }

                var chartData = result.d.ChartData;
                if (!angular.isUndefinedOrNull(chartData)
                    && !angular.isUndefinedOrNull(chartData.Error)) {
                    toastrService.error(chartData.Error);
                    self.emptyData = true;
                    return;
                }

                settings = angular.fromJson(result.d.ChartSettings);
                settings.Labels = chartData.Labels;
                settings.Series = chartData.Series;
                settings.PlotLinesData = result.d.PlotLinesData;

                self.emptyData = utils.isEmptyData(chartData);

                if (settings.Options.mics.showSeriesSelector && settings.Series.length > 0) {
                    self.currentSeries = 0;
                    data = chartData.Data;

                    settings.Data = data[0];
                    settings.CurrentSeries = settings.Series[0];
                    settings.CurrentSeriesIndex = 0;
                } else {
                    settings.Data = chartData.Data;
                }

                settings.AdditionalDataProps = chartData.AdditionalDataProps;
                settings.AdditionalData = chartData.AdditionalData;
                settings._name = result.d.Name;

                self.settings = settings;
                if (self.doRefreshChartData == true) {
                    $scope.$broadcast('onDataChanged');
                    delete self.doRefreshChartData;
                }
            });
        }
    }
    function init() {
        if (ModuleInfo.PreviewMode == true
            && !angular.isUndefinedOrNull(ModuleInfo.ChartId)
            && ModuleInfo.ChartId != '') {
            self.chartId = ModuleInfo.ChartId;
        }

        self.appPromise = chartService.getChartSetting(self.chartId, self.reportId, ModuleInfo.PreviewMode);
        utils.ajaxSuccess(self.appPromise, function (response) {
            var result = response.data;

            if (!angular.isUndefinedOrNull(result.d)
                && !angular.isUndefinedOrNull(result.d.Error)) {
                toastrService.error(result.d.Error);
                return;
            }

            self.charts = result.d.Charts;
            if (result.d.ChartId > 0) {
                for (var idx = 0; self.charts.length; idx++) {
                    if (self.charts[idx].Id == result.d.ChartId) {
                        self.selectedChart = self.charts[idx];
                        break;
                    }
                }
            }

            if (!angular.isUndefinedOrNull(self.selectedChart)) {
                var settings = angular.fromJson(self.selectedChart.ChartSettings);
                initChart(self.selectedChart.Id, settings);
            } else {
                var settings = utils.getInitialChartSettings();
                initChart(null, settings);
            }
        });
    }
}