WowChartv2_mainAppCtrl.$inject = ['$scope', '$rootScope', '$location', 'authentication', 'chartService', 'pageService', 'toastrService', 'utils'];
function WowChartv2_mainAppCtrl($scope, $rootScope, $location, authentication, chartService, pageService, toastrService, utils) {
    var self = this;
    self.init = init;
    self.isThisUrl = isThisUrl;

    function init() {
        self.mainView = true;
        self.page = pageService;
        $rootScope.$on('$routeChangeStart', routeChangeStart);

        self.appPromise = chartService.getChartSetting();
        utils.ajaxSuccess(self.appPromise, function (response) {
            var result = response.data;

            if (!angular.isUndefinedOrNull(result.d)
                && !angular.isUndefinedOrNull(result.d.Error)) {
                toastrService.error(result.d.Error);
                return;
            }

            $rootScope.ChartTypes = result.d.ChartTypes;
            $scope.$broadcast('OnChartTypesChanged', result.d.ChartTypes);

            var settings;
            if (result.d.Options) {
                settings = angular.fromJson(result.d.Options);

                var dsSettings = angular.fromJson(result.d.DataSourceSettings);
                settings.DataSource = dsSettings.DataSource;
                settings.DataSourceInfo = dsSettings.DataSourceInfo;
                settings.DataSourceInfos = dsSettings.DataSourceInfos;
                settings.FileDataSourceInfo = dsSettings.FileDataSourceInfo;

                delete dsSettings;
            } else {
                settings = utils.getInitialChartSettings();
            }

            settings.Options = angular.deepExtend(utils.getInitialChartOptions(), settings.Options);
            settings.Folders = result.d.Folders;
            settings.PreviewHtml = result.d.PreviewHtml;
            settings.DataTables = result.d.DataTables;

            if (settings.Options.series[0].colors == undefined) settings.Options.series[0].colors = [];
            if (settings.Options.series[0].pointsColors == undefined) settings.Options.series[0].pointsColors = [];

            $rootScope.ChartSettings = settings;
            $scope.$broadcast('onChartSettingsChanged', settings);
        });
    }
    function isThisUrl(url) {
        return $location.path().endsWith(url);
    }
    function routeChangeStart(event, next) {
        if (authentication.authenticate(next.access) == false) {
            $location.path('/Unauthorized');
            return;
        } else if (authentication.authorize(next.access) == false) {
            $location.path('/Unauthorized');
            return;
        }
    }
}