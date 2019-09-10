WowChartv2_previewCtrl.$inject = ['$rootScope', '$scope', 'chartService', 'utils', 'pageService', 'toastrService'];
function WowChartv2_previewCtrl($rootScope, $scope, chartService, utils, pageService, toastrService) {
    var self = this, data;

    self.init = init;
    self.onSeriesChange = onSeriesChange;

    function onSeriesChange() {
        self.data = data[self.currentSeries];

        var settings = self.settings;
        settings.CurrentSeries = settings.Series[self.currentSeries];
        settings.CurrentSeriesIndex = self.currentSeries;

        $scope.$broadcast('onDataChanged', self.data);
    }
    function setChartSettings(event, settings) {

        if (settings.Options.chart.typeId == null) {
            self.emptyData = true;
            settings.Options = utils.getInitialChartOptions();
            self.settings = settings;
            return;
        }

        if (settings.DataSource == undefined || settings.DataSource == null || settings.DataSource == 1) {
            self.emptyData = utils.isEmptyData(settings);

            var _settings = angular.deepExtend({}, settings);
            if (_settings.Options.mics.showSeriesSelector && _settings.Series.length > 0) {
                self.currentSeries = 0;
                data = angular.copy(_settings.Data);

                _settings.Data = data[0];
                _settings.CurrentSeries = _settings.Series[0];
                _settings.CurrentSeriesIndex = 0;
            }
            self.settings = _settings;
        } else {
            self.appPromise = chartService.getChartData();
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
            });
        }
    }
    function init() {
        pageService.setTitle(null);
        $scope.$on('onChartSettingsChanged', setChartSettings);

        if ($rootScope.ChartSettings)
            setChartSettings(null, $rootScope.ChartSettings);
    }

}