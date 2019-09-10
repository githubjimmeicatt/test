WowChartv2_mainAppCtrl.$inject = ['$scope', 'chartService', 'utils', 'toastrService'];
function WowChartv2_mainAppCtrl($scope, chartService, utils, toastrService) {
    var self = this, data;

    self.init = init;
    self.onSeriesChange = onSeriesChange;
    self.refreshChartData = refreshChartData;

    function refreshChartData(filters) {
        self.filters = filters;
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
    function setChartSettings(settings) {

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
            self.appPromise = chartService.getChartData(self.filters);
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

                self.settings = settings;
                if (self.doRefreshChartData == true) {
                    $scope.$broadcast('onDataChanged');
                    delete self.doRefreshChartData;
                }
            });
        }
    }
    function init() {
        self.appPromise = chartService.getChartSetting();
        utils.ajaxSuccess(self.appPromise, function (response) {
            var result = response.data;

            if (!angular.isUndefinedOrNull(result.d)
                && !angular.isUndefinedOrNull(result.d.Error)) {
                toastrService.error(result.d.Error);
                return;
            }

            var settings;
            if (result.d.Options) {
                settings = angular.fromJson(result.d.Options);
            } else {
                settings = utils.getInitialChartSettings();
            }

            setChartSettings(settings);
        });
    }
}